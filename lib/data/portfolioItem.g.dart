// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolioItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioItem _$PortfolioItemFromJson(Map<String, dynamic> json) {
  return PortfolioItem(
    PortfolioInstrument.fromJson(json['instrument'] as Map<String, dynamic>),
    json['quantity'] as int,
    LemonMarketsResultConverter.toDouble(json['average_price'] as String),
    LemonMarketsResultConverter.toDouble(json['latest_total_value'] as String),
  );
}

Map<String, dynamic> _$PortfolioItemToJson(PortfolioItem instance) =>
    <String, dynamic>{
      'instrument': instance.instrument,
      'quantity': instance.quantity,
      'average_price': instance.averagePrice,
      'latest_total_value': instance.latestTotalValue,
    };
