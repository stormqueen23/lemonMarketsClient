import 'package:json_annotation/json_annotation.dart';

part 'spaceState.g.dart';

@JsonSerializable()
class SpaceState {
  @JsonKey(name: 'balance')
  String balance;
  @JsonKey(name: 'cash_to_invest')
  String cashToInvest;

  SpaceState(this.balance, this.cashToInvest);

  factory SpaceState.fromJson(Map<String, dynamic> json) => _$SpaceStateFromJson(json);

  Map<String, dynamic> toJson() => _$SpaceStateToJson(this);

}