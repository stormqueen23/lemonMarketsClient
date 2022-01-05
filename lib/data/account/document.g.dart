// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      json['id'] as String,
      json['name'] as String,
      json['category'] as String,
      json['link'] as String,
      LemonMarketsTimeConverter.fromIsoTime(json['created_at'] as String),
      LemonMarketsTimeConverter.fromIsoTimeNullable(
          json['viewed_first_at'] as String?),
      LemonMarketsTimeConverter.fromIsoTimeNullable(
          json['viewed_last_at'] as String?),
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'id': instance.uuid,
      'name': instance.name,
      'category': instance.category,
      'link': instance.link,
      'created_at': LemonMarketsTimeConverter.toIsoTime(instance.createdAt),
      'viewed_first_at':
          LemonMarketsTimeConverter.toIsoTimeNullable(instance.firstViewedAt),
      'viewed_last_at':
          LemonMarketsTimeConverter.toIsoTimeNullable(instance.lastViewedAt),
    };
