import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/helper/lemonMarketsResultConverter.dart';

part 'stateDetailInfo.g.dart';

@JsonSerializable()
class StateDetailInfo {

  @JsonKey(name: 'balance', fromJson: LemonMarketsResultConverter.toDouble)
  double balance;

  StateDetailInfo(this.balance);

  factory StateDetailInfo.fromJson(Map<String, dynamic> json) => _$StateDetailInfoFromJson(json);

  Map<String, dynamic> toJson() => _$StateDetailInfoToJson(this);

}