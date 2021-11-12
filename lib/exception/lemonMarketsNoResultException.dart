import 'package:lemon_markets_client/exception/lemonMarketsException.dart';

class LemonMarketsNoResultException extends LemonMarketsException {

  LemonMarketsNoResultException(String url, String cause, int? responseCode, String responseMap,) : super(url, cause, responseCode, responseMap, null);

  String toString() => "LemonMarketsNoResultException ${super.rootCause}";
}