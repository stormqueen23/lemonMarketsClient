///This exception is thrown if something went wrong during Authentication
class LemonMarketsException implements Exception {
  String url;
  int responseCode;
  String rootCause;
  String responseMap;

  LemonMarketsException(this.url, this.rootCause, this.responseCode, this.responseMap);

  @override
  String toString() {
    return 'LemonMarketsException{url: $url, responseCode: $responseCode, responseMap: $responseMap}';
  }
}