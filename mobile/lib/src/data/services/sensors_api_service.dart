import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart' as vectors;

const PREVENT_JUMP_THRESHOLD = 4;

class SensorsApiService {
  DateTime? tmpTimestamp;

  StreamSubscription<GyroscopeEvent> gyroscope(
    bool invertX,
    bool invertY,
    double threshold,
    Function(double x, double y) onDone,
  ) {
    return gyroscopeEventStream(
      samplingPeriod: const Duration(milliseconds: 16, microseconds: 666),
    ).listen((event) {
      var (x, y) = _tranformGyroscopeCoordinates(
        event.z * -1,
        event.x * -1,
        event.timestamp,
      );
      
      if (x.abs() <= threshold) {
        x = 0;
      }

      if (y.abs() <= threshold) {
        y = 0;
      }

      if (y.abs() > PREVENT_JUMP_THRESHOLD ||
          x.abs() > PREVENT_JUMP_THRESHOLD) {
        x = 0;
        y = 0;
      }

      final invertedX = invertX ? -1 : 1;
      final invertedY = invertY ? -1 : 1;

      onDone(invertedX * x, invertedY * y);
    });
  }

  (double x, double y) _tranformGyroscopeCoordinates(
    double x,
    double y,
    DateTime timestamp,
  ) {
    if (tmpTimestamp == null) {
      tmpTimestamp = timestamp;
      return (0, 0);
    }

    // X é Z e pra direita é negativo
    // X é Y e pra cima é positivo
    final diffMS = timestamp.difference(tmpTimestamp!).inMicroseconds;
    tmpTimestamp = timestamp;

    final seconds = diffMS / pow(10, 6);

    x = (vectors.degrees(x * seconds));
    y = (vectors.degrees(y * seconds));

    return (x, y);
  }
}
