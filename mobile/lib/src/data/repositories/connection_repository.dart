import 'dart:async';
import 'package:controller/src/data/services/connection_service.dart';
import 'package:controller/src/data/services/client_api_service.dart';
import 'package:controller/src/domain/models/devices.dart';
import 'package:controller/src/utils/result.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectionRepository {
  final ConnectionService _connectionService;
  final ClientApiService _clientApiService;

  ConnectionRepository({
    required ConnectionService connectionService,
    required ClientApiService clientApiService,
  })  : _connectionService = connectionService,
        _clientApiService = clientApiService;

  WebSocketChannel? _socket;

  WebSocketChannel get socket => _socket!;

  Future<Result<void>> connect(String ip) async {
    try {
      _socket = await _connectionService.connect(ip, 7771);
      _clientApiService.setChannel(_socket!);
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> disconnect() async {
    if (!await isConnected) return Result.error(Exception('Not connected'));
    try {
      await _connectionService.disconnect(_socket!);
      _clientApiService.clearChannel();
      _socket = null;
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<bool> get isConnected async {
    await _socket?.ready;
    return _socket != null;
  }

  Stream<List<Device>> scanDevices() => _connectionService.scanStream;

  void startScan() => _connectionService.startScan();

  void stopScan() => _connectionService.stopScan();

  Future<void> reconnect() async {
    if (_socket != null) return;
    _socket = await _connectionService.reconnect();
    if (_socket != null) {
      _clientApiService.setChannel(_socket!);
    }
  }
}
