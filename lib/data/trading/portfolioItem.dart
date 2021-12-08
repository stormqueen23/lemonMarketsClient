import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/amount.dart';
import 'package:lemon_markets_client/helper/lemonMarketsAmountConverter.dart';

part 'portfolioItem.g.dart';

@JsonSerializable()
class PortfolioItem {
  @JsonKey(name: 'isin')
  String isin;

  @JsonKey(name: 'isin_title')
  String isinTitle;

  @JsonKey(name: 'space_id')
  String spaceUuid;

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

  PortfolioItem(
      this.isin,
      this.isinTitle,
      this.spaceUuid,
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

  factory PortfolioItem.fromJson(Map<String, dynamic> json) => _$PortfolioItemFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioItemToJson(this);

  Amount get sumPrice => Amount(apiValue: quantity * (buyPriceAvg?.apiValue ?? 0));

  @override
  String toString() {
    return 'PortfolioItem{\n'
        'quantity: $quantity,\n'
        'quantityBuy: $quantityBuy,\n'
        'quantitySell: $quantitySell,\n'
        'buyPriceAvg: $buyPriceAvg,\n'
        'buyPriceMin: $buyPriceMin,\n'
        'buyPriceMax: $buyPriceMax,\n'
        'buyPriceAvgHistorical: $buyPriceAvgHistorical,\n'
        'sellPriceMin: $sellPriceMin,\n'
        'sellPriceMax: $sellPriceMax,\n'
        'sellPriceAvgHistorical: $sellPriceAvgHistorical,\n'
        'ordersTotal: $ordersTotal,\n'
        'sellOrdersTotal: $sellOrdersTotal,\n'
        'buyOrdersTotal: $buyOrdersTotal,\n'
        'isin: $isin,\n'
        'title: $isinTitle,\n'
        'spaceUuid: $spaceUuid\n'
        '}';
  }
}
