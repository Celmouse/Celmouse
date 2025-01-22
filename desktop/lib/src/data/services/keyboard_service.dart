import 'dart:async';

import 'package:flutter/services.dart';
import 'package:keyboard/keyboard.dart';
import 'package:protocol/protocol.dart';

class KeyboardService {
  final keyboard = Keyboard();
  final _channel = KeyboardPlatformChannel();

  void type(String key) {
    
    _channel.pressKey(key);

    // Timer(const Duration(milliseconds: 200), () {
    //   // keyboard.releaseKey(key);
    // });
  }

  void pressSpecial(SpecialKeyType key) {
    // _channel.pressSpecialKey(key);
  }

  void releaseSpecial(SpecialKeyType key) {
    // _channel.releaseSpecialKey(key);
  }
}

class KeyboardPlatformChannel {
  static const channel = MethodChannel('com.celmouse.plugins/keyboard');

  Future<void> pressKey(String key) async {
    await channel.invokeMethod('pressKey', key);
  }

  Future<void> pressSpecialKey(String key) async {
    await channel.invokeMethod('pressSpecialKey', key);
  }
}
