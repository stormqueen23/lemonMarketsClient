import 'package:lemon_market_client/exception/lemonMarketsException.dart';

class LemonMarketsStatusCodeException extends LemonMarketsException {
  LemonMarketsStatusCodeException(String url, int statusCode, String responseMap) : super(url, "unexpected statusCode", statusCode, responseMap);
}