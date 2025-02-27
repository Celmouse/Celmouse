import 'package:controller/src/data/repositories/mouse_repository.dart';
import 'package:flutter/material.dart';
import 'package:protocol/protocol.dart';

class TrackPadViewModel extends ChangeNotifier {
  final MouseRepository _mouseRepository;

  TrackPadViewModel({
    required MouseRepository mouseRepository,
  }) : _mouseRepository = mouseRepository; // Previous position

  bool _isDragging = false;
  bool _isTapped = false;
  bool _isDoubleTapped = false;
  bool _isTwoFingerTapped = false;
  double _mouseX = 200; // Initial center position
  double _mouseY = 200; // Initial center position
  double _previousX = 200; // Previous position
  double _previousY = 200;

  bool get isDragging => _isDragging;
  bool get isTapped => _isTapped;
  bool get isDoubleTapped => _isDoubleTapped;
  bool get isTwoFingerTapped => _isTwoFingerTapped;
  double get mouseX => _mouseX;
  double get mouseY => _mouseY;

  Color get backgroundColor {
    if (_isDragging) return Colors.grey[300]!;
    if (_isTapped) return Colors.green[100]!;
    if (_isDoubleTapped) return Colors.red[100]!;
    if (_isTwoFingerTapped) return Colors.yellow[100]!;
    return Colors.grey[200]!;
  }

  Color get dotColor {
    if (_isDragging) return Colors.blue;
    if (_isTapped) return Colors.green;
    if (_isDoubleTapped) return Colors.red;
    if (_isTwoFingerTapped) return Colors.yellow;
    return Colors.grey[400]!;
  }

  void startDragging(double x, double y) {
    _isDragging = true;
    _previousX = _mouseX;
    _previousY = _mouseY;
    _mouseX = x;
    _mouseY = y;
    notifyListeners();
  }

  void updateDragging(double deltaX, double deltaY) {
    _mouseX = (_previousX + deltaX).clamp(0.0, 400.0); // Ensure within bounds
    _mouseY = (_previousY + deltaY).clamp(0.0, 400.0); // Ensure within bounds
    _previousX = _mouseX;
    _previousY = _mouseY;
    notifyListeners();
    // if(!_isDragging) return;
    _mouseRepository.handleDrag(deltaX, deltaY);
  }

  void stopDragging() {
    _isDragging = false;
    _previousX = _mouseX;
    _previousY = _mouseY;
    _mouseX = 200; // Re-center
    _mouseY = 200; // Re-center
    notifyListeners();
  }

  void handleTap() {
    _isTapped = true;
    notifyListeners();
    _mouseRepository.click(MouseButton.left);
    _resetTapState();
  }

  void handleDoubleTap() {
    _isDoubleTapped = true;
    notifyListeners();
    _mouseRepository.doubleClick();
    _resetDoubleTapState();
  }

  void handleTwoFingerTap() {
    _isTwoFingerTapped = true;
    notifyListeners();
    _mouseRepository.click(MouseButton.right);
    _resetTwoFingerTapState();
  }

  void _resetTapState() {
    _isTapped = false;
    notifyListeners();
  }

  void _resetDoubleTapState() {
    _isDoubleTapped = false;
    notifyListeners();
  }

  void _resetTwoFingerTapState() {
    _isTwoFingerTapped = false;
    notifyListeners();
  }
}
