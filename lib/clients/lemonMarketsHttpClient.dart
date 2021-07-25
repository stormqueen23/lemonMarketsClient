import 'dart:convert';

import 'package:http/http.dart';
import 'package:lemon_market_client/data/accessToken.dart';
import 'package:lemon_market_client/exception/lemonMarketsAuthException.dart';
import 'package:lemon_market_client/exception/lemonMarketsDecodeException.dart';
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
    Map<String, String>? header = token != null ? _getHeader(token) : null;
    Response response =  await _client.post(Uri.parse(url), headers: header, body: bodyMap);
    int statusCode = response.statusCode;
    String message = response.body;
    log.fine("response: $message with statusCode $statusCode");
    try {
      Map<String, dynamic> decoded = json.decode(message);
      return LemonMarketsClientResponse(statusCode, decoded);
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsDecodeException(url, e.toString(), statusCode, message);
    }
  }

  Future<LemonMarketsClientResponse> sendGet(String url, AccessToken token) async {
    log.fine("send get to url: $url");
    Response response =  await _client.get(Uri.parse(url), headers: _getHeader(token),);
    int statusCode = response.statusCode;
    String message = response.body;
    log.fine("response: $message with statusCode $statusCode");
    try {
      Map<String, dynamic> decoded = json.decode(message);
      return LemonMarketsClientResponse(statusCode, decoded);
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsDecodeException(url, e.toString(), statusCode, message);
    }
  }

  Future<LemonMarketsClientResponse> sendPut(String url, AccessToken token) async {
    log.fine("send put to url: $url");
    Response response =  await _client.put(Uri.parse(url), headers: _getHeader(token),);
    int statusCode = response.statusCode;
    String message = response.body;
    log.fine("response: $message with statusCode $statusCode");
    try {
      Map<String, dynamic> decoded = json.decode(message);
      return LemonMarketsClientResponse(statusCode, decoded);
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsDecodeException(url, e.toString(), statusCode, message);
    }
  }

  Future<LemonMarketsClientResponse> sendDelete(String url, AccessToken token) async {
    log.fine("send delete to url: $url");
    Response response =  await _client.delete(Uri.parse(url), headers: _getHeader(token),);
    String message = response.body;
    int statusCode = response.statusCode;
    log.fine("response: $message with statusCode $statusCode");
    try {
        Map<String, dynamic> decoded = json.decode(message);
        return LemonMarketsClientResponse(statusCode, decoded);
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsDecodeException(url, e.toString(), statusCode, message);
    }
  }


  Map<String, String> _getHeader(AccessToken _token) {
    String prefix = '';
    if (_token.type == 'bearer') {
      prefix = 'Bearer';
    } else {
      throw LemonMarketsAuthException(_token.type, "Unknown token type");
    }
    return {'Authorization': prefix + ' ' + _token.access_token};
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