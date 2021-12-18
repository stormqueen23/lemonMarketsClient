import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

part 'tradingResultList.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class TradingResultList<T> {
  @JsonKey(
      name: 'time', fromJson: LemonMarketsTimeConverter.fromIsoTimeNullable, toJson: LemonMarketsTimeConverter.toIsoTimeNullable)
  DateTime? time;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'results')
  List<T> result;

  @JsonKey(name: 'next')
  String? next;
  @JsonKey(name: 'previous')
  String? previous;
  @JsonKey(name: 'total')
  int? count;
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'pages')
  int? pages;

  TradingResultList(this.status, this.result, this.time);

  factory TradingResultList.fromJson(Map<String, dynamic> json) => _$TradingResultListFromJson(json, _dataFromJson);

  static T _dataFromJson<T>(Object? json) {
    if (json != null && json is Map<String, dynamic>) {
      //example from plugin:
      //https://github.com/google/json_serializable.dart/blob/master/example/lib/generic_response_class_example.dart
      if (T == Space) {
       return Space.fromJson(json) as T;
      } else if (T == PortfolioItem) {
        return PortfolioItem.fromJson(json) as T;
      } else if (T == Instrument) {
        return Instrument.fromJson(json) as T;
      } else if (T == ExistingOrder) {
        return ExistingOrder.fromJson(json) as T;
      } else if (T == Transaction) {
        return Transaction.fromJson(json) as T;
      } else if (T == BankStatement) {
        return BankStatement.fromJson(json) as T;
      }
    }
    throw ArgumentError.value(
      json,
      'json',
      'Unknown type $T: Add $T in tradingResultList.dart',
    );
  }
}