import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/openingDay.dart';

part 'openingDaysList.g.dart';

@JsonSerializable()
class OpeningDaysList {
  @JsonKey(name: 'next')
  String? next;
  @JsonKey(name: 'prev')
  String? previous;
  @JsonKey(name: 'results')
  List<OpeningDay> result;

  OpeningDaysList(this.next, this.previous, this.result);

  factory OpeningDaysList.fromJson(Map<String, dynamic> json) => _$OpeningDaysListFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningDaysListToJson(this);
}