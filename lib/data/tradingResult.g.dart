// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tradingResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradingResult<T> _$TradingResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    TradingResult<T>(
      json['status'] as String,
    )..result = _$nullableGenericFromJson(json['result'], fromJsonT);

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);
