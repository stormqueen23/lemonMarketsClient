// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'positionStatement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionStatement _$PositionStatementFromJson(Map<String, dynamic> json) =>
    PositionStatement(
      json['id'] as String,
      json['isin'] as String,
      LemonMarketsResultConverter.fromPositionStatementType(
          json['type'] as String),
      json['quantity'] as int,
      LemonMarketsTimeConverter.fromDay(json['date'] as String),
      LemonMarketsTimeConverter.fromIsoTime(json['created_at'] as String),
    )
      ..orderUuid = json['order_id'] as String?
      ..externalUuid = json['external_id'] as String?
      ..isinTitle = json['isin_title'] as String?;

Map<String, dynamic> _$PositionStatementToJson(PositionStatement instance) =>
    <String, dynamic>{
      'id': instance.uuid,
      'order_id': instance.orderUuid,
      'external_id': instance.externalUuid,
      'type':
          LemonMarketsResultConverter.toPositionStatementType(instance.type),
      'isin': instance.isin,
      'isin_title': instance.isinTitle,
      'quantity': instance.quantity,
      'date': LemonMarketsTimeConverter.toDay(instance.date),
      'created_at': LemonMarketsTimeConverter.toIsoTime(instance.createdAt),
    };
