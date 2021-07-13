// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ohlc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OHLC _$OHLCFromJson(Map<String, dynamic> json) {
  return OHLC(
    (json['o'] as num).toDouble(),
    (json['h'] as num).toDouble(),
    (json['l'] as num).toDouble(),
    (json['c'] as num).toDouble(),
    (json['t'] as num).toDouble(),
  );
}

Map<String, dynamic> _$OHLCToJson(OHLC instance) => <String, dynamic>{
      'o': instance.open,
      'h': instance.high,
      'l': instance.low,
      'c': instance.close,
      't': instance.time,
    };
