import 'package:json_annotation/json_annotation.dart';
import 'package:protocol/src/events.dart';

part 'model.g.dart';

@JsonSerializable()
class Protocol {
  ProtocolEvent event;
  DateTime timestamp;
  dynamic data;

  Protocol({
    required this.event,
    required this.timestamp,
    required this.data,
  });

  factory Protocol.fromJson(Map<String, dynamic> json) =>
      _$ProtocolFromJson(json);

  Map<String, dynamic> toJson() => _$ProtocolToJson(this);
}
