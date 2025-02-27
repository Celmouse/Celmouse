import 'package:json_annotation/json_annotation.dart';

enum MouseButton {
  @JsonValue("left")
  left,
  @JsonValue("right")
  right,
  @JsonValue("center")
  center;

  int get value => MouseButton.values.indexOf(this);
}
