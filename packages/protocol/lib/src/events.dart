
import 'package:json_annotation/json_annotation.dart';

enum ProtocolEvent {
  // Connection
  @JsonValue('ConnectionConnect')
  connect,
  @JsonValue('ConnectionDisconnect')
  disconnect,
  @JsonValue('ConnectionPing')
  /// Send information to the device.
  ping,
  // // Delete those
  // @JsonValue('ConnectionInfo')
  // connectionInfo,
  // @JsonValue('ConnectionStatus')
  // connectionStatus,
  // @JsonValue('DesktopToMobileData')
  // desktopToMobileData,
  // @JsonValue('MobileToDesktopData')
  // mobileToDesktopData,

  // Mouse
  @JsonValue('MouseMove')
  mouseMove,
  @JsonValue('MouseCenter')
  mouseCenter,
  @JsonValue('MouseScroll')
  mouseScroll,
  @JsonValue('MouseClick')
  mouseClick,
  @JsonValue('MouseDoubleClick')
  mouseDoubleClick,
  @JsonValue('MouseButtonHold')
  mouseButtonHold,
  @JsonValue('MouseButtonReleased')
  mouseButtonReleased,

  // Keyboard
  @JsonValue('keyPressed')
  keyPressed,
  @JsonValue('specialKeyPressed')
  specialKeyPressed,
  @JsonValue('specialKeyReleased')
  specialKeyReleased,
}
