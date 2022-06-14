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
      json['status'] as String?,
      (json['results'] as List<dynamic>).map(fromJsonT).toList(),
      LemonMarketsTimeConverter.fromIsoTimeNullable(json['time'] as String?),
      LemonMarketsResultConverter.fromAccountMode(json['mode'] as String),
    )
      ..rateLimitInfo = json['rateLimitInfo'] == null
          ? null
          : RateLimitInfo.fromJson(
              json['rateLimitInfo'] as Map<String, dynamic>)
      ..next = json['next'] as String?
      ..previous = json['previous'] as String?
      ..count = json['total'] as int?
      ..page = json['page'] as int?
      ..pages = json['pages'] as int?;
