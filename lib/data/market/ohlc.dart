import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';

part 'ohlc.g.dart';

@JsonSerializable()
class OHLC {
  @JsonKey(name: 'isin')
  String isin;

  @JsonKey(name: 'o')
  double open;

  @JsonKey(name: 'h')
  double high;

  @JsonKey(name: 'l')
  double low;

  @JsonKey(name: 'c')
  double close;

  @JsonKey(name: 'mic')
  String mic;

  @JsonKey(
      name: 't',
      fromJson: LemonMarketsTimeConverter.getDateTimeForLemonMarket,
      toJson: LemonMarketsTimeConverter.getDoubleTimeForDateTime)
  DateTime time;

  OHLC(this.isin, this.open, this.high, this.low, this.close, this.time, this.mic);

  factory OHLC.fromJson(Map<String, dynamic> json) => _$OHLCFromJson(json);

  Map<String, dynamic> toJson() => _$OHLCToJson(this);

  @override
  String toString() {
    return 'OHLC {\nisin: $isin,\nopen: $open,\nhigh: $high,\nlow: $low,\nclose: $close,\nmic: $mic,\ntime: $time\n}';
  }
}
