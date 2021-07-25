///This exception is thrown if something went wrong during Authentication
class LemonMarketsAuthException implements Exception {
  String tokenType;
  String message;

  LemonMarketsAuthException(this.tokenType, this.message);
}