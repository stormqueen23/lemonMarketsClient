// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rateLimitInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateLimitInfo _$RateLimitInfoFromJson(Map<String, dynamic> json) =>
    RateLimitInfo(
      rateLimitReset: json['rateLimitReset'] as int?,
      remainingRateLimit: json['remainingRateLimit'] as int?,
      limitRateLimit: json['limitRateLimit'] as int?,
    );

Map<String, dynamic> _$RateLimitInfoToJson(RateLimitInfo instance) =>
    <String, dynamic>{
      'limitRateLimit': instance.limitRateLimit,
      'remainingRateLimit': instance.remainingRateLimit,
      'rateLimitReset': instance.rateLimitReset,
    };
