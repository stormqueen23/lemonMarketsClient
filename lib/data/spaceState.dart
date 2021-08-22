import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/helper/lemonMarketsResultConverter.dart';

part 'spaceState.g.dart';

@JsonSerializable()
class SpaceState {

  @JsonKey(name: 'balance', fromJson: LemonMarketsResultConverter.toDouble)
  double balance;

  @JsonKey(name: 'cash_to_invest', fromJson: LemonMarketsResultConverter.toDouble)
  double cashToInvest;

  SpaceState(this.balance, this.cashToInvest);

  factory SpaceState.fromJson(Map<String, dynamic> json) => _$SpaceStateFromJson(json);

  Map<String, dynamic> toJson() => _$SpaceStateToJson(this);

}