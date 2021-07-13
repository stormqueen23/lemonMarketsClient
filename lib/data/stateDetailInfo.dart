import 'package:json_annotation/json_annotation.dart';

part 'stateDetailInfo.g.dart';

@JsonSerializable()
class StateDetailInfo {
  @JsonKey(name: 'balance')
  String balance;

  StateDetailInfo(this.balance);

  factory StateDetailInfo.fromJson(Map<String, dynamic> json) => _$StateDetailInfoFromJson(json);

  Map<String, dynamic> toJson() => _$StateDetailInfoToJson(this);

}