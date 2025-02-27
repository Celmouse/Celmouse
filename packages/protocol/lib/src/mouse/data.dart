import 'package:json_annotation/json_annotation.dart';
import 'button_type.dart';

part 'data.g.dart';

@JsonSerializable()
class MouseButtonProtocolData {
  final MouseButton type;
  MouseButtonProtocolData({
    required this.type,
  });

  factory MouseButtonProtocolData.fromJson(Map<String, dynamic> json) =>
      _$MouseButtonProtocolDataFromJson(json);
  Map<String, dynamic> toJson() => _$MouseButtonProtocolDataToJson(this);
}

@JsonSerializable()
class MouseMovementProtocolData {
  double x;
  double y;
  double intensity;

  MouseMovementProtocolData({
    required this.x,
    required this.y,
    required this.intensity,
  });

  factory MouseMovementProtocolData.fromJson(Map<String, dynamic> json) =>
      _$MouseMovementProtocolDataFromJson(json);
  Map<String, dynamic> toJson() => _$MouseMovementProtocolDataToJson(this);
}
