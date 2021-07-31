import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/existingOrder.dart';
import 'package:lemon_markets_client/data/ohlc.dart';
import 'package:lemon_markets_client/data/openingDay.dart';
import 'package:lemon_markets_client/data/portfolioItem.dart';
import 'package:lemon_markets_client/data/portfolioTransaction.dart';
import 'package:lemon_markets_client/data/space.dart';
import 'package:lemon_markets_client/data/tradingVenue.dart';
import 'package:lemon_markets_client/data/transaction.dart';
import 'package:lemon_markets_client/data/warrant.dart';

import 'instrument.dart';

part 'resultList.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class ResultList<T> {
  @JsonKey(name: 'next')
  String? next;
  @JsonKey(name: 'previous')
  String? previous;
  @JsonKey(name: 'results')
  List<T> result;

  ResultList(this.next, this.previous, this.result);

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
      } else if (T == OHLC) {
        return OHLC.fromJson(json) as T;
      } else if (T == OpeningDay) {
        return OpeningDay.fromJson(json) as T;
      } else if (T == PortfolioTransaction) {
        return PortfolioTransaction.fromJson(json) as T;
      } else if (T == TradingVenue) {
        return TradingVenue.fromJson(json) as T;
      } else if (T == Transaction) {
        return Transaction.fromJson(json) as T;
      } else if (T == Warrant) {
        return Warrant.fromJson(json) as T;
      }
    }
    throw ArgumentError.value(
      json,
      'json',
      'Unknown type $T: Add $T in resultList.dart',
    );
  }
}