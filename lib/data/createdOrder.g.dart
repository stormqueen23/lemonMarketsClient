// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createdOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatedOrder _$CreatedOrderFromJson(Map<String, dynamic> json) {
  return CreatedOrder(
    json['isin'] as String,
    LemonMarketsTimeConverter.getUTXUnixDateTimeForLemonMarket(
        json['valid_until'] as double),
    LemonMarketsResultConverter.fromOrderSide(json['side'] as String),
    json['quantity'] as int,
    LemonMarketsResultConverter.toDoubleNullable(json['stop_price'] as String?),
    LemonMarketsResultConverter.toDoubleNullable(
        json['limit_price'] as String?),
    json['uuid'] as String,
    LemonMarketsResultConverter.fromOrderStatus(json['status'] as String),
    json['trading_venue_mic'] as String?,
  );
}

Map<String, dynamic> _$CreatedOrderToJson(CreatedOrder instance) =>
    <String, dynamic>{
      'isin': instance.isin,
      'valid_until':
          LemonMarketsTimeConverter.getUTCUnixTimestamp(instance.validUntil),
      'side': LemonMarketsResultConverter.toOrderSide(instance.side),
      'quantity': instance.quantity,
      'stop_price': instance.stopPrice,
      'limit_price': instance.limitPrice,
      'uuid': instance.uuid,
      'status': LemonMarketsResultConverter.toOrderStatus(instance.status),
      'trading_venue_mic': instance.tradingVenueMic,
    };
