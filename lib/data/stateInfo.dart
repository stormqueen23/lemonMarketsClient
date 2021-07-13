import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_market_client/data/stateDetailInfo.dart';

part 'stateInfo.g.dart';

@JsonSerializable()
class StateInfo {
  @JsonKey(name: 'cash_account_number')
  String cashAccountNumber;
  @JsonKey(name: 'securities_account_number')
  String securitiesAccountNumber;

  @JsonKey()
  StateDetailInfo details;

  StateInfo(this.cashAccountNumber, this.securitiesAccountNumber, this.details);

  factory StateInfo.fromJson(Map<String, dynamic> json) => _$StateInfoFromJson(json);

  Map<String, dynamic> toJson() => _$StateInfoToJson(this);

}