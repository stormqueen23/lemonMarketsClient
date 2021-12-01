// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resultList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultList<T> _$ResultListFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ResultList<T>(
      json['next'] as String?,
      json['previous'] as String?,
      (json['results'] as List<dynamic>).map(fromJsonT).toList(),
      json['total'] as int?,
    )
      ..page = json['page'] as int?
      ..pages = json['pages'] as int?;
