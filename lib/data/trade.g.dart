// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trade _$TradeFromJson(Map<String, dynamic> json) {
  return Trade(
    json['isin'] as String,
    (json['p'] as num).toDouble(),
    (json['v'] as num).toDouble(),
    LemonMarketsTimeConverter.getDateTimeForLemonMarket(json['t'] as int),
  );
}

Map<String, dynamic> _$TradeToJson(Trade instance) => <String, dynamic>{
      'isin': instance.isin,
      'p': instance.price,
      'v': instance.volume,
      't': LemonMarketsTimeConverter.getDoubleTimeForDateTime(instance.time),
    };
