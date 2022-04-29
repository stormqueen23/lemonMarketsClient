import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/trading/positionPerformance.dart';
import 'package:lemon_markets_client/data/trading/positionStatement.dart';
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

  @JsonKey(
      name: 'mode',
      fromJson: LemonMarketsResultConverter.fromAccountMode,
      toJson: LemonMarketsResultConverter.toAccountMode)
  AccountMode mode;

  TradingResultList(this.status, this.result, this.time, this.mode);

  factory TradingResultList.fromJson(Map<String, dynamic> json) => _$TradingResultListFromJson(json, _dataFromJson);

  static T _dataFromJson<T>(Object? json) {
    if (json != null && json is Map<String, dynamic>) {
      //example from plugin:
      //https://github.com/google/json_serializable.dart/blob/master/example/lib/generic_response_class_example.dart
      if (T == Position) {
        return Position.fromJson(json) as T;
      } else if (T == Instrument) {
        return Instrument.fromJson(json) as T;
      } else if (T == Order) {
        return Order.fromJson(json) as T;
      } else if (T == BankStatement) {
        return BankStatement.fromJson(json) as T;
      } else if (T == Document) {
        return Document.fromJson(json) as T;
      } else if (T == PositionPerformance) {
        return PositionPerformance.fromJson(json) as T;
      } else if (T == PositionStatement) {
        return PositionStatement.fromJson(json) as T;
      }
    }
    throw ArgumentError.value(
      json,
      'json',
      'Unknown type $T: Add $T in tradingResultList.dart',
    );
  }

  @override
  String toString() {
    return 'TradingResultList{time: $time, status: $status, next: $next, previous: $previous, count: $count, page: $page, pages: $pages, mode: $mode, result: $result}';
  }
}