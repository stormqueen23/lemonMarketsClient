import 'package:lemon_markets_client/exception/lemonMarketsException.dart';

class LemonMarketsStatusCodeException extends LemonMarketsException {
  LemonMarketsStatusCodeException(String url, int statusCode, String responseMap, StackTrace? stacktrace) : super(url, "unexpected statusCode", statusCode, responseMap, stacktrace);
}