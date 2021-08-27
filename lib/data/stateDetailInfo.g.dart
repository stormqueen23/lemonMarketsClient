// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stateDetailInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateDetailInfo _$StateDetailInfoFromJson(Map<String, dynamic> json) {
  return StateDetailInfo(
    LemonMarketsResultConverter.toDouble(json['balance'] as String),
  );
}

Map<String, dynamic> _$StateDetailInfoToJson(StateDetailInfo instance) =>
    <String, dynamic>{
      'balance': instance.balance,
    };
