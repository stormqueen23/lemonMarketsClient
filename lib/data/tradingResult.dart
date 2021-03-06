import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/account/account.dart';
import 'package:lemon_markets_client/data/rateLimitInfo.dart';
import 'package:lemon_markets_client/data/trading/createdOrder.dart';
import 'package:lemon_markets_client/data/trading/order.dart';
import 'package:lemon_markets_client/data/trading/position.dart';
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

  @JsonKey(name: 'rateLimitInfo')
  RateLimitInfo? rateLimitInfo;

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

  TradingResult(this.status, this.mode, this.rateLimitInfo);

  factory TradingResult.fromJson(Map<String, dynamic> json) => _$TradingResultFromJson(json, _dataFromJson);

  static T _dataFromJson<T>(Object? json) {
    if (json != null && json is Map<String, dynamic>) {
      //example from plugin:
      //https://github.com/google/json_serializable.dart/blob/master/example/lib/generic_response_class_example.dart
      if (T == Position) {
        return Position.fromJson(json) as T;
      } else if (T == Order) {
        return Order.fromJson(json) as T;
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

  @override
  String toString() {
    return 'TradingResult{time: $time, status: $status, errorCode: $errorCode, errorMessage: $errorMessage, mode: $mode, result: $result\n'
        'rate limits: limit: ${rateLimitInfo?.limitRateLimit}, remaining: ${rateLimitInfo?.remainingRateLimit}, reset: ${rateLimitInfo?.rateLimitReset}';
  }
}