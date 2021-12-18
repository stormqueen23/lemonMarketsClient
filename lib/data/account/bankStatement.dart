import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/amount.dart';
import 'package:lemon_markets_client/helper/lemonMarketsAmountConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsResultConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';

part 'bankStatement.g.dart';

@JsonSerializable()
class BankStatement {

  @JsonKey(name: 'id')
  String uuid;

  @JsonKey(name: 'account_id')
  String accountId;

  @JsonKey(
      name: 'type',
      fromJson: LemonMarketsResultConverter.fromBankStatement,
      toJson: LemonMarketsResultConverter.toBankStatementType)
  BankStatementType type;

  @JsonKey(
      name: 'date', fromJson: LemonMarketsTimeConverter.fromIsoDay, toJson: LemonMarketsTimeConverter.toIsoDay)
  DateTime date;

  @JsonKey(
      name: 'amount',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount amount;

  @JsonKey(name: 'isin')
  String? isin;

  @JsonKey(name: 'isin_title')
  String? isinTitle;

  BankStatement(this.uuid, this.accountId, this.type, this.date, this.amount, this.isin, this.isinTitle);

  factory BankStatement.fromJson(Map<String, dynamic> json) => _$BankStatementFromJson(json);

  Map<String, dynamic> toJson() => _$BankStatementToJson(this);

  @override
  String toString() {
    return 'BankStatement{\n'
        'uuid: $uuid,\n'
        'accountId: $accountId,\n'
        'type: $type,\n'
        'date: $date,\n'
        'amount: $amount,\n'
        'isin: $isin,\n'
        'isinTitle: $isinTitle'
        '\n}';
  }
}
