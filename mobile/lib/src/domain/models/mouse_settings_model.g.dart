// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mouse_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MouseSettingsImpl _$$MouseSettingsImplFromJson(Map<String, dynamic> json) =>
    _$MouseSettingsImpl(
      vibrationThreshold: $enumDecodeNullable(
              _$ReduceVibrationOptionsEnumMap, json['vibrationThreshold']) ??
          ReduceVibrationOptions.standard,
      dragStartDelayMS: $enumDecodeNullable(
              _$DragStartDelayOptionsEnumMap, json['dragStartDelayMS']) ??
          DragStartDelayOptions.standard,
      doubleClickDelayMS: $enumDecodeNullable(
              _$DoubleClickDelayOptionsEnumMap, json['doubleClickDelayMS']) ??
          DoubleClickDelayOptions.standard,
      invertedPointerX: json['invertedPointerX'] as bool? ?? false,
      invertedPointerY: json['invertedPointerY'] as bool? ?? false,
      invertedScrollX: json['invertedScrollX'] as bool? ?? false,
      invertedScrollY: json['invertedScrollY'] as bool? ?? false,
      sensitivity: (json['sensitivity'] as num?)?.toInt() ?? 5,
      scrollSensitivity: (json['scrollSensitivity'] as num?)?.toInt() ?? 3,
      keepMovingAfterScroll: json['keepMovingAfterScroll'] as bool? ?? false,
    );

Map<String, dynamic> _$$MouseSettingsImplToJson(_$MouseSettingsImpl instance) =>
    <String, dynamic>{
      'vibrationThreshold':
          _$ReduceVibrationOptionsEnumMap[instance.vibrationThreshold]!,
      'dragStartDelayMS':
          _$DragStartDelayOptionsEnumMap[instance.dragStartDelayMS]!,
      'doubleClickDelayMS':
          _$DoubleClickDelayOptionsEnumMap[instance.doubleClickDelayMS]!,
      'invertedPointerX': instance.invertedPointerX,
      'invertedPointerY': instance.invertedPointerY,
      'invertedScrollX': instance.invertedScrollX,
      'invertedScrollY': instance.invertedScrollY,
      'sensitivity': instance.sensitivity,
      'scrollSensitivity': instance.scrollSensitivity,
      'keepMovingAfterScroll': instance.keepMovingAfterScroll,
    };

const _$ReduceVibrationOptionsEnumMap = {
  ReduceVibrationOptions.strong: 'strong',
  ReduceVibrationOptions.standard: 'standard',
  ReduceVibrationOptions.weak: 'weak',
  ReduceVibrationOptions.veryWeak: 'veryWeak',
};

const _$DragStartDelayOptionsEnumMap = {
  DragStartDelayOptions.veryFast: 'veryFast',
  DragStartDelayOptions.fast: 'fast',
  DragStartDelayOptions.standard: 'standard',
  DragStartDelayOptions.slow: 'slow',
  DragStartDelayOptions.verySlow: 'verySlow',
};

const _$DoubleClickDelayOptionsEnumMap = {
  DoubleClickDelayOptions.veryFast: 'veryFast',
  DoubleClickDelayOptions.fast: 'fast',
  DoubleClickDelayOptions.standard: 'standard',
  DoubleClickDelayOptions.slow: 'slow',
  DoubleClickDelayOptions.verySlow: 'verySlow',
};
