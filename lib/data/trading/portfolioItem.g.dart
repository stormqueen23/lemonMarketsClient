// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolioItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioItem _$PortfolioItemFromJson(Map<String, dynamic> json) =>
    PortfolioItem(
      json['isin'] as String,
      json['isin_title'] as String,
      json['space_id'] as String,
      json['quantity'] as int,
      json['buy_quantity'] as int?,
      json['sell_quantity'] as int?,
      LemonMarketsAmountConverter.fromNullableAmount(
          json['buy_price_avg'] as num?),
      LemonMarketsAmountConverter.fromNullableAmount(
          json['buy_price_min'] as num?),
      LemonMarketsAmountConverter.fromNullableAmount(
          json['buy_price_max'] as num?),
      LemonMarketsAmountConverter.fromNullableAmount(
          json['buy_price_avg_historical'] as num?),
      LemonMarketsAmountConverter.fromNullableAmount(
          json['sell_price_min'] as num?),
      LemonMarketsAmountConverter.fromNullableAmount(
          json['sell_price_max'] as num?),
      LemonMarketsAmountConverter.fromNullableAmount(
          json['sell_price_avg_historical'] as num?),
      json['orders_total'] as int?,
      json['sell_orders_total'] as int?,
      json['buy_orders_total'] as int?,
    );

Map<String, dynamic> _$PortfolioItemToJson(PortfolioItem instance) =>
    <String, dynamic>{
      'isin': instance.isin,
      'isin_title': instance.isinTitle,
      'space_id': instance.spaceUuid,
      'quantity': instance.quantity,
      'buy_quantity': instance.quantityBuy,
      'sell_quantity': instance.quantitySell,
      'buy_price_avg':
          LemonMarketsAmountConverter.toNullableAmount(instance.buyPriceAvg),
      'buy_price_min':
          LemonMarketsAmountConverter.toNullableAmount(instance.buyPriceMin),
      'buy_price_max':
          LemonMarketsAmountConverter.toNullableAmount(instance.buyPriceMax),
      'buy_price_avg_historical': LemonMarketsAmountConverter.toNullableAmount(
          instance.buyPriceAvgHistorical),
      'sell_price_min':
          LemonMarketsAmountConverter.toNullableAmount(instance.sellPriceMin),
      'sell_price_max':
          LemonMarketsAmountConverter.toNullableAmount(instance.sellPriceMax),
      'sell_price_avg_historical': LemonMarketsAmountConverter.toNullableAmount(
          instance.sellPriceAvgHistorical),
      'orders_total': instance.ordersTotal,
      'sell_orders_total': instance.sellOrdersTotal,
      'buy_orders_total': instance.buyOrdersTotal,
    };
