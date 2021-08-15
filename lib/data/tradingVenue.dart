import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/openingHour.dart';

part 'tradingVenue.g.dart';

@JsonSerializable()
class TradingVenue {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'mic')
  String mic;

  @JsonKey(name: 'is_open')
  bool isOpen;

  @JsonKey(name: 'opening_hours')
  OpeningHour hour;

  @JsonKey(name: 'opening_days')
  List<String> openingDays;

  TradingVenue(this.name, this.title, this.mic, this.isOpen, this.hour, this.openingDays);

  factory TradingVenue.fromJson(Map<String, dynamic> json) => _$TradingVenueFromJson(json);

  Map<String, dynamic> toJson() => _$TradingVenueToJson(this);
}
