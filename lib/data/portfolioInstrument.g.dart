// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolioInstrument.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioInstrument _$PortfolioInstrumentFromJson(Map<String, dynamic> json) {
  return PortfolioInstrument(
    json['title'] as String,
    json['isin'] as String,
  );
}

Map<String, dynamic> _$PortfolioInstrumentToJson(
        PortfolioInstrument instance) =>
    <String, dynamic>{
      'title': instance.title,
      'isin': instance.isin,
    };
