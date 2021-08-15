import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/instrumentTradingVenue.dart';

part 'instrument.g.dart';

@JsonSerializable()
class Instrument {
  @JsonKey(name: 'isin')
  String isin;

  @JsonKey(name: 'wkn')
  String wkn;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'symbol')
  String symbol;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'venues')
  List<InstrumentTradingVenue> venues;

  Instrument(this.isin, this.wkn, this.name, this.title, this.symbol, this.type, this.venues);

  factory Instrument.fromJson(Map<String, dynamic> json) => _$InstrumentFromJson(json);

  Map<String, dynamic> toJson() => _$InstrumentToJson(this);
}