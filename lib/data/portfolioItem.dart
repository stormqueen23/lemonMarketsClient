import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_market_client/data/portfolioInstrument.dart';

part 'portfolioItem.g.dart';

@JsonSerializable()
class PortfolioItem {
  @JsonKey(name: 'instrument')
  PortfolioInstrument instrument;

  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(name: 'average_price')
  String averagePrice;

  @JsonKey(name: 'latest_total_value')
  String latestTotalValue;

  PortfolioItem(this.instrument, this.quantity, this.averagePrice, this.latestTotalValue);

  factory PortfolioItem.fromJson(Map<String, dynamic> json) => _$PortfolioItemFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioItemToJson(this);


}