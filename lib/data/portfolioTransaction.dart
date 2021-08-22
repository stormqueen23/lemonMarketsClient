import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/transactionOrderInstrument.dart';
import 'package:lemon_markets_client/helper/lemonMarketsResultConverter.dart';

part 'portfolioTransaction.g.dart';

@JsonSerializable()
class PortfolioTransaction {
  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(name: 'order_id')
  String orderUuid;

  @JsonKey(name: 'uuid')
  String transactionUuid;

  @JsonKey(name: 'average_price', fromJson: LemonMarketsResultConverter.toDouble)
  double averagePrice;

  @JsonKey(name: 'side')
  String side;

  @JsonKey(name: 'instrument')
  TransactionOrderInstrument orderInstrument;

  PortfolioTransaction(this.quantity, this.orderUuid, this.transactionUuid, this.averagePrice, this.side, this.orderInstrument);

  factory PortfolioTransaction.fromJson(Map<String, dynamic> json) => _$PortfolioTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioTransactionToJson(this);
}