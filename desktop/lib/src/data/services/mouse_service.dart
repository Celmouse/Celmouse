import 'package:flutter/services.dart';
import 'package:protocol/protocol.dart';

/// Multipliers to make movement viable
/// [yMultiplier] represents the screen size on the vertical axis.
/// [xMultiplier] represents the screen size on the horizontal axis.
const yMultiplier = 21;
const xMultiplier = 27;

class MouseService {
  final _channel = MousePlatformChannel();

  final Size _screenSize = Size(1, 1);

  void move(double x, double y, double sense) => _channel.move(
        x * xMultiplier * sense,
        y * yMultiplier * sense,
      );

  void scroll(int x, int y, int sense) => _channel.scroll(
        (x * sense).toDouble(),
        (y * sense).toDouble(),
      );

  void center() => _channel.moveTo(
        _screenSize.width / 2,
        _screenSize.height / 2,
      );

  void click(MouseButton button) => _channel.click(button.value);

  void doubleClick(MouseButton button) => _channel.doubleClick();

  void holdLeftButton() => _channel.hold(0);

  void releaseLeftButton() => _channel.release(0);
}

class MousePlatformChannel {
  static const platform = MethodChannel('com.celmouse.plugins/mouse');

  void moveTo(double x, double y) => platform.invokeMethod<Map>(
        'moveTo',
        {'x': x, 'y': y},
      );
  void move(double x, double y) => platform.invokeMethod<Map>(
        'move',
        {'x': x, 'y': y},
      );
  void scroll(double x, double y) => platform.invokeMethod<Map>(
        'scroll',
        {'x': x, 'y': y},
      );

  void click(int value) => platform.invokeMethod('click', value);
  void doubleClick() => platform.invokeMethod('doubleClick');
  void hold(int button) => platform.invokeMethod('holdButton', button);
  void release(int button) => platform.invokeMethod('releaseButton', button);

  // Future<Map<String, double>?> getScreenSize() async {
  //   final result =
  //       await platform.invokeMethod<Map<String, double>>('screenSize');
  //   return result;
  // }
}
