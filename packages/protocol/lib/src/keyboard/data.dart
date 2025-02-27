import 'package:json_annotation/json_annotation.dart';
import 'special_keys.dart';

part 'data.g.dart';

@JsonSerializable()
class KeyboardProtocolData {
  final SpecialKeyType key;
   KeyboardProtocolData({
    required this.key,
  });

  factory KeyboardProtocolData.fromJson(Map<String, dynamic> json) =>
      _$KeyboardProtocolDataFromJson(json);

  Map<String, dynamic> toJson() => _$KeyboardProtocolDataToJson(this);
}
