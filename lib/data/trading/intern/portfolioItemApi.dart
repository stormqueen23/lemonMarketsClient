import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/amount.dart';
import 'package:lemon_markets_client/helper/lemonMarketsAmountConverter.dart';

part 'portfolioItemApi.g.dart';

@JsonSerializable()
class PortfolioItemApi {

  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(name: 'buy_quantity')
  int quantityBuy;

  @JsonKey(name: 'sell_quantity')
  int? quantitySell;

  @JsonKey(
      name: 'buy_price_avg',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? buyPriceAvg;

  @JsonKey(
      name: 'buy_price_min',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? buyPriceMin;

  @JsonKey(
      name: 'buy_price_max',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? buyPriceMax;

  @JsonKey(
      name: 'buy_price_avg_historical',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? buyPriceAvgHistorical;

  // @JsonKey(name: 'sell_price_avg')
  // double? sellPriceAvg;

  @JsonKey(
      name: 'sell_price_min',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? sellPriceMin;

  @JsonKey(
      name: 'sell_price_max',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? sellPriceMax;

  @JsonKey(
      name: 'sell_price_avg_historical',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? sellPriceAvgHistorical;

  @JsonKey(name: 'orders_total')
  int ordersTotal;

  @JsonKey(name: 'sell_orders_total')
  int? sellOrdersTotal;

  @JsonKey(name: 'buy_orders_total')
  int buyOrdersTotal;

  PortfolioItemApi(
      this.quantity,
      this.quantityBuy,
      this.quantitySell,
      this.buyPriceAvg,
      this.buyPriceMin,
      this.buyPriceMax,
      this.buyPriceAvgHistorical,
      this.sellPriceMin,
      this.sellPriceMax,
      this.sellPriceAvgHistorical,
      this.ordersTotal,
      this.sellOrdersTotal,
      this.buyOrdersTotal);

  factory PortfolioItemApi.fromJson(Map<String, dynamic> json) => _$PortfolioItemApiFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioItemApiToJson(this);

}