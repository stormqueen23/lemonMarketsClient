// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tradingVenue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradingVenue _$TradingVenueFromJson(Map<String, dynamic> json) {
  return TradingVenue(
    json['name'] as String,
    json['title'] as String,
    json['mic'] as String,
    json['is_open'] as bool,
    OpeningHour.fromJson(json['opening_hours'] as Map<String, dynamic>),
    (json['opening_days'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$TradingVenueToJson(TradingVenue instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'mic': instance.mic,
      'is_open': instance.isOpen,
      'opening_hours': instance.hour,
      'opening_days': instance.openingDays,
    };
