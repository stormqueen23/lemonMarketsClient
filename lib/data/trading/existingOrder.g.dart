// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'existingOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExistingOrder _$ExistingOrderFromJson(Map<String, dynamic> json) =>
    ExistingOrder(
      json['id'] as String,
      json['isin'] as String,
      LemonMarketsTimeConverter.fromIsoTime(json['expires_at'] as String),
      LemonMarketsTimeConverter.fromIsoTime(json['created_at'] as String),
      LemonMarketsResultConverter.fromOrderSide(json['side'] as String),
      json['quantity'] as int,
      LemonMarketsAmountConverter.fromNullableAmount(
          json['stop_price'] as int?),
      LemonMarketsAmountConverter.fromNullableAmount(
          json['limit_price'] as int?),
      LemonMarketsAmountConverter.fromNullableAmount(
          json['estimated_price'] as int?),
      json['venue'] as String,
      LemonMarketsResultConverter.fromOrderStatus(json['status'] as String),
      json['space_id'] as String,
      LemonMarketsResultConverter.fromOrderType(json['type'] as String),
      json['executed_quantity'] as int?,
      LemonMarketsAmountConverter.fromNullableAmount(
          json['executed_price'] as int?),
      LemonMarketsTimeConverter.fromIsoTimeNullable(
          json['executed_at'] as String?),
      LemonMarketsTimeConverter.fromIsoTimeNullable(
          json['rejected_at'] as String?),
      json['notes'] as String?,
    )..activatedAt = LemonMarketsTimeConverter.fromIsoTimeNullable(
        json['activated_at'] as String?);

Map<String, dynamic> _$ExistingOrderToJson(ExistingOrder instance) =>
    <String, dynamic>{
      'id': instance.uuid,
      'isin': instance.isin,
      'expires_at': LemonMarketsTimeConverter.toIsoTime(instance.expiresAt),
      'created_at': LemonMarketsTimeConverter.toIsoTime(instance.createdAt),
      'side': LemonMarketsResultConverter.toOrderSide(instance.side),
      'quantity': instance.quantity,
      'stop_price':
          LemonMarketsAmountConverter.toNullableAmount(instance.stopPrice),
      'limit_price':
          LemonMarketsAmountConverter.toNullableAmount(instance.limitPrice),
      'estimated_price':
          LemonMarketsAmountConverter.toNullableAmount(instance.estimatedPrice),
      'venue': instance.tradingVenueMic,
      'status': LemonMarketsResultConverter.toOrderStatus(instance.status),
      'space_id': instance.spaceUuid,
      'type': LemonMarketsResultConverter.toOrderType(instance.type),
      'executed_quantity': instance.executedQuantity,
      'executed_price':
          LemonMarketsAmountConverter.toNullableAmount(instance.executedPrice),
      'activated_at':
          LemonMarketsTimeConverter.toIsoTimeNullable(instance.activatedAt),
      'executed_at':
          LemonMarketsTimeConverter.toIsoTimeNullable(instance.executedAt),
      'rejected_at':
          LemonMarketsTimeConverter.toIsoTimeNullable(instance.rejectedAt),
      'notes': instance.notes,
    };
