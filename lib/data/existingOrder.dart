import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/orderInstrument.dart';
import 'package:lemon_markets_client/helper/lemonMarketsResultConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';

part 'existingOrder.g.dart';

enum ExistingOrderSide {buy, sell, unknown}

@JsonSerializable()
class ExistingOrder {

  @JsonKey(name: 'valid_until', fromJson: LemonMarketsTimeConverter.getUTXUnixDateTimeForLemonMarket, toJson: LemonMarketsTimeConverter.getUTCUnixTimestamp)
  DateTime validUntil;

  @JsonKey(name: 'side', fromJson: LemonMarketsResultConverter.fromExistingOrderType, toJson: LemonMarketsResultConverter.toExistingOrderType)
  ExistingOrderSide side;

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

  @JsonKey(name: 'average_price', fromJson: LemonMarketsResultConverter.toDoubleNullable)
  double? averagePrice;

  @JsonKey(name: 'created_at', fromJson: LemonMarketsTimeConverter.getUTXUnixDateTimeForLemonMarket, toJson: LemonMarketsTimeConverter.getUTCUnixTimestamp)
  DateTime createdAt;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'processed_at', fromJson: LemonMarketsTimeConverter.getUTXUnixDateTimeForLemonMarketNullable, toJson: LemonMarketsTimeConverter.getUTCUnixTimestampNullable)
  DateTime? processedAt;

  @JsonKey(name: 'processed_quantity')
  int? processedQuantity;

  @JsonKey(name: 'trading_venue_mic')
  String? tradingVenueMic;

  @JsonKey(name: 'instrument')
  OrderInstrument instrument;

  ExistingOrder(this.validUntil, this.side, this.quantity, this.stopPrice, this.limitPrice, this.uuid, this.status, this.averagePrice, this.createdAt,
      this.type, this.processedAt, this.processedQuantity, this.instrument);

  /*
"instrument": {
        "title": "string",
        "isin": "string"
      },
      "valid_until": "string",
      "side": "string",
      "quantity": int,
      "stop_price": "string",
      "limit_price": "string",
      "uuid": "string",
      "status": "string",
      "average_price": "string",
      "created_at": "string",
      "type": "string",
      "processed_at": "string",
      "processed_quantity": int
 */


  factory ExistingOrder.fromJson(Map<String, dynamic> json) => _$ExistingOrderFromJson(json);

  Map<String, dynamic> toJson() => _$ExistingOrderToJson(this);
}