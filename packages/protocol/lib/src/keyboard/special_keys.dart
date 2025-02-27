import 'package:json_annotation/json_annotation.dart';

// TODO: Add platform specific keys (MacSpecialKeys) etc...
enum SpecialKeyType {
  @JsonValue('Enter')
  Enter('Enter'),
  @JsonValue('Tab')
  Tab('Tab'),
  @JsonValue('Space')
  Space('Space'),
  @JsonValue('Backspace')
  Backspace('Backspace'),
  @JsonValue('Escape')
  Escape('Escape'),
  @JsonValue('MetaLeft')
  MetaLeft('MetaLeft'),
  @JsonValue('ShiftLeft')
  ShiftLeft('ShiftLeft'),
  @JsonValue('ShiftRight')
  ShiftRight('ShiftRight'),
  @JsonValue('CapsLock')
  CapsLock('CapsLock'),
  @JsonValue('AltLeft')
  AltLeft('AltLeft'),
  @JsonValue('AltRight')
  AltRight('AltRight'),
  @JsonValue('ControlLeft')
  ControlLeft('ControlLeft'),
  @JsonValue('ControlRight')
  ControlRight('ControlRight'),
  @JsonValue('ArrowLeft')
  ArrowLeft('ArrowLeft'),
  @JsonValue('ArrowRight')
  ArrowRight('ArrowRight'),
  @JsonValue('ArrowDown')
  ArrowDown('ArrowDown'),
  @JsonValue('ArrowUp')
  ArrowUp('ArrowUp'),

  @JsonValue('VolumeUp')
  VolumeUp('VolumeUp'),

  @JsonValue('VolumeDown')
  VolumeDown('VolumeDown'),

  @JsonValue('VolumeMute')
  VolumeMute('VolumeMute');

  const SpecialKeyType(this.value);

  final String value;
}
