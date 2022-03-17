import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';

part 'quote.g.dart';

@JsonSerializable()
class Quote {
  @JsonKey(name: 'isin')
  String isin;

  @JsonKey(name: 'a')
  double ask;

  @JsonKey(name: 'a_v')
  double askVolume;

  @JsonKey(name: 'b')
  double bit;

  @JsonKey(name: 'b_v')
  double bitVolume;

  @JsonKey(name: 'mic')
  String mic;

  @JsonKey(name: 't', fromJson: LemonMarketsTimeConverter.getDateTimeForLemonMarket, toJson: LemonMarketsTimeConverter.getDoubleTimeForDateTime)
  DateTime time;

  Quote(this.isin, this.ask, this.askVolume, this.bit, this.bitVolume, this.time, this.mic);

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteToJson(this);

  double get bidAskSpread => (ask-bit) / ask * 100;

  @override
  String toString() {
    return 'Quote{\nisin: $isin,\nask: $ask,\naskVolume: $askVolume,\nbit: $bit,\nbitVolume: $bitVolume,\nmic: $mic,\ntime: $time\n}';
  }
}