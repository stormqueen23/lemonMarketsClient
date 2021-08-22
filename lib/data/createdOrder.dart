import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/helper/lemonMarketsResultConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';

part 'createdOrder.g.dart';

@JsonSerializable()
class CreatedOrder {
  @JsonKey(name: 'isin')
  String isin;

  @JsonKey(name: 'valid_until', fromJson: LemonMarketsTimeConverter.getUTXUnixDateTimeForLemonMarket, toJson: LemonMarketsTimeConverter.getUTCUnixTimestamp)
  DateTime validUntil;

  @JsonKey(name: 'side')
  String side;

  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(name: 'stop_price', fromJson: LemonMarketsResultConverter.toDoubleNullable)
  double? stopPrice;

  @JsonKey(name: 'limit_price', fromJson: LemonMarketsResultConverter.toDoubleNullable)
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