// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createdOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatedOrder _$CreatedOrderFromJson(Map<String, dynamic> json) => CreatedOrder(
      json['isin'] as String,
      json['key_creation_id'] as String,
      LemonMarketsTimeConverter.fromIsoTime(json['expires_at'] as String),
      LemonMarketsResultConverter.fromOrderSide(json['side'] as String),
      json['quantity'] as int,
      LemonMarketsAmountConverter.fromNullableAmount(
          json['stop_price'] as num?),
      LemonMarketsAmountConverter.fromNullableAmount(
          json['limit_price'] as num?),
      json['id'] as String,
      LemonMarketsResultConverter.fromOrderStatus(json['status'] as String),
      json['venue'] as String?,
      LemonMarketsAmountConverter.fromAmount(json['estimated_price'] as num),
      json['notes'] as String?,
      RegulatoryInformation.fromJson(
          json['regulatory_information'] as Map<String, dynamic>),
      LemonMarketsTimeConverter.fromIsoTimeNullable(
          json['chargeable_at'] as String?),
      LemonMarketsAmountConverter.fromAmount(json['charge'] as num),
      LemonMarketsTimeConverter.fromIsoTime(json['created_at'] as String),
    );

Map<String, dynamic> _$CreatedOrderToJson(CreatedOrder instance) =>
    <String, dynamic>{
      'id': instance.uuid,
      'key_creation_id': instance.creationKey,
      'isin': instance.isin,
      'created_at': LemonMarketsTimeConverter.toIsoTime(instance.createdAt),
      'expires_at': LemonMarketsTimeConverter.toIsoTime(instance.validUntil),
      'side': LemonMarketsResultConverter.toOrderSide(instance.side),
      'quantity': instance.quantity,
      'stop_price':
          LemonMarketsAmountConverter.toNullableAmount(instance.stopPrice),
      'limit_price':
          LemonMarketsAmountConverter.toNullableAmount(instance.limitPrice),
      'estimated_price':
          LemonMarketsAmountConverter.toAmount(instance.estimatedPrice),
      'charge': LemonMarketsAmountConverter.toAmount(instance.chargePrice),
      'chargeable_at':
          LemonMarketsTimeConverter.toIsoTimeNullable(instance.chargableAt),
      'status': LemonMarketsResultConverter.toOrderStatus(instance.status),
      'venue': instance.tradingVenueMic,
      'notes': instance.notes,
      'regulatory_information': instance.regulatoryInformation,
    };
