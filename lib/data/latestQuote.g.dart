// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latestQuote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatestQuote _$LatestQuoteFromJson(Map<String, dynamic> json) {
  return LatestQuote(
    (json['a'] as num).toDouble(),
    (json['a_v'] as num).toDouble(),
    (json['b'] as num).toDouble(),
    (json['b_v'] as num).toDouble(),
    (json['t'] as num).toDouble(),
  );
}

Map<String, dynamic> _$LatestQuoteToJson(LatestQuote instance) =>
    <String, dynamic>{
      'a': instance.ask,
      'a_v': instance.askVolume,
      'b': instance.bit,
      'b_v': instance.bitVolume,
      't': instance.time,
    };
