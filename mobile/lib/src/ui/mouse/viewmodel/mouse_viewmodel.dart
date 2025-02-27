import 'package:controller/src/data/repositories/connection_repository.dart';
import 'package:controller/src/data/repositories/mouse_repository.dart';
import 'package:flutter/material.dart';

class MouseViewmodel {
  final MouseRepository _mouseRepository;
  final ConnectionRepository _connectionRepository;

  MouseViewmodel(
    this._connectionRepository, {
    required MouseRepository mouseRepository,
  }) : _mouseRepository = mouseRepository;

  ValueNotifier<bool> get isKeyboardOpen => _isKeyboardOpen;
  final ValueNotifier<bool> _isKeyboardOpen = ValueNotifier(false);

  void closeKeyboard() {
    isKeyboardOpen.value = false;
  }

  void openKeyboard() {
    isKeyboardOpen.value = true;
  }

  void disableMouse() {
    _mouseRepository.disableMovement();
    _mouseRepository.disableScrolling();
  }

  void reconnect() {
    _connectionRepository.reconnect();
  }

  void disconnect() {
    _connectionRepository.disconnect();
  }

  void dispose() {
    _isKeyboardOpen.dispose();
  }

}
