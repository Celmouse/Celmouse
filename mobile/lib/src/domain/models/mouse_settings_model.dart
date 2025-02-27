import 'package:freezed_annotation/freezed_annotation.dart';

part 'mouse_settings_model.freezed.dart';
part 'mouse_settings_model.g.dart';

enum DoubleClickDelayOptions {
  veryFast(100, "Very Fast"),
  fast(200, "Fast"),
  standard(300, "Default"),
  slow(500, "Slow"),
  verySlow(700, "Very Slow");

  const DoubleClickDelayOptions(this.duration, this.text);
  final int duration;
  final String text;
}

enum DragStartDelayOptions {
  veryFast(100, "Very Fast"),
  fast(180, "Fast"),
  standard(250, "Default"),
  slow(500, "Slow"),
  verySlow(700, "Very Slow");

  const DragStartDelayOptions(this.duration, this.text);
  final String text;

  /// Value in ms
  final int duration;
}

enum ReduceVibrationOptions {
  strong(0.04, "Hard"),
  standard(0.031, "Default"),
  weak(0.023, "Weak"),
  veryWeak(0.013, "Very weak");

  const ReduceVibrationOptions(this.value, this.text);

  /// Threshold value for reducing shaking
  final double value;
  final String text;
}

@unfreezed
class MouseSettings with _$MouseSettings {
  /// The threshold value for reducing the shaking of the scroll
  static const double scrollThreshholdX = 0.15;
  static const double scrollThreshholdY = 0.15;

  /// Same as samplingPeriod, trying to reduce the input lag could cause communication noises (milliseconds)
  static const int inputLag = 15;

  @JsonSerializable(
    createToJson: true,
  )
  factory MouseSettings({
    @Default(ReduceVibrationOptions.standard)
    ReduceVibrationOptions vibrationThreshold,
    @Default(DragStartDelayOptions.standard)
    DragStartDelayOptions dragStartDelayMS,
    @Default(DoubleClickDelayOptions.standard)
    DoubleClickDelayOptions doubleClickDelayMS,
    @Default(false) bool invertedPointerX,
    @Default(false) bool invertedPointerY,
    @Default(false) bool invertedScrollX,
    @Default(false) bool invertedScrollY,
    @Default(5) int sensitivity,
    @Default(3) int scrollSensitivity,
    @Default(false) bool keepMovingAfterScroll,
  }) = _MouseSettings;

  factory MouseSettings.fromJson(Map<String, Object?> json) =>
      _$MouseSettingsFromJson(json);
}
