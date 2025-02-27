// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectionInfoProtocolData _$ConnectionInfoProtocolDataFromJson(
        Map<String, dynamic> json) =>
    ConnectionInfoProtocolData(
      deviceName: json['deviceName'] as String,
      deviceOS: $enumDecode(_$DeviceOSEnumMap, json['deviceOS']),
      versionNumber: json['versionNumber'] as String,
      extra: json['extra'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$ConnectionInfoProtocolDataToJson(
        ConnectionInfoProtocolData instance) =>
    <String, dynamic>{
      'deviceName': instance.deviceName,
      'deviceOS': _$DeviceOSEnumMap[instance.deviceOS]!,
      'versionNumber': instance.versionNumber,
      'extra': instance.extra,
    };

const _$DeviceOSEnumMap = {
  DeviceOS.windows: 'windows',
  DeviceOS.linux: 'linux',
  DeviceOS.macos: 'macos',
  DeviceOS.unknown: 'unknown',
};

DesktopExtraInfoData _$DesktopExtraInfoDataFromJson(
        Map<String, dynamic> json) =>
    DesktopExtraInfoData(
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$DesktopExtraInfoDataToJson(
        DesktopExtraInfoData instance) =>
    <String, dynamic>{
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
    };

MobileExtraInfoData _$MobileExtraInfoDataFromJson(Map<String, dynamic> json) =>
    MobileExtraInfoData(
      message: json['message'] as String,
    );

Map<String, dynamic> _$MobileExtraInfoDataToJson(
        MobileExtraInfoData instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
