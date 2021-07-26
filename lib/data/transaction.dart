import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/ohlc.dart';
import 'package:lemon_markets_client/data/transactionOrder.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  @JsonKey(name: 'amount')
  String amount;

  @JsonKey(name: 'uuid')
  String uuid;

  @JsonKey(name: 'created_at')
  double createdAt;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'order')
  TransactionOrder? order;

  Transaction(this.amount, this.uuid, this.createdAt, this.type, this.order);

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}