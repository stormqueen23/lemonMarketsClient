// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      json['id'] as String,
      json['account_id'] as String,
      json['space_id'] as String?,
      json['order_id'] as String?,
      LemonMarketsResultConverter.fromTransactionType(json['type'] as String),
      LemonMarketsAmountConverter.fromAmount(json['amount'] as int),
      json['isin'] as String?,
      LemonMarketsTimeConverter.fromIsoTime(json['created_at'] as String),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.uuid,
      'account_id': instance.accountId,
      'space_id': instance.spaceId,
      'order_id': instance.orderId,
      'type': LemonMarketsResultConverter.toTransactionType(instance.type),
      'amount': LemonMarketsAmountConverter.toAmount(instance.amount),
      'isin': instance.isin,
      'created_at': LemonMarketsTimeConverter.toIsoTime(instance.createdAt),
    };
