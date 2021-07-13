import 'package:lemon_market_client/data/accessToken.dart';
import 'package:lemon_market_client/data/latestQuote.dart';
import 'package:lemon_market_client/data/latestTrade.dart';
import 'package:lemon_market_client/exception/lemonMarketDecodeException.dart';
import 'package:lemon_market_client/exception/lemonMarketJsonException.dart';
import 'package:lemon_market_client/clients/lemonClient.dart';
import 'package:lemon_market_client/helper/lemonmarketURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketMarketData {
  final log = Logger('LemonMarketMarketData');
  LemonClient _client;

  LemonMarketMarketData(this._client);

  Future<LatestTrade?> getLatestTrade(AccessToken token, String isin, String mic) async {
    String url = LemonMarketURL.BASE_URL+'/trading-venues/'+mic+'/instruments/'+isin+'/data/trades/latest/';
    Map<String, dynamic> decoded = {};
    try {
      decoded = await _client.sendGet(url, token);
      LatestTrade result = LatestTrade.fromJson(decoded);
      return result;
    } on LemonMarketDecodeException {
      rethrow;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketJsonException(url, "", e.toString(), decoded.toString());
    }
    return null;
  }

  Future<LatestQuote?> getLatestQuote(AccessToken token, String isin, String mic) async {
    String url = LemonMarketURL.BASE_URL+'/trading-venues/'+mic+'/instruments/'+isin+'/data/quotes/latest/';
    Map<String, dynamic> decoded = {};
    try {
      decoded = await _client.sendGet(url, token);
      LatestQuote result = LatestQuote.fromJson(decoded);
      return result;
    } on LemonMarketDecodeException {
      rethrow;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketJsonException(url, "", e.toString(), decoded.toString());
    }
  }
}