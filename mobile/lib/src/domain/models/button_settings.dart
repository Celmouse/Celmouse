import 'package:flutter/material.dart';

class ButtonSettings {
  final double width;
  final double height;
  final MaterialColor color;
  final BorderRadius? borderRadius;

  ButtonSettings({
    required this.width,
    required this.height,
    required this.color,
    this.borderRadius,
  });
}
