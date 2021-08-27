// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'existingOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExistingOrder _$ExistingOrderFromJson(Map<String, dynamic> json) {
  return ExistingOrder(
    LemonMarketsTimeConverter.getUTXUnixDateTimeForLemonMarket(
        json['valid_until'] as double),
    LemonMarketsResultConverter.fromOrderSide(json['side'] as String),
    json['quantity'] as int,
    LemonMarketsResultConverter.toDoubleNullable(json['stop_price'] as String?),
    LemonMarketsResultConverter.toDoubleNullable(
        json['limit_price'] as String?),
    json['uuid'] as String,
    LemonMarketsResultConverter.fromOrderStatus(json['status'] as String),
    LemonMarketsResultConverter.toDoubleNullable(
        json['average_price'] as String?),
    LemonMarketsTimeConverter.getUTXUnixDateTimeForLemonMarket(
        json['created_at'] as double),
    LemonMarketsResultConverter.fromOrderType(json['type'] as String),
    LemonMarketsTimeConverter.getUTXUnixDateTimeForLemonMarketNullable(
        json['processed_at'] as double?),
    json['processed_quantity'] as int?,
    OrderInstrument.fromJson(json['instrument'] as Map<String, dynamic>),
  )..tradingVenueMic = json['trading_venue_mic'] as String?;
}

Map<String, dynamic> _$ExistingOrderToJson(ExistingOrder instance) =>
    <String, dynamic>{
      'valid_until':
          LemonMarketsTimeConverter.getUTCUnixTimestamp(instance.validUntil),
      'side': _$OrderSideEnumMap[instance.side],
      'quantity': instance.quantity,
      'stop_price': instance.stopPrice,
      'limit_price': instance.limitPrice,
      'uuid': instance.uuid,
      'status': LemonMarketsResultConverter.toOrderStatus(instance.status),
      'average_price': instance.averagePrice,
      'created_at':
          LemonMarketsTimeConverter.getUTCUnixTimestamp(instance.createdAt),
      'type': LemonMarketsResultConverter.toOrderType(instance.type),
      'processed_at': LemonMarketsTimeConverter.getUTCUnixTimestampNullable(
          instance.processedAt),
      'processed_quantity': instance.processedQuantity,
      'trading_venue_mic': instance.tradingVenueMic,
      'instrument': instance.instrument,
    };

const _$OrderSideEnumMap = {
  OrderSide.buy: 'buy',
  OrderSide.sell: 'sell',
  OrderSide.unknown: 'unknown',
};
