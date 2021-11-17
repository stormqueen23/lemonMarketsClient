// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tradingResultList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradingResultList<T> _$TradingResultListFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    TradingResultList<T>(
      json['status'] as String,
      (json['results'] as List<dynamic>).map(fromJsonT).toList(),
    );
