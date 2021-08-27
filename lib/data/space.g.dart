// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Space _$SpaceFromJson(Map<String, dynamic> json) {
  return Space(
    json['uuid'] as String,
    json['name'] as String,
    json['type'] as String,
    SpaceState.fromJson(json['state'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SpaceToJson(Space instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'type': instance.type,
      'state': instance.state,
    };
