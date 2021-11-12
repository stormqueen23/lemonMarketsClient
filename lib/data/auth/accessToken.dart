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
  
  String? getSpace() {
    Map<String, List<String>> all = getScopes();
    print(all.toString());
    return all['space']?.first;
  }

  Map<String, List<String>> getScopes() {
    Map<String, List<String>> result = {};
  List<String> all = scope.split(" ");
    all.forEach((element) {
      List<String> keyValue = element.split(":");
      if (keyValue.length == 2) {
        result.putIfAbsent(keyValue[0], () => []);
        result[keyValue[0]]!.add(keyValue[1]);
      }
    });
    return result;
  }
}