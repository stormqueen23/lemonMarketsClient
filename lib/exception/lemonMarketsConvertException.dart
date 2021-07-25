import 'package:lemon_markets_client/exception/lemonMarketsException.dart';

///This exception is thrown if something went wrong within converting the response body to the corresponding json object (fromJson)
class LemonMarketsConvertException extends LemonMarketsException {

  LemonMarketsConvertException(String url, String cause, int statusCode, String responseMap) : super(url, cause, statusCode, responseMap);
}