import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/ohlc.dart';

part 'transactionOrderInstrument.g.dart';

@JsonSerializable()
class TransactionOrderInstrument {
  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'isin')
  String isin;

  TransactionOrderInstrument(this.title, this.isin);

  factory TransactionOrderInstrument.fromJson(Map<String, dynamic> json) => _$TransactionOrderInstrumentFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionOrderInstrumentToJson(this);
}