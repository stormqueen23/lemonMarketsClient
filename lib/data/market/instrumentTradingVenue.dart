import 'package:json_annotation/json_annotation.dart';

part 'instrumentTradingVenue.g.dart';

@JsonSerializable()
class InstrumentTradingVenue {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'mic')
  String mic;

  @JsonKey(name: 'is_open')
  bool isOpen;

  @JsonKey(name: 'currency')
  String currency;

  @JsonKey(name: 'tradable')
  bool tradable;

  InstrumentTradingVenue(this.name, this.title, this.mic, this.isOpen, this.currency, this.tradable);

  factory InstrumentTradingVenue.fromJson(Map<String, dynamic> json) => _$InstrumentTradingVenueFromJson(json);

  Map<String, dynamic> toJson() => _$InstrumentTradingVenueToJson(this);
}
