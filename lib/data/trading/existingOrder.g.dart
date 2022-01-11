// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'existingOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExistingOrder _$ExistingOrderFromJson(Map<String, dynamic> json) =>
    ExistingOrder(
      json['id'] as String,
      json['key_creation_id'] as String?,
      json['isin'] as String,
      LemonMarketsTimeConverter.fromIsoTime(json['expires_at'] as String),
      LemonMarketsTimeConverter.fromIsoTime(json['created_at'] as String),
      LemonMarketsResultConverter.fromOrderSide(json['side'] as String),
      json['quantity'] as int,
      LemonMarketsAmountConverter.fromNullableAmount(
          json['stop_price'] as num?),
      LemonMarketsAmountConverter.fromNullableAmount(
          json['limit_price'] as num?),
      LemonMarketsAmountConverter.fromNullableAmount(
          json['estimated_price'] as num?),
      json['venue'] as String,
      LemonMarketsResultConverter.fromOrderStatus(json['status'] as String),
      json['space_id'] as String,
      LemonMarketsResultConverter.fromOrderType(json['type'] as String),
      json['executed_quantity'] as int?,
      LemonMarketsAmountConverter.fromNullableAmount(
          json['executed_price'] as num?),
      LemonMarketsTimeConverter.fromIsoTimeNullable(
          json['executed_at'] as String?),
      LemonMarketsTimeConverter.fromIsoTimeNullable(
          json['rejected_at'] as String?),
      json['notes'] as String?,
      LemonMarketsTimeConverter.fromIsoTimeNullable(
          json['chargeable_at'] as String?),
      LemonMarketsAmountConverter.fromAmount(json['charge'] as num),
    )
      ..idempotency = json['idempotency'] as String?
      ..activationKey = json['key_activation_id'] as String?
      ..title = json['isin_title'] as String?
      ..estimatedPriceTotal = LemonMarketsAmountConverter.fromNullableAmount(
          json['estimated_price_total'] as num?)
      ..executedPriceTotal = LemonMarketsAmountConverter.fromNullableAmount(
          json['executed_price_total'] as num?)
      ..activatedAt = LemonMarketsTimeConverter.fromIsoTimeNullable(
          json['activated_at'] as String?)
      ..regulatoryInformation = json['regulatory_information'] == null
          ? null
          : RegulatoryInformation.fromJson(
              json['regulatory_information'] as Map<String, dynamic>);

Map<String, dynamic> _$ExistingOrderToJson(ExistingOrder instance) =>
    <String, dynamic>{
      'id': instance.uuid,
      'idempotency': instance.idempotency,
      'key_creation_id': instance.creationKey,
      'key_activation_id': instance.activationKey,
      'isin': instance.isin,
      'isin_title': instance.title,
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
      'estimated_price_total': LemonMarketsAmountConverter.toNullableAmount(
          instance.estimatedPriceTotal),
      'charge': LemonMarketsAmountConverter.toAmount(instance.chargePrice),
      'chargeable_at':
          LemonMarketsTimeConverter.toIsoTimeNullable(instance.chargableAt),
      'venue': instance.tradingVenueMic,
      'status': LemonMarketsResultConverter.toOrderStatus(instance.status),
      'space_id': instance.spaceUuid,
      'type': LemonMarketsResultConverter.toOrderType(instance.type),
      'executed_quantity': instance.executedQuantity,
      'executed_price':
          LemonMarketsAmountConverter.toNullableAmount(instance.executedPrice),
      'executed_price_total': LemonMarketsAmountConverter.toNullableAmount(
          instance.executedPriceTotal),
      'activated_at':
          LemonMarketsTimeConverter.toIsoTimeNullable(instance.activatedAt),
      'executed_at':
          LemonMarketsTimeConverter.toIsoTimeNullable(instance.executedAt),
      'rejected_at':
          LemonMarketsTimeConverter.toIsoTimeNullable(instance.rejectedAt),
      'notes': instance.notes,
      'regulatory_information': instance.regulatoryInformation,
    };
