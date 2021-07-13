import 'package:json_annotation/json_annotation.dart';

part 'createdOrder.g.dart';

@JsonSerializable()
class CreatedOrder {
  @JsonKey(name: 'isin')
  String isin;

  @JsonKey(name: 'valid_until')
  double validUntil;

  @JsonKey(name: 'side')
  String side;

  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(name: 'stop_price')
  double? stopPrice;

  @JsonKey(name: 'limit_price')
  double? limitPrice;

  @JsonKey(name: 'uuid')
  String uuid;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'trading_venue_mic')
  String? tradingVenueMic;


  CreatedOrder(this.isin, this.validUntil, this.side, this.quantity, this.stopPrice, this.limitPrice, this.uuid, this.status, this.tradingVenueMic);

  factory CreatedOrder.fromJson(Map<String, dynamic> json) => _$CreatedOrderFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedOrderToJson(this);
}