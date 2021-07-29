import 'package:json_annotation/json_annotation.dart';

part 'openingDay.g.dart';

@JsonSerializable()
class OpeningDay {
  @JsonKey(name: 'opening_time')
  double opening;
  @JsonKey(name: 'closing_time')
  double closing;
  @JsonKey(name: 'day_iso')
  String day;

  OpeningDay(this.opening, this.closing, this.day);

  factory OpeningDay.fromJson(Map<String, dynamic> json) => _$OpeningDayFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningDayToJson(this);
}