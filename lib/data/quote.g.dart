// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quote _$QuoteFromJson(Map<String, dynamic> json) {
  return Quote(
    json['isin'] as String,
    (json['a'] as num).toDouble(),
    (json['a_v'] as num).toDouble(),
    (json['b'] as num).toDouble(),
    (json['b_v'] as num).toDouble(),
    LemonMarketsTimeConverter.getDateTimeForLemonMarket(json['t'] as int),
    json['mic'] as String,
  );
}

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
      'isin': instance.isin,
      'a': instance.ask,
      'a_v': instance.askVolume,
      'b': instance.bit,
      'b_v': instance.bitVolume,
      'mic': instance.mic,
      't': LemonMarketsTimeConverter.getDoubleTimeForDateTime(instance.time),
    };
