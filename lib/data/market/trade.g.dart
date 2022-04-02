// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trade _$TradeFromJson(Map<String, dynamic> json) => Trade(
      json['isin'] as String,
      (json['p'] as num).toDouble(),
      (json['pbv'] as num?)?.toDouble(),
      (json['v'] as num).toDouble(),
      LemonMarketsTimeConverter.fromIsoTime(json['t'] as String),
      json['mic'] as String,
    );

Map<String, dynamic> _$TradeToJson(Trade instance) => <String, dynamic>{
      'isin': instance.isin,
      'p': instance.price,
      'v': instance.volume,
      'pbv': instance.pbv,
      'mic': instance.mic,
      't': LemonMarketsTimeConverter.toIsoTime(instance.time),
    };
