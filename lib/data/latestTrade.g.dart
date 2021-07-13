// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latestTrade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatestTrade _$LatestTradeFromJson(Map<String, dynamic> json) {
  return LatestTrade(
    (json['p'] as num).toDouble(),
    (json['v'] as num).toDouble(),
    (json['t'] as num).toDouble(),
  );
}

Map<String, dynamic> _$LatestTradeToJson(LatestTrade instance) =>
    <String, dynamic>{
      'p': instance.price,
      'v': instance.volume,
      't': instance.t,
    };
