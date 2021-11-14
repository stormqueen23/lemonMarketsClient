import 'package:json_annotation/json_annotation.dart';

part 'accessToken.g.dart';

@JsonSerializable()
class AccessToken {
  @JsonKey(name: 'access_token')
  String token;
  @JsonKey(name: 'token_type')
  String type;

  AccessToken({required this.token, this.type = 'bearer'});

  factory AccessToken.fromJson(Map<String, dynamic> json) => _$AccessTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenToJson(this);

}