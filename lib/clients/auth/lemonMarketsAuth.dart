/*
class LemonMarketsAuth {
  final log = Logger('LemonMarketsAuth');
  LemonMarketsHttpClient _client;

  LemonMarketsAuth(this._client);

  Future<AccessToken> requestToken(String clientId, String clientSecret) async {
    LemonMarketsClientResponse response = await _client.sendPost(
        LemonMarketsURL.AUTH_URL,
        null,
        {
          'client_id': clientId,
          'client_secret': clientSecret,
          'grant_type': 'client_credentials',
        },
        false);
    if (response.statusCode == 200) {
      try {
        AccessToken result = AccessToken.fromJson(response.decodedBody);
        return result;
      } catch (e, stackTrace) {
        throw LemonMarketsConvertException(
            LemonMarketsURL.AUTH_URL, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
      }
    } else {
      throw LemonMarketsStatusCodeException(
          LemonMarketsURL.AUTH_URL, response.statusCode, response.decodedBody.toString(), null);
    }
  }
}
*/