import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/existingOrder.dart';
import 'package:lemon_markets_client/data/portfolioItem.dart';
import 'package:lemon_markets_client/data/space.dart';

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
      }


    }
    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data -> unknown type $T',
    );
  }
}