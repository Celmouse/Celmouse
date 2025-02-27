// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'features.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvaliableFeatures _$AvaliableFeaturesFromJson(Map<String, dynamic> json) =>
    AvaliableFeatures(
      keyboard: json['keyboard'] as bool,
      mouse: json['mouse'] as bool,
      touchpad: json['touchpad'] as bool,
      remote: json['remote'] as bool,
    );

Map<String, dynamic> _$AvaliableFeaturesToJson(AvaliableFeatures instance) =>
    <String, dynamic>{
      'keyboard': instance.keyboard,
      'mouse': instance.mouse,
      'touchpad': instance.touchpad,
      'remote': instance.remote,
    };
