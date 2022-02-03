import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:logging/logging.dart';

class LemonMarketsSpaces {
  final log = Logger('LemonMarketsSpaces');
  LemonMarketsHttpClient _client;

  LemonMarketsSpaces(this._client);

  Future<TradingResult<Space>> createSpace(AccessToken token, String name, SpaceType type, Amount riskLimit, {String? description}) async {
    String url = LemonMarketsURL.getTradingUrl(token)+'/spaces/';
    Map<String, String> data = {};
    data['name'] = name;
    if (description != null && description.isNotEmpty) {
      data['description'] = description;
    }
    data['type'] = LemonMarketsResultConverter.toSpaceType(type) ?? '';
    data['risk_limit'] = riskLimit.apiValue.toString();

    LemonMarketsClientResponse response = await _client.sendPost(url, token, data, true);
    try {
      TradingResult<Space> result = TradingResult<Space>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }


  Future<TradingResultList<Space>> getSpaces(AccessToken token, {SpaceType? type}) async {
    List<String> queryParamList = [];
    if (type != null) {
      queryParamList.add('type='+(LemonMarketsResultConverter.toSpaceType(type) ?? ''));
    }
    String query = LemonMarketsHttpClient.generateQueryParams(queryParamList);
    String url = LemonMarketsURL.getTradingUrl(token)+'/spaces/'+query;
    return getSpacesByUrl(token, url);
  }

  Future<TradingResultList<Space>> getSpacesByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingResultList<Space> result = TradingResultList<Space>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<TradingResult<Space>> getSpace(AccessToken token, String uuid) async {
    String url = LemonMarketsURL.getTradingUrl(token)+'/spaces/'+uuid+'/';
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingResult<Space> result = TradingResult<Space>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<TradingResult<Space>> alterSpace(AccessToken token, String uuid, {String? name, Amount? riskLimit, String? description}) async {
    String url = LemonMarketsURL.getTradingUrl(token)+'/spaces/'+uuid+'/';
    Map<String, dynamic> data = {};
    if (name != null && name.isNotEmpty) {
      data['name'] = name;
    }
    if (description != null && description.isNotEmpty) {
      data['description'] = description;
    }
    if (riskLimit != null) {
      data['risk_limit'] = riskLimit.apiValue;
    }

    LemonMarketsClientResponse response = await _client.sendPut(url, token, bodyMap: data);
    try {
      TradingResult<Space> result = TradingResult<Space>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<DeleteSpaceResult> deleteSpace(AccessToken token, String uuid) async {
    String url = LemonMarketsURL.getTradingUrl(token)+'/spaces/'+uuid+'/';
    LemonMarketsClientResponse response = await _client.sendDelete(url, token);
    try {

        TradingResult<Space> result = TradingResult<Space>.fromJson(response.decodedBody);
        String status = response.decodedBody['status'];
        String modeString = response.decodedBody['mode'];
        AccountMode mode = LemonMarketsResultConverter.fromAccountMode(modeString);
        log.fine('response from delete order: ${response.decodedBody} - $status, mode: $modeString');
        if (result.status == 'ok') {
          return DeleteSpaceResult(true, response.statusCode, mode, response.decodedBody, result);
        } else {
          return DeleteSpaceResult(false, response.statusCode, mode, response.decodedBody, result);
        }

    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

}