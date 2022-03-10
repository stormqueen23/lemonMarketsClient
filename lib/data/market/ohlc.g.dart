// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ohlc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OHLC _$OHLCFromJson(Map<String, dynamic> json) => OHLC(
      json['isin'] as String,
      (json['o'] as num).toDouble(),
      (json['h'] as num).toDouble(),
      (json['l'] as num).toDouble(),
      (json['c'] as num).toDouble(),
      LemonMarketsTimeConverter.getDateTimeForLemonMarket(json['t'] as int),
      json['mic'] as String,
      (json['v'] as num?)?.toDouble(),
      (json['pbv'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OHLCToJson(OHLC instance) => <String, dynamic>{
      'isin': instance.isin,
      'o': instance.open,
      'h': instance.high,
      'l': instance.low,
      'c': instance.close,
      'v': instance.volume,
      'pbv': instance.pbv,
      'mic': instance.mic,
      't': LemonMarketsTimeConverter.getDoubleTimeForDateTime(instance.time),
    };
