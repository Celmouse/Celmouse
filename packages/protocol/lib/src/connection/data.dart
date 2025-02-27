import 'package:json_annotation/json_annotation.dart';

import 'device_os.dart';

part 'data.g.dart';

@JsonSerializable()
class ConnectionInfoProtocolData {
  final String deviceName;
  final DeviceOS deviceOS;
  final String versionNumber;
  Map<String, dynamic> extra;

  ConnectionInfoProtocolData({
    required this.deviceName,
    required this.deviceOS,
    required this.versionNumber,
    this.extra = const {},
  });

  factory ConnectionInfoProtocolData.fromJson(Map<String, dynamic> json) =>
      _$ConnectionInfoProtocolDataFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectionInfoProtocolDataToJson(this);
}

@JsonSerializable()
class DesktopExtraInfoData {
  final String message;
  final DateTime timestamp;
  DesktopExtraInfoData({
    required this.message,
    required this.timestamp,
  });

  factory DesktopExtraInfoData.fromJson(Map<String, Object?> json) =>
      _$DesktopExtraInfoDataFromJson(json);

  Map<String, Object?> toJson() => _$DesktopExtraInfoDataToJson(this);
}

@JsonSerializable()
class MobileExtraInfoData {
  final String message;
  MobileExtraInfoData({
    required this.message,
  });

  factory MobileExtraInfoData.fromJson(Map<String, Object?> json) =>
      _$MobileExtraInfoDataFromJson(json);

  Map<String, Object?> toJson() => _$MobileExtraInfoDataToJson(this);
}
