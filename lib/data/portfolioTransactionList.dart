import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/portfolioTransaction.dart';

part 'portfolioTransactionList.g.dart';

@JsonSerializable()
class PortfolioTransactionList {
  @JsonKey(name: 'next')
  String? next;
  @JsonKey(name: 'previous')
  String? previous;
  @JsonKey(name: 'results')
  List<PortfolioTransaction> result;

  PortfolioTransactionList(this.next, this.previous, this.result,);

  factory PortfolioTransactionList.fromJson(Map<String, dynamic> json) => _$PortfolioTransactionListFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioTransactionListToJson(this);
}