import 'dart:convert';
import 'package:protocol/protocol.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ClientApiService {
  WebSocketChannel? _socket;

  ClientApiService();

  void setChannel(WebSocketChannel socket) {
    _socket = socket;
  }

  void clearChannel() {
    _socket = null;
  }

  void send({required ProtocolEvent event, dynamic data}) {
    if (_socket == null) {
      throw UnimplementedError("Socket is null");
    }

    final protocol = Protocol(
      event: event,
      data: data,
      timestamp: DateTime.now(),
    );
    final map = protocol.toJson();
    final json = jsonEncode(map);

    try {
      _socket?.sink.add(json);
    } catch (e) {
      rethrow;
    }
  }
}
