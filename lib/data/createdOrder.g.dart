// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createdOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatedOrder _$CreatedOrderFromJson(Map<String, dynamic> json) {
  return CreatedOrder(
    json['isin'] as String,
    (json['valid_until'] as num).toDouble(),
    json['side'] as String,
    json['quantity'] as int,
    (json['stop_price'] as num?)?.toDouble(),
    (json['limit_price'] as num?)?.toDouble(),
    json['uuid'] as String,
    json['status'] as String,
    json['trading_venue_mic'] as String?,
  );
}

Map<String, dynamic> _$CreatedOrderToJson(CreatedOrder instance) =>
    <String, dynamic>{
      'isin': instance.isin,
      'valid_until': instance.validUntil,
      'side': instance.side,
      'quantity': instance.quantity,
      'stop_price': instance.stopPrice,
      'limit_price': instance.limitPrice,
      'uuid': instance.uuid,
      'status': instance.status,
      'trading_venue_mic': instance.tradingVenueMic,
    };
