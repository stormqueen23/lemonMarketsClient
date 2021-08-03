import 'package:lemon_markets_client/data/accessToken.dart';
import 'package:lemon_markets_client/data/instrument.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/data/warrant.dart';
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

  Future<ResultList<Warrant>> searchTradingVenueInstrumentWarrants(AccessToken token, String mic, String isin,
      {String? search, bool? tradable, String? currency, String? limit, int? offset}) async {
    String url = LemonMarketsURL.BASE_URL + '/trading-venues/' + mic + '/instruments/' + isin + '/warrants/';
    String appendSearch = _generateInstrumentParamString(offset: offset, limit: limit, currency: currency, search: search, tradable: tradable);
    url = url += appendSearch;
    return searchTradingVenueInstrumentWarrantsByUrl(token, url);
  }

  Future<ResultList<Warrant>> searchTradingVenueInstrumentWarrantsByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ResultList<Warrant> result = ResultList<Warrant>.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }

  Future<Instrument> searchTradingVenueInstrument(AccessToken token, String mic, String isin) async {
    String url = LemonMarketsURL.BASE_URL + '/trading-venues/' + mic + '/instruments/' + isin + '/';
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      Instrument result = Instrument.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }

  Future<ResultList<Instrument>> searchTradingVenueInstruments(AccessToken token, String mic,
      {String? search, SearchType? type, bool? tradable, String? currency, String? limit, int? offset}) async {
    String url = LemonMarketsURL.BASE_URL + '/trading-venues/' + mic + '/instruments/';
    String appendSearch = _generateInstrumentParamString(offset: offset, limit: limit, type: type, currency: currency, search: search, tradable: tradable);
    url = url += appendSearch;
    return searchTradingVenueInstrumentsByUrl(token, url);
  }

  Future<ResultList<Instrument>> searchTradingVenueInstrumentsByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ResultList<Instrument> result = ResultList<Instrument>.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }

  Future<ResultList<Instrument>> searchInstruments(AccessToken token,
      {String? search, SearchType? type, bool? tradable, String? currency, String? limit, int? offset}) async {
    String url = LemonMarketsURL.BASE_URL + '/instruments/';
    String appendSearch = _generateInstrumentParamString(offset: offset, limit: limit, type: type, currency: currency, search: search, tradable: tradable);
    url = url += appendSearch;
    return searchInstrumentsByUrl(token, url);
  }

  Future<ResultList<Instrument>> searchInstrumentsByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ResultList<Instrument> result = ResultList<Instrument>.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }


  String _convertType(SearchType type) {
    String result = LemonMarketsConverter.convertSearchType(type);
    return result;
  }

  String _generateInstrumentParamString({String? search, SearchType? type, bool? tradable, String? currency, String? limit, int? offset}) {
    List<String> query = [];
    if (search != null && search.trim().isNotEmpty) {
      query.add("search="+search.trim());
    }
    if (type != null && type != SearchType.none) {
      String appendType = _convertType(type);
      query.add("type="+appendType);
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
