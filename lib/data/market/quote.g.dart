// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quote _$QuoteFromJson(Map<String, dynamic> json) => Quote(
      json['isin'] as String,
      (json['a'] as num).toDouble(),
      (json['a_v'] as num).toDouble(),
      (json['b'] as num).toDouble(),
      (json['b_v'] as num).toDouble(),
      LemonMarketsTimeConverter.fromIsoTime(json['t'] as String),
      json['mic'] as String,
    );

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
      'isin': instance.isin,
      'a': instance.ask,
      'a_v': instance.askVolume,
      'b': instance.bit,
      'b_v': instance.bitVolume,
      'mic': instance.mic,
      't': LemonMarketsTimeConverter.toIsoTime(instance.time),
    };
