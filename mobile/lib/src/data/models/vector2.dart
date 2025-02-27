import 'dart:math';

class Vector2D {
  double x;
  double y;

  Vector2D(this.x, this.y);

  double get length => sqrt(x * x + y * y);

  bool get canNormalize => length != 0;

  Vector2D operator /(double value) => Vector2D(x / value, y / value);

  Vector2D get normalized => this / length;
  @override
  String toString() {
    return "($x, $y)";
  }
}
