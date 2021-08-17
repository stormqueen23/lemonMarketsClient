import 'package:lemon_markets_client/exception/lemonMarketsException.dart';

class LemonMarketsInvalidQueryException extends LemonMarketsException {

  LemonMarketsInvalidQueryException(String url, String cause, int? responseCode, String responseMap, StackTrace? stacktrace) : super(url, cause, responseCode, responseMap, stacktrace);

  String toString() => "LemonMarketsInvalidQueryException ${super.rootCause}";
}