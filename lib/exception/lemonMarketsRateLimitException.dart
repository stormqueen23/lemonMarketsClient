import 'package:lemon_markets_client/exception/lemonMarketsException.dart';

/// wrapper for statusCode 429
class LemonMarketsRateLimitException  extends LemonMarketsException {
  String url;
  String responseMap;

  final int? limit;
  final int? remaining;
  final int? reset;

  LemonMarketsRateLimitException(
      this.url, this.responseMap, {this.limit, this.remaining, this.reset}): super(url, responseMap, 429, responseMap, null);

  @override
  String toString() => "${this.runtimeType} ${responseMap} [limit=$limit, remaining=$remaining, reset=$reset]";

  @override
  // TODO: implement stackTrace
  StackTrace? get stackTrace => null;
}