import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/transaction.dart';

part 'transactionList.g.dart';

@JsonSerializable()
class TransactionList {
  @JsonKey(name: 'next')
  String? next;
  @JsonKey(name: 'previous')
  String? previous;
  @JsonKey(name: 'results')
  List<Transaction> result;

  TransactionList(this.next, this.previous, this.result,);

  factory TransactionList.fromJson(Map<String, dynamic> json) => _$TransactionListFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionListToJson(this);
}