// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactionOrderInstrument.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionOrderInstrument _$TransactionOrderInstrumentFromJson(
    Map<String, dynamic> json) {
  return TransactionOrderInstrument(
    json['title'] as String,
    json['isin'] as String,
  );
}

Map<String, dynamic> _$TransactionOrderInstrumentToJson(
        TransactionOrderInstrument instance) =>
    <String, dynamic>{
      'title': instance.title,
      'isin': instance.isin,
    };
