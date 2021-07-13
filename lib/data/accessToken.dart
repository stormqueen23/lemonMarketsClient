import 'package:json_annotation/json_annotation.dart';

part 'accessToken.g.dart';

@JsonSerializable()
class AccessToken {
  @JsonKey(name: 'access_token')
  String access_token;
  @JsonKey(name: 'expires_in')
  int expires_in;
  @JsonKey(name: 'scope')
  String scope;
  @JsonKey(name: 'token_type')
  String type;

  AccessToken(this.access_token, this.expires_in, this.scope, this.type);

  factory AccessToken.fromJson(Map<String, dynamic> json) => _$AccessTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenToJson(this);
}