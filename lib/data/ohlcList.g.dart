// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ohlcList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OHLCList _$OHLCListFromJson(Map<String, dynamic> json) {
  return OHLCList(
    json['next'] as String,
    json['previous'] as String,
    (json['results'] as List<dynamic>)
        .map((e) => OHLC.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OHLCListToJson(OHLCList instance) => <String, dynamic>{
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.result,
    };
