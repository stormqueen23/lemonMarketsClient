import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/account/account.dart';
import 'package:lemon_markets_client/data/trading/createdOrder.dart';
import 'package:lemon_markets_client/data/trading/existingOrder.dart';
import 'package:lemon_markets_client/data/trading/portfolioItem.dart';
import 'package:lemon_markets_client/data/trading/space.dart';
import 'package:lemon_markets_client/helper/lemonMarketsResultConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';

part 'tradingResult.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class TradingResult<T> {
  @JsonKey(
      name: 'time', fromJson: LemonMarketsTimeConverter.fromIsoTimeNullable, toJson: LemonMarketsTimeConverter.toIsoTimeNullable)
  DateTime? time;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'error_code')
  String? errorCode;

  @JsonKey(name: 'error_message')
  String? errorMessage;

  @JsonKey(name: 'results')
  T? result;

  @JsonKey(
      name: 'mode',
      fromJson: LemonMarketsResultConverter.fromAccountMode,
      toJson: LemonMarketsResultConverter.toAccountMode)
  AccountMode mode;

  TradingResult(this.status, this.mode);

  factory TradingResult.fromJson(Map<String, dynamic> json) => _$TradingResultFromJson(json, _dataFromJson);

  static T _dataFromJson<T>(Object? json) {
    if (json != null && json is Map<String, dynamic>) {
      //example from plugin:
      //https://github.com/google/json_serializable.dart/blob/master/example/lib/generic_response_class_example.dart
      if (T == Space) {
       return Space.fromJson(json) as T;
      } else if (T == PortfolioItem) {
        return PortfolioItem.fromJson(json) as T;
      } else if (T == ExistingOrder) {
        return ExistingOrder.fromJson(json) as T;
      }  else if (T == Account) {
        return Account.fromJson(json) as T;
      } else if (T == CreatedOrder) {
        return CreatedOrder.fromJson(json) as T;
      }
    }
    throw ArgumentError.value(
      json,
      'json',
      'Unknown type $T: Add $T in tradingResult.dart',
    );
  }
}