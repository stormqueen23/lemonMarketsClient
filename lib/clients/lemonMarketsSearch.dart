import 'package:lemon_markets_client/data/accessToken.dart';
import 'package:lemon_markets_client/data/instrument.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/helper/lemonMarketsConverter.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsSearch {
  final log = Logger('LemonMarketsSearch');
  LemonMarketsHttpClient _client;

  LemonMarketsSearch(this._client);

  Future<ResultList<Instrument>> searchInstruments(AccessToken token,
      {List<String>? mic, List<String>? isin, String? query, List<SearchType>? types, bool? tradable, String? currency, String? limit, int? offset}) async {
    String url = LemonMarketsURL.BASE_URL_MARKET + '/instruments/';
    String appendSearch = _generateInstrumentParamString(isin: isin, mic: mic, offset: offset, limit: limit, types: types, currency: currency, search: query, tradable: tradable);
    url = url += appendSearch;
    return searchInstrumentsByUrl(token, url);
  }

  Future<ResultList<Instrument>> searchInstrumentsByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ResultList<Instrument> result = ResultList<Instrument>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }


  String _convertType(SearchType type) {
    String result = LemonMarketsConverter.convertSearchType(type);
    return result;
  }

  String _generateInstrumentParamString({List<String>? mic, List<String>? isin, String? search, List<SearchType>? types, bool? tradable, String? currency, String? limit, int? offset}) {
    List<String> query = [];
    if (mic != null && mic.isNotEmpty) {
      query.add("mic="+mic.join(','));
    }
    if (isin != null && isin.isNotEmpty) {
      query.add("isin="+isin.join(','));
    }
    if (search != null && search.trim().isNotEmpty) {
      query.add("search="+search.trim());
    }
    if (types != null) {
      for (SearchType type in types) {
        String appendType = _convertType(type);
        query.add("type=" + appendType);
      }
    }
    if (tradable != null) {
      query.add("tradable="+tradable.toString());
    }
    if (currency != null) {
      query.add("currency="+currency);
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
