// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createdOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatedOrder _$CreatedOrderFromJson(Map<String, dynamic> json) => CreatedOrder(
      json['isin'] as String,
      LemonMarketsTimeConverter.fromIsoTime(json['expires_at'] as String),
      LemonMarketsResultConverter.fromOrderSide(json['side'] as String),
      json['quantity'] as int,
      LemonMarketsAmountConverter.fromNullableAmount(
          json['stop_price'] as int?),
      LemonMarketsAmountConverter.fromNullableAmount(
          json['limit_price'] as int?),
      json['id'] as String,
      LemonMarketsResultConverter.fromOrderStatus(json['status'] as String),
      json['venue'] as String?,
      LemonMarketsAmountConverter.fromAmount(json['estimated_price'] as int),
      json['notes'] as String?,
      RegulatoryInformation.fromJson(
          json['regulatory_information'] as Map<String, dynamic>),
      json['space_id'] as String,
      LemonMarketsTimeConverter.fromIsoTimeNullable(
          json['chargeable_at'] as String?),
      LemonMarketsAmountConverter.fromAmount(json['charge'] as int),
    );

Map<String, dynamic> _$CreatedOrderToJson(CreatedOrder instance) =>
    <String, dynamic>{
      'id': instance.uuid,
      'isin': instance.isin,
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
      'space_id': instance.spaceUuid,
      'regulatory_information': instance.regulatoryInformation,
    };
