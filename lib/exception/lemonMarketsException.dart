///This exception is thrown if something went wrong during Authentication
class LemonMarketsException implements Exception {
  String url;
  int? responseCode;
  String rootCause;
  String responseMap;
  StackTrace? stacktrace;

  LemonMarketsException(this.url, this.rootCause, this.responseCode, this.responseMap, this.stacktrace);

  @override
  String toString() {
    return '${this.runtimeType}{url: $url, responseCode: $responseCode, responseMap: $responseMap, rootCause: $rootCause}';
  }
}