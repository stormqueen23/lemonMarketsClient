import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/transactionOrderInstrument.dart';
import 'package:lemon_markets_client/helper/lemonMarketsResultConverter.dart';

part 'transactionOrder.g.dart';

@JsonSerializable()
class TransactionOrder {
  @JsonKey(name: 'uuid')
  String uuid;

  @JsonKey(name: 'processed_quantity')
  int processedQuantity;

  @JsonKey(name: 'average_price', fromJson: LemonMarketsResultConverter.toDouble)
  double averagePrice;

  @JsonKey(name: 'instrument')
  TransactionOrderInstrument instrument;

  TransactionOrder(this.uuid, this.processedQuantity, this.averagePrice, this.instrument);

  factory TransactionOrder.fromJson(Map<String, dynamic> json) => _$TransactionOrderFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionOrderToJson(this);
}