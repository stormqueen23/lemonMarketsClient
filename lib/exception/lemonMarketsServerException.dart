import 'package:lemon_markets_client/exception/lemonMarketsException.dart';

class LemonMarketsServerException extends LemonMarketsException {

  LemonMarketsServerException(String url, String cause, int? responseCode, String responseMap, StackTrace? stacktrace) : super(url, cause, responseCode, responseMap, stacktrace);

  String toString() => "LemonMarketsServerException ${super.rootCause}";
}