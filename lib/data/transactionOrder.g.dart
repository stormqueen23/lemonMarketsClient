// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactionOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionOrder _$TransactionOrderFromJson(Map<String, dynamic> json) {
  return TransactionOrder(
    json['uuid'] as String,
    json['processed_quantity'] as int,
    LemonMarketsResultConverter.toDouble(json['average_price'] as String),
    TransactionOrderInstrument.fromJson(
        json['instrument'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransactionOrderToJson(TransactionOrder instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'processed_quantity': instance.processedQuantity,
      'average_price': instance.averagePrice,
      'instrument': instance.instrument,
    };
