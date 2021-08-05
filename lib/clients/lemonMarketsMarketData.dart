import 'package:lemon_markets_client/data/accessToken.dart';
import 'package:lemon_markets_client/data/latestQuote.dart';
import 'package:lemon_markets_client/data/latestTrade.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsMarketData {
  final log = Logger('LemonMarketsMarketData');
  LemonMarketsHttpClient _client;

  LemonMarketsMarketData(this._client);

  Future<LatestTrade> getLatestTrade(AccessToken token, String isin, String mic) async {
    String url = LemonMarketsURL.BASE_URL+'/trading-venues/'+mic+'/instruments/'+isin+'/data/trades/latest/';
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
     LatestTrade result = LatestTrade.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<LatestQuote> getLatestQuote(AccessToken token, String isin, String mic) async {
    String url = LemonMarketsURL.BASE_URL+'/trading-venues/'+mic+'/instruments/'+isin+'/data/quotes/latest/';
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      LatestQuote result = LatestQuote.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }
}