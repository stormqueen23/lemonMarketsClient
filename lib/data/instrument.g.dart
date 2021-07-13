// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instrument.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Instrument _$InstrumentFromJson(Map<String, dynamic> json) {
  return Instrument(
    json['isin'] as String,
    json['wkn'] as String,
    json['title'] as String,
    json['type'] as String,
    json['symbol'] as String,
    json['name'] as String,
    json['currency'] as String,
    json['tradable'] as bool,
  );
}

Map<String, dynamic> _$InstrumentToJson(Instrument instance) =>
    <String, dynamic>{
      'isin': instance.isin,
      'wkn': instance.wkn,
      'symbol': instance.symbol,
      'name': instance.name,
      'title': instance.title,
      'type': instance.type,
      'currency': instance.currency,
      'tradable': instance.tradable,
    };
