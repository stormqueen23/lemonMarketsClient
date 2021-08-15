import 'package:json_annotation/json_annotation.dart';

part 'trade.g.dart';

@JsonSerializable()
class Trade {
  @JsonKey(name: 'isin')
  String isin;

  @JsonKey(name: 'p')
  double price;

  @JsonKey(name: 'v')
  double volume;

  @JsonKey(name: 't')
  double time;

  Trade(this.isin, this.price, this.volume, this.time);

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);

  Map<String, dynamic> toJson() => _$TradeToJson(this);
}