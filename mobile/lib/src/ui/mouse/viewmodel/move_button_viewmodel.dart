import 'package:controller/src/data/repositories/mouse_repository.dart';
import 'package:flutter/foundation.dart';

class MoveMouseButtonViewmodel {
  final MouseRepository _mouseRepository;

  late final ValueNotifier<bool> isActive;

  MoveMouseButtonViewmodel({
    required MouseRepository mouseReposiry,
  }) : _mouseRepository = mouseReposiry {
    isActive = ValueNotifier<bool>(
      _mouseRepository.movementSubscription.value != null,
    );
    _mouseRepository.movementSubscription.addListener(_listener);
  }

  void toggle() {
    if (!isActive.value) {
      _mouseRepository.enableMovement();
    } else {
      _mouseRepository.disableMovement();
    }
  }

  dispose() {
    isActive.dispose();
    _mouseRepository.movementSubscription.removeListener(_listener);
  }

  _listener() {
    isActive.value = _mouseRepository.movementSubscription.value != null;
  }
}
