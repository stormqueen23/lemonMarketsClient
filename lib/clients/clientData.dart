import 'package:lemon_markets_client/lemon_markets_client.dart';

class DeleteOrderResult {
  bool success;
  int statusCode;
  AccountMode mode;

  RateLimitInfo? rateLimitInfo;

  Map<String, dynamic> responseMap;

  DeleteOrderResult(this.success, this.statusCode, this.mode, this.responseMap);

  @override
  String toString() {
    return 'DeleteOrderResult{success: $success, statusCode: $statusCode, mode: $mode, responseMap: $responseMap, rateLimit: $rateLimitInfo}';
  }
}

class ActivateOrderResult {
  bool success;
  int statusCode;
  AccountMode mode;

  RateLimitInfo? rateLimitInfo;

  Map<String, dynamic> responseMap;

  ActivateOrderResult(this.success, this.statusCode, this.mode, this.responseMap);

  @override
  String toString() {
    return 'ActivateOrderResult{success: $success, statusCode: $statusCode, mode: $mode, responseMap: $responseMap, rateLimit: $rateLimitInfo}';
  }
}