import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:result_dart/result_dart.dart';
import 'package:server/src/data/services/connection_service.dart';
import 'package:server/src/data/services/device_info_service.dart';
import 'package:server/src/data/services/mouse_service.dart';
import 'services/keyboard_service.dart';

const ALLOW_PRINTING = false;

class SocketRepository {
  final MouseService _mouseService;
  final KeyboardService _keyboardService;
  final ConnectionService _connectionService;
  final DeviceInfoService _deviceInfoService;

  late WebSocket socket;

  SocketRepository({
    required MouseService mouseService,
    required KeyboardService keyboardService,
    required ConnectionService connectionService,
    required DeviceInfoService deviceInfoService,
  })  : _mouseService = mouseService,
        _keyboardService = keyboardService,
        _deviceInfoService = deviceInfoService,
        _connectionService = connectionService;

  Future<Result<List<String>>> fetchIPList() async {
    try {
      return Success(await _connectionService.getAvailableIPs());
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  void close() {
    socket.close();
  }

  void createSocket({
    required VoidCallback onConnected,
    required VoidCallback onDisconnected,
    required Function(dynamic) onError,
  }) async {
    final server = await _connectionService.createServer();
    server.listen((webSocket) {
      // This enables multiple connections?
      socket = webSocket;
      webSocket.listen(
        (data) {
          _listenSocket(
            data,
            onConnected,
            onDisconnected,
          );
        },
        onError: onError,
        cancelOnError: true,
        onDone: onDisconnected,
      );
    });
  }

  _listenSocket(
    dynamic data,
    VoidCallback onConnected,
    VoidCallback onDisconnected,
  ) =>
      _connectionService.handleProtocolEvents(
        data,
        socket,
        onConnected: onConnected,
        onDisconnected: onDisconnected,
        onSendDesktopInfo: () async {
          final info = await _deviceInfoService.getDeviceInfo();
          return info;
        },
        onMouseHold: _mouseService.holdLeftButton,
        onMouseRelease: _mouseService.releaseLeftButton,
        onMouseMove: (data) {
          double x = data.x;
          double y = data.y;
          double sense = data.intensity;

          return _mouseService.move(x, y, sense);
        },
        onMouseScroll: (data) {
          _mouseService.scroll(
            data.x.sign.ceil(),
            data.y.sign.ceil(),
            data.intensity.round(),
          );
        },
        onMouseClick: (data) => _mouseService.click(data.type),
        onMouseDoubleClick: (data) => _mouseService.doubleClick(data.type),
        onKeyPressed: _keyboardService.type,
        onKeyReleased: _keyboardService.releaseKey,
        onSpecialKeyPressed: (data) => _keyboardService.pressSpecial(data.key),
        onSpecialKeyReleased: (data) =>
            _keyboardService.releaseSpecial(data.key),
      );
}
