import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';

part 'trade.g.dart';

@JsonSerializable()
class Trade {
  @JsonKey(name: 'isin')
  String isin;

  @JsonKey(name: 'p')
  double price;

  @JsonKey(name: 'v')
  double volume;

  @JsonKey(name: 'pbv')
  double? pbv;

  @JsonKey(name: 'mic')
  String mic;

  //@JsonKey(name: 't', fromJson: LemonMarketsTimeConverter.getDateTimeForLemonMarket, toJson: LemonMarketsTimeConverter.getDoubleTimeForDateTime)
  @JsonKey(name: 't', fromJson: LemonMarketsTimeConverter.fromIsoTime, toJson: LemonMarketsTimeConverter.toIsoTime)
  DateTime time;

  Trade(this.isin, this.price, this.pbv, this.volume, this.time, this.mic);

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);

  Map<String, dynamic> toJson() => _$TradeToJson(this);

  @override
  String toString() {
    return 'Trade{\nisin: $isin,\nprice: $price,\nvolume: $volume,\npbv: $pbv,\nmic: $mic,\ntime: $time\n}';
  }
}