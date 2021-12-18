// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bankStatement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankStatement _$BankStatementFromJson(Map<String, dynamic> json) =>
    BankStatement(
      json['id'] as String,
      json['account_id'] as String,
      LemonMarketsResultConverter.fromBankStatement(json['type'] as String),
      LemonMarketsTimeConverter.fromIsoDay(json['date'] as String),
      LemonMarketsAmountConverter.fromAmount(json['amount'] as int),
      json['isin'] as String?,
      json['isin_title'] as String?,
    );

Map<String, dynamic> _$BankStatementToJson(BankStatement instance) =>
    <String, dynamic>{
      'id': instance.uuid,
      'account_id': instance.accountId,
      'type': LemonMarketsResultConverter.toBankStatementType(instance.type),
      'date': LemonMarketsTimeConverter.toIsoDay(instance.date),
      'amount': LemonMarketsAmountConverter.toAmount(instance.amount),
      'isin': instance.isin,
      'isin_title': instance.isinTitle,
    };
