// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stateInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateInfo _$StateInfoFromJson(Map<String, dynamic> json) {
  return StateInfo(
    json['cash_account_number'] as String,
    json['securities_account_number'] as String,
    StateDetailInfo.fromJson(json['details'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StateInfoToJson(StateInfo instance) => <String, dynamic>{
      'cash_account_number': instance.cashAccountNumber,
      'securities_account_number': instance.securitiesAccountNumber,
      'details': instance.details,
    };
