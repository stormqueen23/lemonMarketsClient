import 'dart:convert';

import 'package:http/http.dart';
import 'package:lemon_market_client/data/accessToken.dart';
import 'package:lemon_market_client/exception/lemonMarketDecodeException.dart';
import 'package:logging/logging.dart';

class LemonClient {
  final log = Logger('LemonClient');

  Client _client = Client();

  Future<Map<String, dynamic>> sendPost(String url, AccessToken? token, Map<String, dynamic>? body) async {
    log.fine("send post to url: $url");
    Map<String, String>? header = token != null ? _getHeader(token) : null;
    Response response =  await _client.post(Uri.parse(url), headers: header, body: body);
    String message = response.body;
    log.fine("response: $message");
    try {
      Map<String, dynamic> decoded = json.decode(message);
      return decoded;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketDecodeException(e.toString(), message);
    }
  }

  Future<Map<String, dynamic>> sendGet(String url, AccessToken token) async {
    log.fine("send get to url: $url");
    Response response =  await _client.get(Uri.parse(url), headers: _getHeader(token),);
    String message = response.body;
    log.fine("response: $message");
    try {
      Map<String, dynamic> decoded = json.decode(message);
      return decoded;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketDecodeException(e.toString(), message);
    }
  }

  Future<Map<String, dynamic>> sendPut(String url, AccessToken token) async {
    log.fine("send put to url: $url");
    Response response =  await _client.put(Uri.parse(url), headers: _getHeader(token),);
    String message = response.body;
    log.fine("response: $message");
    try {
      Map<String, dynamic> decoded = json.decode(message);
      return decoded;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketDecodeException(e.toString(), message);
    }
  }

  Future<Map<String, dynamic>> sendDelete(String url, AccessToken token) async {
    log.fine("send delete to url: $url");
    Response response =  await _client.delete(Uri.parse(url), headers: _getHeader(token),);
    String message = response.body;
    log.fine("response: $message");
    try {
      if (message.isNotEmpty) {
        Map<String, dynamic> decoded = json.decode(message);
        return decoded;
      }
      return {};
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketDecodeException(e.toString(), message);
    }
  }


  Map<String, String> _getHeader(AccessToken _token) {
    String prefix = '';
    if (_token.type == 'bearer') {
      prefix = 'Bearer';
    } else {
      prefix = _token.type;
      log.warning('unknown token type ' + _token.type);
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