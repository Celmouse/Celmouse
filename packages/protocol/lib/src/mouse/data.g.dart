// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MouseButtonProtocolData _$MouseButtonProtocolDataFromJson(
        Map<String, dynamic> json) =>
    MouseButtonProtocolData(
      type: $enumDecode(_$MouseButtonEnumMap, json['type']),
    );

Map<String, dynamic> _$MouseButtonProtocolDataToJson(
        MouseButtonProtocolData instance) =>
    <String, dynamic>{
      'type': _$MouseButtonEnumMap[instance.type]!,
    };

const _$MouseButtonEnumMap = {
  MouseButton.left: 'left',
  MouseButton.right: 'right',
  MouseButton.center: 'center',
};

MouseMovementProtocolData _$MouseMovementProtocolDataFromJson(
        Map<String, dynamic> json) =>
    MouseMovementProtocolData(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      intensity: (json['intensity'] as num).toDouble(),
    );

Map<String, dynamic> _$MouseMovementProtocolDataToJson(
        MouseMovementProtocolData instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'intensity': instance.intensity,
    };
