// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instrumentTradingVenue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstrumentTradingVenue _$InstrumentTradingVenueFromJson(
        Map<String, dynamic> json) =>
    InstrumentTradingVenue(
      json['name'] as String,
      json['title'] as String,
      json['mic'] as String,
      json['is_open'] as bool,
      json['currency'] as String,
      json['tradable'] as bool,
    );

Map<String, dynamic> _$InstrumentTradingVenueToJson(
        InstrumentTradingVenue instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'mic': instance.mic,
      'is_open': instance.isOpen,
      'currency': instance.currency,
      'tradable': instance.tradable,
    };
