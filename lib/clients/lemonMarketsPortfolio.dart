import 'package:lemon_markets_client/data/accessToken.dart';
import 'package:lemon_markets_client/data/portfolioItem.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/data/portfolioTransaction.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsPortfolio {
  final log = Logger('LemonMarketsPortfolio');
  LemonMarketsHttpClient _client;

  LemonMarketsPortfolio(this._client);

  Future<ResultList<PortfolioItem>> getPortfolioItems(AccessToken token, String spaceUuid) async {
    String url = LemonMarketsURL.BASE_URL+'/spaces/'+spaceUuid+'/portfolio/';
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ResultList<PortfolioItem> result = ResultList<PortfolioItem>.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }

  Future<ResultList<PortfolioTransaction>> getPortfolioTransactions(AccessToken token, String spaceUuid,
      {int? createdAtUntil, int? createdAtFrom, int? limit, int? offset}) async {
    String url = LemonMarketsURL.BASE_URL+'/spaces/'+spaceUuid+'/portfolio/transactions/';
    String append = _generateParamString(createdAtUntil: createdAtUntil, createdAtFrom: createdAtFrom, limit: limit, offset: offset);
    url += append;
    return getPortfolioTransactionsFromUrl(token, url);
  }

  Future<ResultList<PortfolioTransaction>> getPortfolioTransactionsFromUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ResultList<PortfolioTransaction> result = ResultList<PortfolioTransaction>.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }

  String _generateParamString({int? createdAtUntil, int? createdAtFrom, int? limit, int? offset}) {
    List<String> query = [];
    if (createdAtUntil != null) {
      query.add("created_at_until="+createdAtUntil.toString());
    }
    if (createdAtFrom != null) {
      query.add("created_at_from="+createdAtFrom.toString());
    }
    if (limit != null) {
      query.add("limit="+limit.toString());
    }
    if (offset != null) {
      query.add("offset="+offset.toString());
    }
    String result = LemonMarketsHttpClient.generateQueryParams(query);
    return result;
  }
}