import 'package:lemon_markets_client/data/accessToken.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/data/tradingVenue.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsTradingVenue {
  final log = Logger('LemonMarketsTradingVenue');
  LemonMarketsHttpClient _client;

  LemonMarketsTradingVenue(this._client);

  Future<ResultList<TradingVenue>> getTradingVenues(AccessToken token, {List<String>? mics}) async {
    String url = LemonMarketsURL.BASE_URL_MARKET+'/venues/';
    if (mics != null && mics.isNotEmpty) {
      String values = mics.join(',');
      url = url+'?mic='+values;
    }
    return getTradingVenuesByUrl(token, url);
  }

  Future<ResultList<TradingVenue>> getTradingVenuesByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ResultList<TradingVenue> result = ResultList<TradingVenue>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

}