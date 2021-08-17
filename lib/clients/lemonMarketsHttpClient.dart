import 'dart:convert';

import 'package:http/http.dart';
import 'package:lemon_markets_client/data/accessToken.dart';
import 'package:lemon_markets_client/exception/lemonMarketsAuthException.dart';
import 'package:lemon_markets_client/exception/lemonMarketsDecodeException.dart';
import 'package:lemon_markets_client/exception/lemonMarketsInvalidQueryException.dart';
import 'package:logging/logging.dart';

class LemonMarketsClientResponse {
  int statusCode;
  Map<String, dynamic> decodedBody;

  LemonMarketsClientResponse(this.statusCode, this.decodedBody);
}

class LemonMarketsHttpClient {
  final log = Logger('LemonMarketsHttpClient');

  Client _client = Client();

  Future<LemonMarketsClientResponse> sendPost(String url, AccessToken? token, Map<String, dynamic>? bodyMap) async {
    log.fine("send post to url: $url");
    Map<String, String>? header = token != null ? _getHeader(token, url) : null;
    Response response =  await _client.post(Uri.parse(url), headers: header, body: bodyMap);
    return _decode(response, url);
  }

  Future<LemonMarketsClientResponse> sendGet(String url, AccessToken token) async {
    log.fine("send get to url: $url");
    Response response =  await _client.get(Uri.parse(url), headers: _getHeader(token, url),);
    return _decode(response, url);
  }

  Future<LemonMarketsClientResponse> sendPut(String url, AccessToken token) async {
    log.fine("send put to url: $url");
    Response response =  await _client.put(Uri.parse(url), headers: _getHeader(token, url),);
    return _decode(response, url);
  }

  Future<LemonMarketsClientResponse> sendDelete(String url, AccessToken token) async {
    log.fine("send delete to url: $url");
    Response response =  await _client.delete(Uri.parse(url), headers: _getHeader(token, url),);
    return _decode(response, url);
  }

  LemonMarketsClientResponse _decode(Response response, String url) {
    int statusCode = response.statusCode;
    log.fine("response: ${response.body} with statusCode $statusCode");
    if (statusCode == 401) {
      log.info("401 statusCode");
      throw LemonMarketsAuthException(url, "401 Error", statusCode, response.body, null);
    }
    try {
      Map<String, dynamic> decoded = response.body.isNotEmpty ? json.decode(response.body) : {};
      if (statusCode == 400) {
        log.info("400 statusCode");
        throw LemonMarketsInvalidQueryException(url, decoded['message'] ?? '', statusCode, response.body, null);
      }
      return LemonMarketsClientResponse(statusCode, decoded);
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsDecodeException(url, e.toString(), statusCode, response.body, stackTrace);
    }
  }

  Map<String, String> _getHeader(AccessToken _token, String url) {
    String prefix = '';
    if (_token.type == 'bearer') {
      prefix = 'Bearer';
    } else {
      throw LemonMarketsAuthException(url, "Unknown token type ${_token.type}", null, "", null);
    }
    return {'Authorization': prefix + ' ' + _token.token};
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