// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spaceState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpaceState _$SpaceStateFromJson(Map<String, dynamic> json) {
  return SpaceState(
    LemonMarketsResultConverter.toDouble(json['balance'] as String),
    LemonMarketsResultConverter.toDouble(json['cash_to_invest'] as String),
  );
}

Map<String, dynamic> _$SpaceStateToJson(SpaceState instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'cash_to_invest': instance.cashToInvest,
    };
