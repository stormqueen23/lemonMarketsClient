import 'package:lemon_markets_client/data/auth/accessToken.dart';
import 'package:lemon_markets_client/data/trading/intern/portfolio.dart';
import 'package:lemon_markets_client/data/trading/portfolioItem.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsPortfolio {
  final log = Logger('LemonMarketsPortfolio');
  LemonMarketsHttpClient _client;

  LemonMarketsPortfolio(this._client);

  Future<List<PortfolioItem>> getPortfolioItems(AccessToken token, {String? spaceUuid, String? isin}) async {
    String url = LemonMarketsURL.getTradingUrl(token) + '/portfolio/';
    String params = _generateParamString(isin: isin, spaceUuid: spaceUuid);
    url = url+params;
    return getPortfolioItemsByUrl(token, url);
  }

  Future<List<PortfolioItem>> getPortfolioItemsByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      Portfolio result = Portfolio.fromJson(response.decodedBody);
      return result.getPortfolioItems();
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  String _generateParamString({String? spaceUuid, String? isin}) {
    List<String> query = [];
    if (spaceUuid != null) {
      query.add("space_id="+spaceUuid);
    }
    if (isin != null) {
      query.add("isin="+isin);
    }
    String result = LemonMarketsHttpClient.generateQueryParams(query);
    return result;
  }
}