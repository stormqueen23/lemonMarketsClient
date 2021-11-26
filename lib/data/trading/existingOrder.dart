import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/amount.dart';
import 'package:lemon_markets_client/helper/lemonMarketsAmountConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsResultConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';

part 'existingOrder.g.dart';

enum ExistingOrderSide { buy, sell, unknown }

@JsonSerializable()
class ExistingOrder {
  @JsonKey(name: 'id')
  String uuid;

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

  @JsonKey(name: 'venue')
  String tradingVenueMic;

  @JsonKey(
      name: 'status',
      fromJson: LemonMarketsResultConverter.fromOrderStatus,
      toJson: LemonMarketsResultConverter.toOrderStatus)
  OrderStatus status;

  @JsonKey(name: 'space_id')
  String spaceUuid;

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

  ExistingOrder(
      this.uuid,
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
      this.spaceUuid,
      this.type,
      this.executedQuantity,
      this.executedPrice,
      this.executedAt,
      this.rejectedAt,
      this.notes
      );

  factory ExistingOrder.fromJson(Map<String, dynamic> json) => _$ExistingOrderFromJson(json);

  Map<String, dynamic> toJson() => _$ExistingOrderToJson(this);

  Amount get sumPrice => executedPrice?.multiply(executedQuantity?.toDouble() ?? 0) ?? Amount.zero();

  @override
  String toString() {
    return 'ExistingOrder{\n'
        'uuid: $uuid,\n'
        'isin: $isin,\n'
        'title: $title,\n'
        'expiresAt: $expiresAt,\n'
        'createdAt: $createdAt,\n'
        'side: $side,\n'
        'quantity: $quantity,\n'
        'stopPrice: $stopPrice,\n'
        'limitPrice: $limitPrice,\n'
        'estimatedPrice: $estimatedPrice,\n'
        'tradingVenueMic: $tradingVenueMic,\n'
        'status: $status,\n'
        'spaceUuid: $spaceUuid,\n'
        'type: $type,\n'
        'executedQuantity: $executedQuantity,\n'
        'executedPrice: $executedPrice,\n'
        'activatedAt: $activatedAt,\n'
        'executedAt: $executedAt,\n'
        'rejectedAt: $rejectedAt,\n'
        'notes: $notes\n'
        '}';
  }


}
