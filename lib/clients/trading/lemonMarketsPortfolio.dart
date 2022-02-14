import 'package:lemon_markets_client/data/auth/accessToken.dart';
import 'package:lemon_markets_client/data/trading/portfolioItem.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/data/tradingResultList.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsPortfolio {
  final log = Logger('LemonMarketsPortfolio');
  LemonMarketsHttpClient _client;

  LemonMarketsPortfolio(this._client);

  Future<TradingResultList<PortfolioItem>> getPortfolioItems(AccessToken token, {String? spaceUuid, String? isin, int? limit, int? page}) async {
    String url = LemonMarketsURL.getTradingUrl(token) + '/portfolio/';
    String params = _generateParamString(isin: isin, spaceUuid: spaceUuid, limit: limit, page: page);
    url = url+params;
    return getPortfolioItemsByUrl(token, url);
  }

  Future<TradingResultList<PortfolioItem>> getPortfolioItemsByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingResultList<PortfolioItem> result = TradingResultList<PortfolioItem>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  String _generateParamString({String? spaceUuid, String? isin, int? limit, int? page}) {
    List<String> query = [];
    if (spaceUuid != null) {
      query.add("space_id="+spaceUuid);
    }
    if (isin != null) {
      query.add("isin="+isin);
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