// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolioTransaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioTransaction _$PortfolioTransactionFromJson(Map<String, dynamic> json) {
  return PortfolioTransaction(
    json['quantity'] as int,
    json['order_id'] as String,
    json['uuid'] as String,
    LemonMarketsResultConverter.toDouble(json['average_price'] as String),
    json['side'] as String,
    TransactionOrderInstrument.fromJson(
        json['instrument'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PortfolioTransactionToJson(
        PortfolioTransaction instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'order_id': instance.orderUuid,
      'uuid': instance.transactionUuid,
      'average_price': instance.averagePrice,
      'side': instance.side,
      'instrument': instance.orderInstrument,
    };
