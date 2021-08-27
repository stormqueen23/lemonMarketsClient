// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openingHour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpeningHour _$OpeningHourFromJson(Map<String, dynamic> json) {
  return OpeningHour(
    json['start'] as String,
    json['end'] as String,
    json['timezone'] as String,
  );
}

Map<String, dynamic> _$OpeningHourToJson(OpeningHour instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'timezone': instance.timezone,
    };
