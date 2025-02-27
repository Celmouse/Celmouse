import 'dart:async';
import 'package:controller/src/data/repositories/mouse_repository.dart';
import 'package:flutter/material.dart';
import 'package:protocol/protocol.dart';

class LeftButtonViewmodel extends ChangeNotifier {
  final MouseRepository _mouseRepository;

  LeftButtonViewmodel({
    required MouseRepository mouseRepository,
  }) : _mouseRepository = mouseRepository;

  bool _isPressed = false;

  bool get isPressed => _isPressed;

  Timer? doubleClickTimer;

  void hold() {
    _mouseRepository.hold();
    _isPressed = true;
    notifyListeners();
  }

  void release() {
    _mouseRepository.release();
    _isPressed = false;
    notifyListeners();
  }

  void click() {
    _isPressed = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 100), () {
      _isPressed = false;
      notifyListeners();
    });

    // if (doubleClickTimer?.isActive == false) {
    _mouseRepository.click(MouseButton.left);
    // } else {
    //   _mouseRepository.doubleClick();
    // }

    // doubleClickTimer ??= Timer(
    //     Duration(
    //       milliseconds: getIt.get<MouseSettings>().doubleClickDelayMS.duration,
    //     ), () {
    //   doubleClickTimer = null;
    // });
  }

  // }
}
