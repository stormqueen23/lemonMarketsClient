import 'package:lemon_markets_client/data/accessToken.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/data/openingDay.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/data/tradingVenue.dart';
import 'package:lemon_markets_client/data/tradingVenueList.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsTradingVenue {
  final log = Logger('LemonMarketsTradingVenue');
  LemonMarketsHttpClient _client;

  LemonMarketsTradingVenue(this._client);

  Future<TradingVenueList> getTradingVenues(AccessToken token) async {
    String url = LemonMarketsURL.BASE_URL+'/trading-venues/';
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingVenueList result = TradingVenueList.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }

  Future<TradingVenue> getTradingVenue(AccessToken token, String mic) async {
    String url = LemonMarketsURL.BASE_URL + '/trading-venues/' + mic + '/';
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingVenue result = TradingVenue.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }

  Future<ResultList<OpeningDay>> getOpeningDays(AccessToken token, String mic) async {
    String url = LemonMarketsURL.BASE_URL + '/trading-venues/' + mic + '/opening-days';
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ResultList<OpeningDay> result = ResultList<OpeningDay>.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }
}