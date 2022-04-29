import 'package:lemon_markets_client/data/auth/accessToken.dart';
import 'package:lemon_markets_client/data/trading/position.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/data/trading/positionPerformance.dart';
import 'package:lemon_markets_client/data/trading/positionStatement.dart';
import 'package:lemon_markets_client/data/tradingResultList.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsPortfolio {
  final log = Logger('LemonMarketsPortfolio');
  final String ENDPOINT_NAME = '/positions/';
  final String PERFORMANCE_ENDPOINT_NAME = '/positions/performance';
  final String STATEMENTS_ENDPOINT_NAME = '/positions/statements';

  LemonMarketsHttpClient _client;

  LemonMarketsPortfolio(this._client);

  Future<TradingResultList<PositionStatement>> getPositionStatements(AccessToken token, {int? limit, int? page}) async {
    String url = LemonMarketsURL.getTradingUrl(token) + STATEMENTS_ENDPOINT_NAME;
    String params = _generateParamString(limit: limit, page: page);
    url = url+params;
    return getPositionStatementsByUrl(token, url);
  }

  Future<TradingResultList<PositionStatement>> getPositionStatementsByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingResultList<PositionStatement> result = TradingResultList<PositionStatement>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<TradingResultList<PositionPerformance>> getPositionPerformance(AccessToken token, {String? isin, DateTime? from, DateTime? to, int? limit, int? page}) async {
    String url = LemonMarketsURL.getTradingUrl(token) + PERFORMANCE_ENDPOINT_NAME;
    String params = _generateParamString(isin: isin, from: from, to: to, limit: limit, page: page);
    url = url+params;
    return getPositionPerformanceByUrl(token, url);
  }

  Future<TradingResultList<PositionPerformance>> getPositionPerformanceByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingResultList<PositionPerformance> result = TradingResultList<PositionPerformance>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<TradingResultList<Position>> getPositions(AccessToken token, {String? isin, int? limit, int? page}) async {
    String url = LemonMarketsURL.getTradingUrl(token) + ENDPOINT_NAME;
    String params = _generateParamString(isin: isin, limit: limit, page: page);
    url = url+params;
    return getPositionsByUrl(token, url);
  }

  Future<TradingResultList<Position>> getPositionsByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingResultList<Position> result = TradingResultList<Position>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  String _generateParamString({String? isin, DateTime? from, DateTime? to, int? limit, int? page}) {
    List<String> query = [];
    if (isin != null) {
      query.add("isin="+isin);
    }
    if (from != null) {
      int value = LemonMarketsTimeConverter.getDoubleTimeForDateTime(from);
      query.add('from=' + value.toString());
    }
    if (to != null) {
      int value = LemonMarketsTimeConverter.getDoubleTimeForDateTime(to);
      query.add('to=' + value.toString());
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