import 'package:controller/src/data/repositories/mouse_repository.dart';
import 'package:flutter/material.dart';
import 'package:protocol/protocol.dart';

class RightButtonViewmodel extends ChangeNotifier {
  final MouseRepository _mouseRepository;

  RightButtonViewmodel({
    required MouseRepository mouseRepository,
  }) : _mouseRepository = mouseRepository;

  bool _isPressed = false;

  bool get isPressed => _isPressed;

  void click() async {
    _isPressed = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 100), () {
      _isPressed = false;
      notifyListeners();
    });

    _mouseRepository.click(MouseButton.right);

  }
}
