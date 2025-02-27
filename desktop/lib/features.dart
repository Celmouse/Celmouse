import 'package:json_annotation/json_annotation.dart';

part 'features.g.dart';

@JsonSerializable()
class AvaliableFeatures {
  final bool keyboard;
  final bool mouse;
  final bool touchpad;
  final bool remote;

  AvaliableFeatures({
    required this.keyboard,
    required this.mouse,
    required this.touchpad,
    required this.remote,
  });
}

class MacOSAvaliableFeatures extends AvaliableFeatures {
  MacOSAvaliableFeatures({
    super.keyboard = true,
    super.mouse = true,
    super.touchpad = true,
    super.remote = false,
  });
}

class WindowsAvaliableFeatures extends AvaliableFeatures {
  WindowsAvaliableFeatures({
    super.mouse = true,
    super.touchpad = true,
    super.keyboard = false,
    super.remote = false,
  });
}

class LinuxAvaliableFeatures extends AvaliableFeatures {
  LinuxAvaliableFeatures({
    super.mouse = false,
    super.touchpad = false,
    super.keyboard = false,
    super.remote = false,
  });
}
