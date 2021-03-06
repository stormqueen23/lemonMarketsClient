import 'package:lemon_markets_client/exception/lemonMarketsException.dart';

///This exception is thrown if something went wrong during Authentication
class LemonMarketsAuthException extends LemonMarketsException {

  LemonMarketsAuthException(String url, String cause, int? responseCode, String responseMap, StackTrace? stacktrace) : super(url, cause, responseCode, responseMap, stacktrace);

  String toString() => "LemonMarketsAuthException ${responseCode?.toString()}";
}