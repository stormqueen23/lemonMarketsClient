import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/portfolioInstrument.dart';
import 'package:lemon_markets_client/helper/lemonMarketsResultConverter.dart';

part 'portfolioItem.g.dart';

@JsonSerializable()
class PortfolioItem {
  @JsonKey(name: 'instrument')
  PortfolioInstrument instrument;

  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(name: 'average_price', fromJson: LemonMarketsResultConverter.toDouble)
  double averagePrice;

  @JsonKey(name: 'latest_total_value', fromJson: LemonMarketsResultConverter.toDouble)
  double latestTotalValue;

  PortfolioItem(this.instrument, this.quantity, this.averagePrice, this.latestTotalValue);

  factory PortfolioItem.fromJson(Map<String, dynamic> json) => _$PortfolioItemFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioItemToJson(this);

  double get sumPrice => quantity * averagePrice;


}