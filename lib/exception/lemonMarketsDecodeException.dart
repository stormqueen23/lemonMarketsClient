import 'package:lemon_markets_client/exception/lemonMarketsException.dart';

///This exception is thrown if something went wrong with decoding the body to json
class LemonMarketsDecodeException extends LemonMarketsException {
  LemonMarketsDecodeException(String url, String cause, int statusCode, String responseMap, StackTrace? stacktrace) : super(url, cause, statusCode, responseMap, stacktrace);
}
