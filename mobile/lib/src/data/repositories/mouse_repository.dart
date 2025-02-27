import 'dart:async';

import 'package:controller/getit.dart';
import 'package:controller/src/data/models/vector2.dart';
import 'package:controller/src/data/services/client_api_service.dart';
import 'package:controller/src/data/services/sensors_api_service.dart';
import 'package:controller/src/domain/models/mouse_settings_model.dart';
import 'package:flutter/foundation.dart';
import 'package:protocol/protocol.dart';

class MouseRepository {
  final ClientApiService _clientApiService;
  final SensorsApiService _sensorsService;

  MouseRepository({
    required ClientApiService clientApiService,
    required SensorsApiService sensorsService,
  })  : _clientApiService = clientApiService,
        _sensorsService = sensorsService;

  void click(MouseButton type) {
    _clientApiService.send(
      event: ProtocolEvent.mouseClick,
      data: MouseButtonProtocolData(type: type),
    );
  }

  void hold() {
    _clientApiService.send(
      event: ProtocolEvent.mouseButtonHold,
      data: MouseButtonProtocolData(type: MouseButton.left),
    );
  }

  void release() {
    _clientApiService.send(
      event: ProtocolEvent.mouseButtonReleased,
      data: MouseButtonProtocolData(type: MouseButton.left),
    );
  }

  void doubleClick() {
    _clientApiService.send(
      event: ProtocolEvent.mouseDoubleClick,
      data: MouseButtonProtocolData(type: MouseButton.left),
    );
  }

  ValueNotifier<StreamSubscription?> movementSubscription = ValueNotifier(null);
  ValueNotifier<StreamSubscription?> scrollingSubscription =
      ValueNotifier(null);

  void enableMovement() {
    final double threshold =
        getIt.get<MouseSettings>().vibrationThreshold.value;
    final bool invertX = getIt.get<MouseSettings>().invertedPointerX;
    final bool invertY = getIt.get<MouseSettings>().invertedPointerY;
    final sensitivity = getIt.get<MouseSettings>().sensitivity;

    movementSubscription.value ??= _sensorsService.gyroscope(
      invertX,
      invertY,
      threshold,
      (double x, double y) {
        final vector = Vector2D(x, y);

        if (!vector.canNormalize) return;
        Vector2D normalized = vector.normalized;

        _clientApiService.send(
          event: ProtocolEvent.mouseMove,
          data: MouseMovementProtocolData(
            x: normalized.x,
            y: normalized.y,
            intensity: vector.length * sensitivity * 0.8,
          ),
        );
      },
    );
  }

  void disableMovement() {
    movementSubscription.value?.cancel(); // .cancel();
    movementSubscription.value = null;
  }

  void disableScrolling() {
    scrollingSubscription.value?.cancel();
    scrollingSubscription.value = null;
  }

  void enableScrolling() {
    final sensitivity = getIt.get<MouseSettings>().scrollSensitivity;
    const threshold = MouseSettings.scrollThreshholdY;

    final bool invertX = getIt.get<MouseSettings>().invertedScrollX;
    final bool invertY = getIt.get<MouseSettings>().invertedScrollY;

    scrollingSubscription.value ??= _sensorsService.gyroscope(
      invertX,
      invertY,
      threshold,
      (double x, double y) {
        if (x.abs() > y.abs()) {
          y = 0;
        } else {
          x = 0;
        }

        final vector = Vector2D(x, y);
        if (!vector.canNormalize) return;
        Vector2D normalized = vector.normalized;

        _clientApiService.send(
          event: ProtocolEvent.mouseScroll,
          data: MouseMovementProtocolData(
            x: normalized.x,
            y: normalized.y,
            intensity: vector.length * sensitivity,
          ),
        );
      },
    );
  }

  void handleDrag(double deltaX, double deltaY) {
    final sensitivity = getIt.get<MouseSettings>().sensitivity;

    final vector = Vector2D(deltaX, deltaY);

    if (!vector.canNormalize) return;

    Vector2D normalized = vector.normalized;

    _clientApiService.send(
      event: ProtocolEvent.mouseMove,
      data: MouseMovementProtocolData(
        x: normalized.x,
        y: normalized.y,
        intensity: sensitivity * vector.length / 10,
      ),
    );
  }
}
