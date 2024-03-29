import 'package:intl/intl.dart';
import 'package:lemon_markets_client/data/auth/accessToken.dart';
import 'package:lemon_markets_client/data/market/quote.dart';
import 'package:lemon_markets_client/data/market/trade.dart';
import 'package:lemon_markets_client/data/market/ohlc.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/helper/lemonMarketsQueryConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';
import 'package:logging/logging.dart';

class LemonMarketsMarketData {
  final log = Logger('LemonMarketsMarketData');
  DateFormat df = DateFormat('yyyy-MM-dd');

  LemonMarketsHttpClient _client;

  LemonMarketsMarketData(this._client);

  // Market Data -> Trade

  Future<ResultList<Trade>> getTrades(AccessToken token, List<String> isin,
      {DateTime? from, DateTime? to, String? mic, bool? decimals, bool epoch = false, Sorting? sorting, int? limit, int? page}) async {
    String url = LemonMarketsURL.BASE_URL_MARKET + '/trades';

    List<String> query = [];
    if (isin.isNotEmpty) {
      query.add("isin=" + isin.join(','));
    }
    if (from != null) {
      String queryFrom = from.toUtc().toIso8601String();
      query.add("from=" + queryFrom);
    }
    if (to != null) {
      String queryTo = to.toUtc().toIso8601String();
      query.add("to=" + queryTo);
    }
    if (mic != null) {
      query.add("mic=" + mic);
    }
    if (decimals != null) {
      query.add("decimals=" + decimals.toString());
    }
    if (sorting != null) {
      query.add("sorting=" + LemonMarketsQueryConverter.convertSorting(sorting));
    }
    if (limit != null) {
      query.add("limit=" + limit.toString());
    }
    if (page != null) {
      query.add("page=" + page.toString());
    }
    query.add("epoch=${epoch.toString()}");

    String queryString = LemonMarketsHttpClient.generateQueryParams(query);
    url += queryString;

    return getTradesByUrl(token, url);
  }

  Future<ResultList<Trade>> getLatestTrade(AccessToken token, List<String> isin,
      {List<String>? mics, bool? decimals, bool epoch = false, Sorting? sorting, int? limit, int? page}) async {
    String url = LemonMarketsURL.BASE_URL_MARKET + '/trades/latest';

    List<String> query = [];
    if (mics != null && mics.isNotEmpty) {
      query.add("mic=" + mics.join(','));
    }
    if (isin.isNotEmpty) {
      query.add("isin=" + isin.join(','));
    }
    if (decimals != null) {
      query.add("decimals=" + decimals.toString());
    }
    if (sorting != null) {
      query.add("sorting=" + LemonMarketsQueryConverter.convertSorting(sorting));
    }
    if (limit != null) {
      query.add("limit=" + limit.toString());
    }
    if (page != null) {
      query.add("page=" + page.toString());
    }
    query.add("epoch=${epoch.toString()}");

    String queryString = LemonMarketsHttpClient.generateQueryParams(query);
    url += queryString;

    return getTradesByUrl(token, url);
  }

  Future<ResultList<Trade>> getTradesByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ResultList<Trade> result = ResultList<Trade>.fromJson(response.decodedBody);
      result.rateLimitInfo = response.getRateLimitInfo();
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  // Market Data -> Quote
  Future<ResultList<Quote>> getQuotes(AccessToken token, List<String> isin,
      {DateTime? from, DateTime? to, String? mic, bool? decimals, bool epoch = false, Sorting? sorting, int? limit, int? page}) async {
    String url = LemonMarketsURL.BASE_URL_MARKET + '/quotes';

    List<String> query = [];
    if (isin.isNotEmpty) {
      query.add("isin=" + isin.join(','));
    }
    if (from != null) {
      String queryFrom = from.toUtc().toIso8601String();
      query.add("from=" + queryFrom);
    }
    if (to != null) {
      String queryTo = to.toUtc().toIso8601String();
      query.add("to=" + queryTo);
    }
    if (mic != null) {
      query.add("mic=" + mic);
    }
    if (decimals != null) {
      query.add("decimals=" + decimals.toString());
    }
    if (sorting != null) {
      query.add("sorting=" + LemonMarketsQueryConverter.convertSorting(sorting));
    }
    if (limit != null) {
      query.add("limit=" + limit.toString());
    }
    if (page != null) {
      query.add("page=" + page.toString());
    }
    query.add("epoch=${epoch.toString()}");

    String queryString = LemonMarketsHttpClient.generateQueryParams(query);
    url += queryString;

    return getQuotesByUrl(token, url);
  }

  Future<ResultList<Quote>> getLatestQuote(AccessToken token, List<String> isin,
      {List<String>? mic, bool? decimals, bool epoch = false, Sorting? sorting, int? limit, int? page}) async {
    String url = LemonMarketsURL.BASE_URL_MARKET + '/quotes/latest';

    List<String> query = [];
    if (mic != null && mic.isNotEmpty) {
      query.add("mic=" + mic.join(','));
    }
    if (isin.isNotEmpty) {
      query.add("isin=" + isin.join(','));
    }
    if (limit != null) {
      query.add("limit=" + limit.toString());
    }
    if (page != null) {
      query.add("page=" + page.toString());
    }
    if (decimals != null) {
      query.add("decimals=" + decimals.toString());
    }
    if (sorting != null) {
      query.add("sorting=" + LemonMarketsQueryConverter.convertSorting(sorting));
    }
    query.add("epoch=${epoch.toString()}");

    String queryString = LemonMarketsHttpClient.generateQueryParams(query);
    url += queryString;

    return getQuotesByUrl(token, url);
  }

  Future<ResultList<Quote>> getQuotesByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ResultList<Quote> result = ResultList<Quote>.fromJson(response.decodedBody);
      result.rateLimitInfo = response.getRateLimitInfo();
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  // Market Data -> OHLC

  Future<ResultList<OHLC>> getOHLC(AccessToken token, List<String> isin, OHLCType type,
      {List<String>? mics, bool? decimals,  Sorting? sorting,
        DateTime? from, DateTime? to, bool? latest, int? limit, int? page}) async {

    List<String> result = [];
    if (isin.isNotEmpty) {
      result.add("isin="+isin.join(','));
    }
    if (limit != null) {
      result.add("limit="+limit.toString());
    }
    if (page != null) {
      result.add("page="+page.toString());
    }
    if (mics != null && mics.isNotEmpty) {
      result.add("mic="+mics.join(','));
    }
    if (latest != null && latest) {
      result.add('latest='+latest.toString());
    } else {
      if (from != null) {
        int value = LemonMarketsTimeConverter.getDoubleTimeForDateTime(from);
        result.add('from=' + value.toString());
      }
      if (to != null) {
        int value = LemonMarketsTimeConverter.getDoubleTimeForDateTime(to);
        result.add('to=' + value.toString());
      }
    }
    if (decimals != null) {
      result.add('decimals='+decimals.toString());
    }
    if (sorting != null) {
      result.add('sorting='+LemonMarketsQueryConverter.convertSorting(sorting)); // oldest -> newest
    }
    result.add('epoch=true');

    String query = LemonMarketsHttpClient.generateQueryParams(result);

    String typeAsString = LemonMarketsQueryConverter.convertOHLCType(type) ?? 'h1';
    String url = LemonMarketsURL.BASE_URL_MARKET + '/ohlc/'+typeAsString+'/'+query;

    return getOHLCByUrl(token, url);
  }

  Future<ResultList<OHLC>> getOHLCByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ResultList<OHLC> result = ResultList<OHLC>.fromJson(response.decodedBody);
      result.rateLimitInfo = response.getRateLimitInfo();
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

}

