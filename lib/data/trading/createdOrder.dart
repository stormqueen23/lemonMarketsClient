import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

part 'createdOrder.g.dart';

@JsonSerializable()
class CreatedOrder {
  @JsonKey(name: 'id')
  String uuid;

  @JsonKey(name: 'key_creation_id')
  String creationKey;

  @JsonKey(name: 'isin')
  String isin;

  @JsonKey(
      name: 'created_at', fromJson: LemonMarketsTimeConverter.fromIsoTime, toJson: LemonMarketsTimeConverter.toIsoTime)
  DateTime createdAt;

  @JsonKey(
      name: 'expires_at', fromJson: LemonMarketsTimeConverter.fromIsoTime, toJson: LemonMarketsTimeConverter.toIsoTime)
  DateTime validUntil;

  @JsonKey(
      name: 'side',
      fromJson: LemonMarketsResultConverter.fromOrderSide,
      toJson: LemonMarketsResultConverter.toOrderSide)
  OrderSide side;

  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(
      name: 'stop_price',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? stopPrice;

  @JsonKey(
      name: 'limit_price',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? limitPrice;

  @JsonKey(
      name: 'estimated_price',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount estimatedPrice;

  @JsonKey(
      name: 'charge',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount chargePrice;

  @JsonKey(
      name: 'chargeable_at', fromJson: LemonMarketsTimeConverter.fromIsoTimeNullable, toJson: LemonMarketsTimeConverter.toIsoTimeNullable)
  DateTime? chargableAt;

  @JsonKey(
      name: 'status',
      fromJson: LemonMarketsResultConverter.fromOrderStatus,
      toJson: LemonMarketsResultConverter.toOrderStatus)
  OrderStatus status;

  @JsonKey(name: 'venue')
  String? tradingVenueMic;

  @JsonKey(name: 'notes')
  String? notes;

  @JsonKey(name: 'regulatory_information')
  RegulatoryInformation regulatoryInformation;

  CreatedOrder(this.isin, this.creationKey, this.validUntil, this.side, this.quantity, this.stopPrice, this.limitPrice, this.uuid,
      this.status, this.tradingVenueMic, this.estimatedPrice, this.notes, this.regulatoryInformation,
      this.chargableAt, this.chargePrice, this.createdAt);

  factory CreatedOrder.fromJson(Map<String, dynamic> json) => _$CreatedOrderFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedOrderToJson(this);

  @override
  String toString() {
    return 'CreatedOrder{\n'
        'uuid: $uuid,\n'
        'key_creation_id: $creationKey,\n'
        'isin: $isin,\n'
        'validUntil: $validUntil,\n'
        'side: $side,\n'
        'quantity: $quantity,\n'
        'stopPrice: $stopPrice,\n'
        'limitPrice: $limitPrice,\n'
        'estimatedPrice: $estimatedPrice,\n'
        'status: $status,\n'
        'tradingVenueMic: $tradingVenueMic,\n'
        'notes: $notes,\n'
        'charge: $chargePrice,\n'
        'chargableAtAt: $chargableAt,\n'
        'regulatoryInformation: $regulatoryInformation\n'
        '}';
  }
}
