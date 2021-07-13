import 'package:json_annotation/json_annotation.dart';

part 'latestTrade.g.dart';

@JsonSerializable()
class LatestTrade {
  @JsonKey(name: 'p')
  double price;
  @JsonKey(name: 'v')
  double volume;
  @JsonKey(name: 't')
  double t;

  LatestTrade(this.price, this.volume, this.t);

  factory LatestTrade.fromJson(Map<String, dynamic> json) => _$LatestTradeFromJson(json);

  Map<String, dynamic> toJson() => _$LatestTradeToJson(this);
}