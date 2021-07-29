import 'package:json_annotation/json_annotation.dart';

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

  TradingVenue(this.name, this.title, this.mic, this.isOpen);

  factory TradingVenue.fromJson(Map<String, dynamic> json) => _$TradingVenueFromJson(json);

  Map<String, dynamic> toJson() => _$TradingVenueToJson(this);
}
