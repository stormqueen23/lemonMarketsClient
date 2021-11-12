import 'package:json_annotation/json_annotation.dart';

part 'openingHour.g.dart';

@JsonSerializable()
class OpeningHour {
  @JsonKey(name: 'start')
  String start;
  @JsonKey(name: 'end')
  String end;
  @JsonKey(name: 'timezone')
  String timezone;

  OpeningHour(this.start, this.end, this.timezone);

  factory OpeningHour.fromJson(Map<String, dynamic> json) => _$OpeningHourFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningHourToJson(this);
}