import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/searchTradingVenue.dart';

part 'instrument.g.dart';

@JsonSerializable()
class Instrument {
  @JsonKey(name: 'isin')
  String isin;
  @JsonKey(name: 'wkn')
  String wkn;
  @JsonKey(name: 'symbol')
  String symbol;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'currency')
  String currency;
  @JsonKey(name: 'tradable')
  bool tradable;

  @JsonKey(name: 'trading_venues')
  List<SearchTradingVenue>? tradingVenues;

  Instrument(this.isin, this.wkn, this.title, this.type, this.symbol, this.name, this.currency, this.tradable);

  factory Instrument.fromJson(Map<String, dynamic> json) => _$InstrumentFromJson(json);

  Map<String, dynamic> toJson() => _$InstrumentToJson(this);
}