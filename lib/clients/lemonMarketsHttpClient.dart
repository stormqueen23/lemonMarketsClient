import 'dart:convert';

import 'package:http/http.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:logging/logging.dart';


String limitRateLimitHeader = 'RateLimit-Limit';
String remainingRateLimitHeader = 'RateLimit-Remaining';
String rateLimitReset = 'RateLimit-Reset';

class LemonMarketsClientResponse {
  int? limitRateLimit;
  int? remainingRateLimit;
  int? rateLimitReset;

  int statusCode;
  Map<String, dynamic> decodedBody;

  LemonMarketsClientResponse(this.decodedBody, {required this.limitRateLimit,required this.remainingRateLimit,required this.rateLimitReset,required this.statusCode});

  RateLimitInfo? getRateLimitInfo() {
    if (remainingRateLimit != null || rateLimitReset != null || limitRateLimit != null) {
      return RateLimitInfo(
          remainingRateLimit: remainingRateLimit, rateLimitReset: rateLimitReset, limitRateLimit: limitRateLimit);
    }
    return null;
  }
}

class LemonMarketsHttpClient {
  final log = Logger('LemonMarketsHttpClient');
  bool countRequests = false;
  int requestCounterMarketData = 0;
  int requestCounterTrading = 0;
  int requestCounterPaperTrading = 0;

  bool logRequests = false;
  List<RequestLogEntry> requestLog = [];

  Client _client = Client();

  void _updateRequestCounter(String url) {
    if (countRequests) {
      if (url.startsWith(LemonMarketsURL.BASE_URL_MARKET)) {
        requestCounterMarketData++;
      } else if (url.startsWith(LemonMarketsURL.BASE_URL_TRADING)) {
        requestCounterTrading++;
      } else if (url.startsWith(LemonMarketsURL.BASE_URL_TRADING_PAPER)) {
        requestCounterPaperTrading++;
      }
    }
    if (logRequests) {
      requestLog.add(RequestLogEntry(DateTime.now(), url));
    }
  }

  Future<LemonMarketsClientResponse> sendPost(String url, AccessToken? token, Map<String, dynamic>? bodyMap, bool asJson) async {
    log.fine("send post to url: $url");
    Map<String, String>? header = token != null ? _getHeader(token, url, asJson) : null;
    log.fine("header: $header");
    Response response;
    if (asJson) {
      String jsonParams = json.encode(bodyMap);
      log.fine("post params as json: $jsonParams");
      response =  await _client.post(Uri.parse(url), headers: header, body: jsonParams,);
      _updateRequestCounter(url);
    } else {
      log.fine("post params: $bodyMap");
      response =  await _client.post(Uri.parse(url), headers: header, body: bodyMap,);
      _updateRequestCounter(url);
    }
    return _decode(response, url);
  }

  Future<LemonMarketsClientResponse> sendGet(String url, AccessToken token) async {
    log.fine("send get to url: $url");
    Map<String, String>? header =_getHeader(token, url, false);
    log.fine("header: $header");
    Response response =  await _client.get(Uri.parse(url), headers: header,);
    _updateRequestCounter(url);
    return _decode(response, url);
  }

  Future<String> sendGetWithoutHeader(String url) async {
    log.fine("send get to url: $url");
    Response response =  await _client.get(Uri.parse(url));
    _updateRequestCounter(url);
    String responseString = utf8.decode(response.bodyBytes);
    return responseString;
  }

  Future<LemonMarketsClientResponse> sendPut(String url, AccessToken token, {Map<String, dynamic>? bodyMap, bool asJson = true}) async {
    log.fine("send put to url: $url");
    Map<String, String>? header =_getHeader(token, url, asJson);
    log.fine("header: $header");
    Response response;
    if(bodyMap != null) {
      if (asJson) {
        String jsonParams = json.encode(bodyMap);
        log.fine("post params as json: $jsonParams");
        response = await _client.put(Uri.parse(url), headers: header, body: jsonParams,);
        _updateRequestCounter(url);
      } else {
        log.fine("post params: $bodyMap");
        response = await _client.put(Uri.parse(url), headers: header, body: bodyMap,);
        _updateRequestCounter(url);
      }
    } else {
      response = await _client.put(Uri.parse(url), headers: header,);
      _updateRequestCounter(url);
    }
    return _decode(response, url);
  }

  Future<LemonMarketsClientResponse> sendDelete(String url, AccessToken token) async {
    log.fine("send delete to url: $url");
    Map<String, String>? header =_getHeader(token, url, true);
    log.fine("header: $header");
    Response response =  await _client.delete(Uri.parse(url), headers: header,);
    _updateRequestCounter(url);
    return _decode(response, url);
  }

  LemonMarketsClientResponse _decode(Response response, String url) {
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    //log.fine("client: ${_client.runtimeType}");
    //log.fine("response headers: $headers");
    String? limit;
    String? remaining;
    String? reset;

    headers.forEach((key, value) {
      if (key.toUpperCase().compareTo(limitRateLimitHeader.toUpperCase()) == 0) {
        limit = value;
      } else if (key.toUpperCase().compareTo(remainingRateLimitHeader.toUpperCase()) == 0) {
        remaining = value;
      } else if (key.toUpperCase().compareTo(rateLimitReset.toUpperCase()) == 0) {
        reset = value;
      }
    });

    int? limitAsInt = limit != null ? int.parse(limit!) : null;
    int? remainingAsInt = remaining != null ? int.parse(remaining!) : null;
    int? resetAsInt = reset != null ? int.parse(reset!) : null;

    String responseString = utf8.decode(response.bodyBytes);
    log.fine("response: ${responseString} with statusCode $statusCode (length: ${response.contentLength}, body is not empty: ${response.body.isNotEmpty})");
    if (statusCode == 401 || statusCode == 403) {
      //401 = token expired
      //403 = token was deleted
      log.info("$statusCode statusCode");
      throw LemonMarketsAuthException(url, "$statusCode Error", statusCode, response.body, null);
    } else if (statusCode == 405) {
      log.info("405 statusCode");
      throw LemonMarketsException(url, response.body, statusCode, response.body, null);
    } else if (statusCode == 429) {
      log.info("429 statusCode: limit=$limitAsInt, remaining=$remainingAsInt, resetAsInt=$resetAsInt");
      throw LemonMarketsRateLimitException(url, response.body, limit: limitAsInt,  remaining: remainingAsInt, reset: resetAsInt);
    } else if (statusCode == 500) {
      log.info("500 statusCode");
      throw LemonMarketsServerException(url, response.body, statusCode, response.body, null);
    }

    try {
      Map<String, dynamic> decoded = responseString.isNotEmpty ? json.decode(responseString) : {};
      log.fine(decoded);
      return LemonMarketsClientResponse(decoded, statusCode: statusCode, limitRateLimit: limitAsInt, rateLimitReset: resetAsInt, remainingRateLimit: remainingAsInt);
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsDecodeException(url, e.toString(), statusCode, response.body, stackTrace);
    }
  }

  Map<String, String> _getHeader(AccessToken _token, String url, bool asJson) {
    String prefix = '';
    if (_token.type == 'bearer') {
      prefix = 'Bearer'; //Bearer TOKEN
    } else {
      throw LemonMarketsAuthException(url, "Unknown token type ${_token.type}", null, "", null);
    }
    Map<String, String> headers = {};
    headers['Authorization'] = prefix + ' ' + _token.token;
    if (asJson) {
      headers['Content-Type'] = 'application/json';
    }
    return headers;
  }

  static String generateQueryParams(List<String> params) {
    String queryParams = '';
    if (params.isNotEmpty) {
      queryParams+='?';
      params.forEach((element) {
        queryParams += element+'&';
      });
      queryParams = queryParams.substring(0, queryParams.length-1);
    }
    return queryParams;
  }
}