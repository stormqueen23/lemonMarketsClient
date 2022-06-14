import 'package:json_annotation/json_annotation.dart';

part 'rateLimitInfo.g.dart';

@JsonSerializable()
class RateLimitInfo {
  int? limitRateLimit;
  int? remainingRateLimit;
  int? rateLimitReset;

  RateLimitInfo({required this.rateLimitReset, required this.remainingRateLimit, required this.limitRateLimit});

  factory RateLimitInfo.fromJson(Map<String, dynamic> json) => _$RateLimitInfoFromJson(json);

  Map<String, dynamic> toJson() => _$RateLimitInfoToJson(this);

}