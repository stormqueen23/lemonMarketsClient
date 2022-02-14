import 'package:lemon_markets_client/exception/lemonMarketsException.dart';

/// wrapper for statusCode 405
class LemonMarketsStatusCodeException extends LemonMarketsException {
  LemonMarketsStatusCodeException(String url, int statusCode, String responseMap, StackTrace? stacktrace) : super(url, "unexpected statusCode", statusCode, responseMap, stacktrace);
}