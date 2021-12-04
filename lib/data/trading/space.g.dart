// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Space _$SpaceFromJson(Map<String, dynamic> json) => Space(
      json['id'] as String,
      json['name'] as String,
      LemonMarketsResultConverter.fromSpaceType(json['type'] as String),
      LemonMarketsAmountConverter.fromAmount(json['risk_limit'] as int),
      LemonMarketsAmountConverter.fromAmount(json['buying_power'] as int),
      LemonMarketsAmountConverter.fromAmount(json['earnings'] as int),
      LemonMarketsAmountConverter.fromAmount(json['backfire'] as int),
      LemonMarketsTimeConverter.fromIsoTime(json['created_at'] as String),
    )
      ..description = json['description'] as String?
      ..linked = json['linked'] as String?;

Map<String, dynamic> _$SpaceToJson(Space instance) => <String, dynamic>{
      'id': instance.uuid,
      'created_at': LemonMarketsTimeConverter.toIsoTime(instance.createdAt),
      'name': instance.name,
      'description': instance.description,
      'type': LemonMarketsResultConverter.toSpaceType(instance.type),
      'risk_limit': LemonMarketsAmountConverter.toAmount(instance.riskLimit),
      'buying_power':
          LemonMarketsAmountConverter.toAmount(instance.buyingPower),
      'earnings': LemonMarketsAmountConverter.toAmount(instance.earnings),
      'backfire': LemonMarketsAmountConverter.toAmount(instance.backfire),
      'linked': instance.linked,
    };
