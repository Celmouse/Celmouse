import 'package:json_annotation/json_annotation.dart';

enum DeviceOS {
  @JsonValue("windows")
  windows,
  @JsonValue("linux")
  linux,
  @JsonValue("macos")
  macos,
  @JsonValue("unknown")
  unknown;
}

enum ConnectionStatus {
  @JsonValue("connected")
  connected,
  @JsonValue("disconnected")
  disconnected,
  @JsonValue("unknown")
  unknown;
}

enum ConnectionType {
  @JsonValue("wifi")
  wifi,
  @JsonValue("bluetooth")
  bluetooth,
  @JsonValue("usb")
  usb,
  @JsonValue("unknown")
  unknown;
}
