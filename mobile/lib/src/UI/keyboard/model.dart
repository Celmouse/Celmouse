import 'package:flutter/material.dart';
import 'package:protocol/protocol.dart';

enum KeyType {
  normal(Colors.grey),
  special(Colors.red),
  aderence(Colors.yellow);

  const KeyType(this.color);
  final Color color;
}

class MKey {
  final String? label;
  final IconData? icon;
  final KeyType type;
  final int flex;
  final SpecialKeyType? specialKeyType;

  MKey({
    this.label,
    this.icon,
    this.type = KeyType.normal,
    this.flex = 1,
    this.specialKeyType,
  });
}
