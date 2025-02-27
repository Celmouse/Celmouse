import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:protocol/protocol.dart';

const ALLOW_PRINTING = false;

class ConnectionService {
  Future<Stream<WebSocket>> createServer() async {
    final server = await HttpServer.bind('0.0.0.0', 7771);
    return server.transform(WebSocketTransformer());
  }

  Future<List<String>> getAvailableIPs() async {
    final availableIPs = <String>[];
    final ips = await NetworkInterface.list();
    for (var i in ips) {
      for (var a in i.addresses) {
        availableIPs.add(a.address);
      }
    }
    return availableIPs;
  }

  handleProtocolEvents(
    String event,
    WebSocket socket, {
    required Function(MouseButtonProtocolData) onMouseClick,
    required Function() onMouseHold,
    required Function() onMouseRelease,
    required Function(MouseButtonProtocolData) onMouseDoubleClick,
    required Function(MouseMovementProtocolData) onMouseMove,
    required Function(MouseMovementProtocolData) onMouseScroll,
    required Function(String) onKeyPressed,
    required Function(String) onKeyReleased,
    required Function(KeyboardProtocolData) onSpecialKeyPressed,
    required Function(KeyboardProtocolData) onSpecialKeyReleased,
    required VoidCallback onConnected,
    required VoidCallback onDisconnected,
    required Future<ConnectionInfoProtocolData> Function() onSendDesktopInfo,
  }) async {
    final protocol = Protocol.fromJson(jsonDecode(event));
    final protocolEvent = protocol.event;

    if (ALLOW_PRINTING && kDebugMode) {
      debugPrint(protocolEvent.toString());
      debugPrint(protocol.data.toString());
      debugPrint(protocol.timestamp.toString());
    }

    switch (protocolEvent) {
      case ProtocolEvent.mouseMove:
        {
          final data = MouseMovementProtocolData.fromJson(protocol.data);

          return onMouseMove(data);
        }
      case ProtocolEvent.mouseCenter:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ProtocolEvent.mouseScroll:
        {
          final data = MouseMovementProtocolData.fromJson(protocol.data);

          return onMouseScroll(data);
        }
      case ProtocolEvent.mouseClick:
        {
          final data = MouseButtonProtocolData.fromJson(protocol.data);

          return onMouseClick(data);
        }
      case ProtocolEvent.mouseDoubleClick:
        {
          final data = MouseButtonProtocolData.fromJson(protocol.data);

          return onMouseDoubleClick(data);
        }
      case ProtocolEvent.mouseButtonHold:
        {
          return onMouseHold();
        }
      case ProtocolEvent.mouseButtonReleased:
        {
          return onMouseRelease();
        }
      case ProtocolEvent.keyPressed:
        {
          final data = protocol.data as String;

          return onKeyPressed(data);
        }
      case ProtocolEvent.specialKeyPressed:
        {
          final data = KeyboardProtocolData.fromJson(protocol.data);

          return onSpecialKeyPressed(data);
        }
      case ProtocolEvent.specialKeyReleased:
        {
          final data = KeyboardProtocolData.fromJson(protocol.data);

          return onSpecialKeyReleased(data);
        }
      case ProtocolEvent.connect:
        {
          return onConnected();
        }
      case ProtocolEvent.disconnect:
        {
          return onDisconnected();
        }
      case ProtocolEvent.ping:
        {
          // final m = MobileToDesktopData.fromJson(protocol.data);
          // print(m);

          final data = await onSendDesktopInfo();
          // final data = await getDeviceInfo();
          socket.add(
            jsonEncode(
              Protocol(
                event: ProtocolEvent.ping,
                data: data,
                timestamp: DateTime.timestamp(),
              ),
            ),
          );
        }
    }
  }
}
