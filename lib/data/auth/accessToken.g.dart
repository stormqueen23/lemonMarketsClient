// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessToken.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessToken _$AccessTokenFromJson(Map<String, dynamic> json) => AccessToken(
      token: json['access_token'] as String,
      type: json['token_type'] as String? ?? 'bearer',
    );

Map<String, dynamic> _$AccessTokenToJson(AccessToken instance) =>
    <String, dynamic>{
      'access_token': instance.token,
      'token_type': instance.type,
    };
