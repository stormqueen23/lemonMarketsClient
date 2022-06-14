import 'package:lemon_markets_client/data/auth/accessToken.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/data/market/tradingVenue.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsTradingVenue {
  final log = Logger('LemonMarketsTradingVenue');
  LemonMarketsHttpClient _client;

  LemonMarketsTradingVenue(this._client);

  Future<ResultList<TradingVenue>> getTradingVenues(AccessToken token, {List<String>? mics, int? limit, int? page}) async {
    String url = LemonMarketsURL.BASE_URL_MARKET+'/venues/';
    String appendSearch = _generateParamString(mic: mics, limit: limit, page: page);
    url += appendSearch;
    return getTradingVenuesByUrl(token, url);
  }

  Future<ResultList<TradingVenue>> getTradingVenuesByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ResultList<TradingVenue> result = ResultList<TradingVenue>.fromJson(response.decodedBody);
      result.rateLimitInfo = response.getRateLimitInfo();
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  String _generateParamString({List<String>? mic, int? limit, int? page}) {
    List<String> query = [];
    if (mic != null && mic.isNotEmpty) {
      query.add("mic="+mic.join(','));
    }
    if (limit != null) {
      query.add("limit="+limit.toString());
    }
    if (page != null) {
      query.add("page="+page.toString());
    }
    String result = LemonMarketsHttpClient.generateQueryParams(query);
    return result;
  }
}