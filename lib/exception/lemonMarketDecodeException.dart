class LemonMarketDecodeException implements Exception {
  String cause;
  String responseMap;

  LemonMarketDecodeException(this.cause, this.responseMap);
}