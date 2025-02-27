import 'dart:async';

import 'package:flutter/services.dart';
import 'package:protocol/protocol.dart';

class KeyboardService {
  final _channel = KeyboardPlatformChannel();

  void type(String key) {
    _channel.pressKey(key);
    _channel.releaseKey(key);
  }

  void pressKey(String key) {
    _channel.pressKey(key);
  }

  void releaseKey(String key) {
    _channel.releaseKey(key);
  }

  void pressSpecial(SpecialKeyType key) {
    _channel.pressSpecialKey(key.value);
    //TODO: Remove this when release is allowed
    releaseSpecial(key);
  }

  void releaseSpecial(SpecialKeyType key) {
    _channel.releaseSpecialKey(key.value);
  }
}

class KeyboardPlatformChannel {
  static const channel = MethodChannel('com.celmouse.plugins/keyboard');

  Future<void> pressKey(String key) async {
    await channel.invokeMethod('pressKey', key);
  }

  Future<void> releaseKey(String key) async {
    await channel.invokeMethod('releaseKey', key);
  }

  Future<void> pressSpecialKey(String key) async {
    final swiftKey = await channel.invokeMethod('convertDartKeyToSwift', key);
    await channel.invokeMethod('pressSpecialKey', swiftKey);
  }

  Future<void> releaseSpecialKey(String key) async {
    final swiftKey = await channel.invokeMethod('convertDartKeyToSwift', key);
    await channel.invokeMethod('releaseSpecialKey', swiftKey);
  }
}
