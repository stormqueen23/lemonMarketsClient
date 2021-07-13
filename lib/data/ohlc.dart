import 'package:json_annotation/json_annotation.dart';

part 'ohlc.g.dart';

@JsonSerializable()
class OHLC {
  @JsonKey(name: 'o')
  double open;
  @JsonKey(name: 'h')
  double high;
  @JsonKey(name: 'l')
  double low;
  @JsonKey(name: 'c')
  double close;
  @JsonKey(name: 't')
  double time;

  OHLC(this.open, this.high, this.low, this.close, this.time);

  factory OHLC.fromJson(Map<String, dynamic> json) => _$OHLCFromJson(json);

  Map<String, dynamic> toJson() => _$OHLCToJson(this);
}