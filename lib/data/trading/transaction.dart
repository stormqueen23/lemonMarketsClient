import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/amount.dart';
import 'package:lemon_markets_client/helper/lemonMarketsAmountConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsResultConverter.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  @JsonKey(name: 'id')
  String uuid;

  @JsonKey(name: 'account_id')
  String accountId;

  @JsonKey(name: 'space_id')
  String? spaceId;

  @JsonKey(name: 'order_id')
  String? orderId;

  @JsonKey(
      name: 'type',
      fromJson: LemonMarketsResultConverter.fromTransactionType,
      toJson: LemonMarketsResultConverter.toTransactionType)
  TransactionType type;

  @JsonKey(name: 'amount',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount amount;

  @JsonKey(name: 'isin')
  String? isin;

  @JsonKey(name: 'isin_title')
  String? title;

  @JsonKey(name: 'created_at', fromJson: LemonMarketsTimeConverter.fromIsoTime, toJson: LemonMarketsTimeConverter.toIsoTime)
  DateTime createdAt;

  Transaction(this.uuid, this.accountId, this.spaceId, this.orderId, this.type, this.amount, this.isin, this.createdAt);

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @override
  String toString() {
    return 'Transaction{\n'
        'uuid: $uuid,\n'
        'accountId: $accountId,\n'
        'spaceId: $spaceId,\n'
        'orderId: $orderId,\n'
        'type: $type,\n'
        'amount: $amount,\n'
        'isin: $isin,\n'
        'title: $title}';
  }
}
