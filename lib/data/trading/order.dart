import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/amount.dart';
import 'package:lemon_markets_client/data/trading/regulatoryInformation.dart';
import 'package:lemon_markets_client/helper/lemonMarketsAmountConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsResultConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: 'id')
  String uuid;

  @JsonKey(name: 'idempotency')
  String? idempotency;

  @JsonKey(name: 'key_creation_id')
  String? creationKey;

  @JsonKey(name: 'key_activation_id')
  String? activationKey;

 @JsonKey(name: 'isin')
  String isin;

  @JsonKey(name: 'isin_title')
  String? title;

  @JsonKey(
      name: 'expires_at', fromJson: LemonMarketsTimeConverter.fromIsoTime, toJson: LemonMarketsTimeConverter.toIsoTime)
  DateTime expiresAt;

  @JsonKey(
      name: 'created_at', fromJson: LemonMarketsTimeConverter.fromIsoTime, toJson: LemonMarketsTimeConverter.toIsoTime)
  DateTime createdAt;

  @JsonKey(
      name: 'side',
      fromJson: LemonMarketsResultConverter.fromOrderSide,
      toJson: LemonMarketsResultConverter.toOrderSide)
  OrderSide side;

  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(name: 'stop_price',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? stopPrice;

  @JsonKey(name: 'limit_price',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? limitPrice;

  @JsonKey(name: 'estimated_price',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? estimatedPrice;

  @JsonKey(name: 'estimated_price_total',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? estimatedPriceTotal;

  @JsonKey(
      name: 'charge',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount chargePrice;

  @JsonKey(
      name: 'chargeable_at', fromJson: LemonMarketsTimeConverter.fromIsoTimeNullable, toJson: LemonMarketsTimeConverter.toIsoTimeNullable)
  DateTime? chargableAt;

  @JsonKey(name: 'venue')
  String tradingVenueMic;

  @JsonKey(
      name: 'status',
      fromJson: LemonMarketsResultConverter.fromOrderStatus,
      toJson: LemonMarketsResultConverter.toOrderStatus)
  OrderStatus status;

  @JsonKey(
      name: 'type',
      fromJson: LemonMarketsResultConverter.fromOrderType,
      toJson: LemonMarketsResultConverter.toOrderType)
  OrderType type;

  @JsonKey(name: 'executed_quantity')
  int? executedQuantity;

  @JsonKey(name: 'executed_price',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? executedPrice;

  @JsonKey(name: 'executed_price_total',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? executedPriceTotal;

  @JsonKey(
      name: 'activated_at',
      fromJson: LemonMarketsTimeConverter.fromIsoTimeNullable,
      toJson: LemonMarketsTimeConverter.toIsoTimeNullable)
  DateTime? activatedAt;

  @JsonKey(
      name: 'executed_at',
      fromJson: LemonMarketsTimeConverter.fromIsoTimeNullable,
      toJson: LemonMarketsTimeConverter.toIsoTimeNullable)
  DateTime? executedAt;

  @JsonKey(
      name: 'rejected_at',
      fromJson: LemonMarketsTimeConverter.fromIsoTimeNullable,
      toJson: LemonMarketsTimeConverter.toIsoTimeNullable)
  DateTime? rejectedAt;

  @JsonKey(name: 'notes')
  String? notes;

  @JsonKey(name: 'regulatory_information')
  RegulatoryInformation? regulatoryInformation;

  Order(
      this.uuid,
      this.creationKey,
      this.isin,
      this.expiresAt,
      this.createdAt,
      this.side,
      this.quantity,
      this.stopPrice,
      this.limitPrice,
      this.estimatedPrice,
      this.tradingVenueMic,
      this.status,
      this.type,
      this.executedQuantity,
      this.executedPrice,
      this.executedAt,
      this.rejectedAt,
      this.notes,
      this.chargableAt,
      this.chargePrice
      );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Amount get sumPrice => executedPrice?.multiply(executedQuantity?.toDouble() ?? 0) ?? Amount.zero();

  @override
  String toString() {
    return 'Order{\n'
        'uuid: $uuid,\n'
        'idempotency: $idempotency,\n'
        'key_creation_id: $creationKey,\n'
        'key_activation_id: $activationKey,\n'
        'isin: $isin,\n'
        'title: $title,\n'
        'expiresAt: $expiresAt,\n'
        'createdAt: $createdAt,\n'
        'side: $side,\n'
        'quantity: $quantity,\n'
        'stopPrice: $stopPrice,\n'
        'limitPrice: $limitPrice,\n'
        'estimatedPrice: $estimatedPrice,\n'
        'estimatedPriceTotal: $estimatedPriceTotal,\n'
        'tradingVenueMic: $tradingVenueMic,\n'
        'status: $status,\n'
        'type: $type,\n'
        'executedQuantity: $executedQuantity,\n'
        'executedPrice: $executedPrice,\n'
        'executedPriceTotal: $executedPriceTotal,\n'
        'activatedAt: $activatedAt,\n'
        'executedAt: $executedAt,\n'
        'rejectedAt: $rejectedAt,\n'
        'charge: $chargePrice,\n'
        'chargableAtAt: $chargableAt,\n'
        'notes: $notes\n'
        'regulatoryInformation: $regulatoryInformation\n'
        '}';
  }


}
