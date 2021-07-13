// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'existingOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExistingOrder _$ExistingOrderFromJson(Map<String, dynamic> json) {
  return ExistingOrder(
    (json['valid_until'] as num).toDouble(),
    json['side'] as String,
    json['quantity'] as int,
    json['stop_price'] as String?,
    json['limit_price'] as String?,
    json['uuid'] as String,
    json['status'] as String,
    json['average_price'] as String?,
    (json['created_at'] as num).toDouble(),
    json['type'] as String,
    (json['processed_at'] as num?)?.toDouble(),
    json['processed_quantity'] as int?,
    OrderInstrument.fromJson(json['instrument'] as Map<String, dynamic>),
  )..tradingVenueMic = json['trading_venue_mic'] as String?;
}

Map<String, dynamic> _$ExistingOrderToJson(ExistingOrder instance) =>
    <String, dynamic>{
      'valid_until': instance.validUntil,
      'side': instance.side,
      'quantity': instance.quantity,
      'stop_price': instance.stopPrice,
      'limit_price': instance.limitPrice,
      'uuid': instance.uuid,
      'status': instance.status,
      'average_price': instance.averagePrice,
      'created_at': instance.createdAt,
      'type': instance.type,
      'processed_at': instance.processedAt,
      'processed_quantity': instance.processedQuantity,
      'trading_venue_mic': instance.tradingVenueMic,
      'instrument': instance.instrument,
    };
