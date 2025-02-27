import 'package:controller/src/data/repositories/mouse_repository.dart';
import 'package:flutter/material.dart';

class ScrollMouseButtonViewmodel {
  final MouseRepository _mouseRepository;

  late final ValueNotifier<bool> isActive;

  ScrollMouseButtonViewmodel({
    required MouseRepository mouseReposiry,
  }) : _mouseRepository = mouseReposiry {
    isActive = ValueNotifier<bool>(
      _mouseRepository.scrollingSubscription.value != null,
    );
    _mouseRepository.scrollingSubscription.addListener(_listener);
  }

  void toggle() {
    if (!isActive.value) {
      _mouseRepository.enableScrolling();
    } else {
      _mouseRepository.disableScrolling();
    }
  }

  dispose() {
    isActive.dispose();
    _mouseRepository.scrollingSubscription.removeListener(_listener);
  }

  _listener() {
    isActive.value = _mouseRepository.scrollingSubscription.value != null;
  }
}
