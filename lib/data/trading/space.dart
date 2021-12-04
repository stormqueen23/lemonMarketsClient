import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/amount.dart';
import 'package:lemon_markets_client/helper/lemonMarketsAmountConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsResultConverter.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

part 'space.g.dart';

@JsonSerializable()
class Space {
  @JsonKey(name: 'id')
  String uuid;

  @JsonKey(name: 'created_at', fromJson: LemonMarketsTimeConverter.fromIsoTime, toJson: LemonMarketsTimeConverter.toIsoTime)
  DateTime createdAt;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'type', fromJson: LemonMarketsResultConverter.fromSpaceType, toJson: LemonMarketsResultConverter.toSpaceType)
  SpaceType type;

  @JsonKey(name: 'risk_limit',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount riskLimit;

  @JsonKey(name: 'buying_power',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount buyingPower;

  @JsonKey(name: 'earnings',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount earnings;

  @JsonKey(name: 'backfire',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount backfire;

  @JsonKey(name: 'linked')
  String? linked;


  Space(this.uuid, this.name, this.type, this.riskLimit, this.buyingPower, this.earnings, this.backfire, this.createdAt);

  factory Space.fromJson(Map<String, dynamic> json) => _$SpaceFromJson(json);

  Map<String, dynamic> toJson() => _$SpaceToJson(this);

  @override
  String toString() {
    return 'Space{\n'
        'createdAt: $createdAt,\n'
        'uuid: $uuid,\n'
        'name: $name,\n'
        'description: $description,\n'
        'type: $type,\n'
        'riskLimit: $riskLimit,\n'
        'buyingPower: $buyingPower,\n'
        'earnings: $earnings,\n'
        'backfire: $backfire\n'
        '}';
  }
}