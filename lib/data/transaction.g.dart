// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    LemonMarketsResultConverter.toDouble(json['amount'] as String),
    json['uuid'] as String,
    LemonMarketsTimeConverter.getUTXUnixDateTimeForLemonMarket(
        json['created_at'] as double),
    json['type'] as String,
    json['order'] == null
        ? null
        : TransactionOrder.fromJson(json['order'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'uuid': instance.uuid,
      'created_at':
          LemonMarketsTimeConverter.getUTCUnixTimestamp(instance.createdAt),
      'type': instance.type,
      'order': instance.order,
    };
