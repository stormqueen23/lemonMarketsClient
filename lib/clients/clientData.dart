import 'package:lemon_markets_client/lemon_markets_client.dart';

class DeleteOrderResult {
  bool success;
  int statusCode;
  AccountMode mode;
  Map<String, dynamic> responseMap;

  DeleteOrderResult(this.success, this.statusCode, this.mode, this.responseMap);

  @override
  String toString() {
    return 'DeleteOrderResult{success: $success, statusCode: $statusCode, mode: $mode, responseMap: $responseMap}';
  }
}

class ActivateOrderResult {
  bool success;
  int statusCode;
  AccountMode mode;
  Map<String, dynamic> responseMap;

  ActivateOrderResult(this.success, this.statusCode, this.mode, this.responseMap);

  @override
  String toString() {
    return 'ActivateOrderResult{success: $success, statusCode: $statusCode, mode: $mode, responseMap: $responseMap}';
  }
}

class DeleteSpaceResult {
  bool success;
  int statusCode;
  AccountMode mode;
  Map<String, dynamic> responseMap;
  TradingResult resultObject;

  DeleteSpaceResult(this.success, this.statusCode, this.mode, this.responseMap, this.resultObject);

  @override
  String toString() {
    return 'DeleteSpaceResult{success: $success, statusCode: $statusCode, mode: $mode, responseMap: $responseMap}';
  }
}
