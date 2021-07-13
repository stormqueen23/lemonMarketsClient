class LemonMarketJsonException implements Exception {
  String url;
  String responseCode;
  String cause;
  String responseMap;

  LemonMarketJsonException(this.url, this.responseCode, this.cause, this.responseMap);
}