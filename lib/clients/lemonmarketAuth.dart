import 'package:flutter/material.dart';
import 'package:lemon_market_client/data/accessToken.dart';
import 'package:lemon_market_client/clients/lemonClient.dart';
import 'package:lemon_market_client/exception/lemonMarketDecodeException.dart';
import 'package:lemon_market_client/exception/lemonMarketJsonException.dart';
import 'package:lemon_market_client/helper/lemonmarketURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketAuth {
  final log = Logger('LemonMarketAuth');
  LemonClient _client;

  LemonMarketAuth(this._client);

  Future<AccessToken?> requestToken(String clientId, String clientSecret) async {
    Map<String, dynamic> decoded = {};
    try {
      decoded = await _client.sendPost(
          LemonMarketURL.AUTH_URL, null, {'client_id': clientId, 'client_secret': clientSecret, 'grant_type': 'client_credentials'});
      AccessToken result = AccessToken.fromJson(decoded);
      return result;
    } on LemonMarketDecodeException {
      rethrow;
    } catch (e) {
      throw LemonMarketJsonException(LemonMarketURL.AUTH_URL, "", e.toString(), decoded.toString());
    }
  }
}