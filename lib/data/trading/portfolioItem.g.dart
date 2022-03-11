// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolioItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioItem _$PortfolioItemFromJson(Map<String, dynamic> json) =>
    PortfolioItem(
      json['isin'] as String,
      json['isin_title'] as String,
      json['quantity'] as int,
      LemonMarketsAmountConverter.fromNullableAmount(
          json['buy_price_avg'] as num?),
    )
      ..estimatedPrice = LemonMarketsAmountConverter.fromNullableAmount(
          json['estimated_price'] as num?)
      ..estimatedPriceTotal = LemonMarketsAmountConverter.fromNullableAmount(
          json['estimated_price_total'] as num?);

Map<String, dynamic> _$PortfolioItemToJson(PortfolioItem instance) =>
    <String, dynamic>{
      'isin': instance.isin,
      'isin_title': instance.isinTitle,
      'quantity': instance.quantity,
      'buy_price_avg':
          LemonMarketsAmountConverter.toNullableAmount(instance.buyPriceAvg),
      'estimated_price':
          LemonMarketsAmountConverter.toNullableAmount(instance.estimatedPrice),
      'estimated_price_total': LemonMarketsAmountConverter.toNullableAmount(
          instance.estimatedPriceTotal),
    };
