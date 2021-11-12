import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/market/quote.dart';
import 'package:lemon_markets_client/data/market/ohlc.dart';
import 'package:lemon_markets_client/data/trading/portfolioItem.dart';
import 'package:lemon_markets_client/data/trading/space.dart';
import 'package:lemon_markets_client/data/market/trade.dart';
import 'package:lemon_markets_client/data/trading/existingOrder.dart';
import 'package:lemon_markets_client/data/market/tradingVenue.dart';
import 'package:lemon_markets_client/data/trading/transaction.dart';

import 'market/instrument.dart';

part 'resultList.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class ResultList<T> {
  @JsonKey(name: 'next')
  String? next;
  @JsonKey(name: 'previous')
  String? previous;
  @JsonKey(name: 'results')
  List<T> result;
  @JsonKey(name: 'count')
  int? count;

  ResultList(this.next, this.previous, this.result, this.count);

  factory ResultList.fromJson(Map<String, dynamic> json) => _$ResultListFromJson(json, _dataFromJson);

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
      }  else if (T == Quote) {
        return Quote.fromJson(json) as T;
      }else if (T == OHLC) {
        return OHLC.fromJson(json) as T;
      } else if (T == TradingVenue) {
        return TradingVenue.fromJson(json) as T;
      } else if (T == Trade) {
        return Trade.fromJson(json) as T;
      } else if (T == Transaction) {
        return Transaction.fromJson(json) as T;
      }
    }
    throw ArgumentError.value(
      json,
      'json',
      'Unknown type $T: Add $T in resultList.dart',
    );
  }
}