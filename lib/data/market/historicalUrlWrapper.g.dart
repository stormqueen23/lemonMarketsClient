// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historicalUrlWrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoricalUrlWrapper _$HistoricalUrlWrapperFromJson(
        Map<String, dynamic> json) =>
    HistoricalUrlWrapper(
      LemonMarketsTimeConverter.fromIsoTime(json['time'] as String),
      HistoricalUrlResult.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HistoricalUrlWrapperToJson(
        HistoricalUrlWrapper instance) =>
    <String, dynamic>{
      'time': LemonMarketsTimeConverter.toIsoTime(instance.time),
      'results': instance.result,
    };
