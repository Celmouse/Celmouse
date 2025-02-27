import 'dart:async';
import 'dart:convert';
import 'package:controller/src/domain/models/devices.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:protocol/protocol.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectionService {
  final List<Device> _devices = [];
  final StreamController<List<Device>> _scanController =
      StreamController.broadcast();
  Stream<List<Device>> get scanStream => _scanController.stream;

  bool _stopScan = false;
  @Deprecated("ÏServices doesn't have state! REMOVE THIS")
  String? _lastIp;
  @Deprecated("ÏServices doesn't have state! REMOVE THIS")
  int? _lastPort;

  Future<void> stopScan() async {
    _stopScan = true;
  }

  Future<void> startScan([int retryInterval = 5, int retryCount = 100]) async {
    for (int count = 0; count < retryCount; count++) {
      await _scan();
      await Future.delayed(Duration(seconds: retryInterval));
      if (_stopScan) break;
    }
  }

  Future<void> _scan() async {
    Completer completer = Completer();
    if (_stopScan) return;

    final info = NetworkInfo();
    final String? ip = await info.getWifiIP();
    const port = 7771;

    int sum = sumPort(254, 2);

    final subnet = ip?.substring(0, ip.lastIndexOf('.'));
    for (int i = 2; i < 255; i++) {
      final host = '$subnet.$i';
      pingServer(host, port).then((_) {
        sum -= i;
        if (sum <= 0) {
          completer.complete();
        }
      }, onError: (e) {
        sum -= i;
        if (sum <= 0) {
          completer.complete();
        }
      });
    }

    await completer.future;
  }

  Future<WebSocketChannel> connect(String ip, int port) async {
    final channel = getChannel(ip, port);

    channel.sink.add(jsonEncode(
      Protocol(
        event: ProtocolEvent.connect,
        data: null,
        timestamp: DateTime.timestamp(),
      ).toJson(),
    ));

    _lastIp = ip;
    _lastPort = port;
    return channel;
  }

  Future<void> disconnect(WebSocketChannel channel) async {
    channel.sink.add(jsonEncode(
      Protocol(
        event: ProtocolEvent.disconnect,
        data: null,
        timestamp: DateTime.timestamp(),
      ).toJson(),
    ));
    await channel.sink.close();
  }

  Future<WebSocketChannel> reconnect() async {
    if (_lastIp == null || _lastPort == null) {
      throw Exception('No previous connection information available');
    }
    return connect(_lastIp!, _lastPort!);
  }

  Future<void> pingServer(String ip, int port) async {
    final channel = getChannel(ip, port);
    await channel.ready.timeout(const Duration(seconds: 4));

    channel.stream.listen((event) {
      final p = Protocol.fromJson(jsonDecode(event));
      final e = ConnectionInfoProtocolData.fromJson(p.data);
      _addDevice(Device(
        name: e.deviceName,
        ip: ip,
        port: port,
      ));
    });

    channel.sink.add(jsonEncode(
      Protocol(
        timestamp: DateTime.timestamp(),
        event: ProtocolEvent.ping,
        data: null, // MobileToDesktopData(message: ''),
      ),
    ));

    Timer(const Duration(seconds: 1), () {
      channel.sink.close();
    });
  }

  void _addDevice(Device device) {
    if (_devices.map<String>((e) => e.ip).contains(device.ip)) return;
    _devices.add(device);
    _scanController.add(_devices);
  }

  int sumPort(int port, int min) {
    if (port == min) {
      return min;
    }
    return port + sumPort(port - 1, min);
  }

  WebSocketChannel getChannel(String ip, int port) {
    final uri = Uri.parse('ws://$ip:$port');
    final con = WebSocketChannel.connect(uri);
    return con;
  }
}
