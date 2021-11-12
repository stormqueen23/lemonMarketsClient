// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instrument.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Instrument _$InstrumentFromJson(Map<String, dynamic> json) => Instrument(
      json['isin'] as String,
      json['wkn'] as String,
      json['name'] as String,
      json['title'] as String,
      json['symbol'] as String,
      json['type'] as String,
      (json['venues'] as List<dynamic>)
          .map(
              (e) => InstrumentTradingVenue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InstrumentToJson(Instrument instance) =>
    <String, dynamic>{
      'isin': instance.isin,
      'wkn': instance.wkn,
      'name': instance.name,
      'title': instance.title,
      'symbol': instance.symbol,
      'type': instance.type,
      'venues': instance.venues,
    };
