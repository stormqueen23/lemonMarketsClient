import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

import 'market/historicalUrlResult.dart';

part 'resultList.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class ResultList<T> {
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
      name: 'time', fromJson: LemonMarketsTimeConverter.fromIsoTimeNullable, toJson: LemonMarketsTimeConverter.toIsoTimeNullable)
  DateTime? time;

  ResultList(this.next, this.previous, this.result, this.count);

  factory ResultList.fromJson(Map<String, dynamic> json) => _$ResultListFromJson(json, _dataFromJson);

  static T _dataFromJson<T>(Object? json) {
    if (json != null && json is Map<String, dynamic>) {
      //example from plugin:
      //https://github.com/google/json_serializable.dart/blob/master/example/lib/generic_response_class_example.dart
      if (T == Instrument) {
        return Instrument.fromJson(json) as T;
      } else if (T == Quote) {
        return Quote.fromJson(json) as T;
      }else if (T == OHLC) {
        return OHLC.fromJson(json) as T;
      } else if (T == TradingVenue) {
        return TradingVenue.fromJson(json) as T;
      } else if (T == Trade) {
        return Trade.fromJson(json) as T;
      } else if (T == HistoricalUrlResult) {
        return HistoricalUrlResult.fromJson(json) as T;
      }
    }
    throw ArgumentError.value(
      json,
      'json',
      'Unknown type $T: Add $T in resultList.dart',
    );
  }

  @override
  String toString() {
    return 'ResultList{time: $time, count: $count, page: $page, pages: $pages, next: $next, previous: $previous, result: $result, }';
  }
}