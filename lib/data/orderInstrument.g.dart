// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderInstrument.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderInstrument _$OrderInstrumentFromJson(Map<String, dynamic> json) {
  return OrderInstrument(
    json['isin'] as String,
    json['title'] as String,
  );
}

Map<String, dynamic> _$OrderInstrumentToJson(OrderInstrument instance) =>
    <String, dynamic>{
      'isin': instance.isin,
      'title': instance.title,
    };
