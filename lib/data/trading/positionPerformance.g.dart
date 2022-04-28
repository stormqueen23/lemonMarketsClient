// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'positionPerformance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionPerformance _$PositionPerformanceFromJson(Map<String, dynamic> json) =>
    PositionPerformance(
      json['isin'] as String,
      json['isin_title'] as String,
      LemonMarketsAmountConverter.fromAmount(json['profit'] as num),
      LemonMarketsAmountConverter.fromAmount(json['loss'] as num),
      LemonMarketsAmountConverter.fromAmount(json['fees'] as num),
      json['quantity_bought'] as int,
      json['quantity_sold'] as int,
      json['quantity_open'] as int,
      LemonMarketsTimeConverter.fromIsoTimeNullable(
          json['opened_at'] as String?),
    )..closedAt = LemonMarketsTimeConverter.fromIsoTimeNullable(
        json['closed_at'] as String?);

Map<String, dynamic> _$PositionPerformanceToJson(
        PositionPerformance instance) =>
    <String, dynamic>{
      'isin': instance.isin,
      'isin_title': instance.isinTitle,
      'profit': LemonMarketsAmountConverter.toAmount(instance.profit),
      'loss': LemonMarketsAmountConverter.toAmount(instance.loss),
      'fees': LemonMarketsAmountConverter.toAmount(instance.fees),
      'quantity_bought': instance.quantityBought,
      'quantity_sold': instance.quantitySold,
      'quantity_open': instance.quantityOpen,
      'opened_at':
          LemonMarketsTimeConverter.toIsoTimeNullable(instance.openedAt),
      'closed_at':
          LemonMarketsTimeConverter.toIsoTimeNullable(instance.closedAt),
    };
