import 'package:json_annotation/json_annotation.dart';

part 'accessToken.g.dart';

@JsonSerializable()
class AccessToken {
  @JsonKey(name: 'access_token')
  String token;
  @JsonKey(name: 'expires_in') //seconds
  int expiresIn;
  @JsonKey(name: 'scope')
  String scope;
  @JsonKey(name: 'token_type')
  String type;

  AccessToken(this.token, this.expiresIn, this.scope, this.type);

  factory AccessToken.fromJson(Map<String, dynamic> json) => _$AccessTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenToJson(this);
}