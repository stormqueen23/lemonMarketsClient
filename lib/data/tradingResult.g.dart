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
      LemonMarketsResultConverter.fromAccountMode(json['mode'] as String),
    )
      ..time =
          LemonMarketsTimeConverter.fromIsoTimeNullable(json['time'] as String?)
      ..errorCode = json['error_code'] as String?
      ..errorMessage = json['error_message'] as String?
      ..result = _$nullableGenericFromJson(json['results'], fromJsonT);

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);
