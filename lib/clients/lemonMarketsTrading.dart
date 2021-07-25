import 'package:lemon_market_client/data/accessToken.dart';
import 'package:lemon_market_client/data/createdOrder.dart';
import 'package:lemon_market_client/data/existingOrder.dart';
import 'package:lemon_market_client/data/instrument.dart';
import 'package:lemon_market_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_market_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_market_client/helper/lemonMarketsConverter.dart';
import 'package:lemon_market_client/src/lemonmarkets.dart';
import 'package:lemon_market_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsTrading {
  final log = Logger('LemonMarketsTrading');
  LemonMarketsHttpClient _client;

  LemonMarketsTrading(this._client);

  Future<List<Instrument>> searchInstruments(AccessToken token, String? query, SearchType type) async {
    String URL = LemonMarketsURL.BASE_URL + '/instruments/';
    String appendType = _convertType(type);
    String appendSearch = "";
    if (query != null && query.trim().isNotEmpty) {
      appendSearch = "search=" + query.trim();
    }
    String url = URL;
    if (appendType.isNotEmpty) {
      url = url + '?' + appendType;
      if (appendSearch.isNotEmpty) {
        url = url + '&' + appendSearch;
      }
    } else if (appendSearch.isNotEmpty) {
      url = url + '?' + appendSearch;
    }
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      //TODO: ListWrapper for results with next&previous -> see OHLCList
      List<Instrument> result = [];
      List<dynamic> all = response.decodedBody['results'];
      all.forEach((element) {
        Instrument i = Instrument.fromJson(element);
        result.add(i);
      });
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }

  }

  Future<CreatedOrder> placeOrder(
      AccessToken token, String spaceUuid, String isin, double validUntil, String side, int quantity, double? stopPrice, double? limitPrice) async {
    String url = LemonMarketsURL.BASE_URL + '/spaces/' + spaceUuid + '/orders/';
    Map<String, dynamic> data = {};
    data['isin'] = isin;
    data['side'] = side;
    data['valid_until'] = validUntil.toString();
    data['quantity'] = quantity.toString();
    if (limitPrice != null) {
      data['limit_price'] = limitPrice.toString();
    }
    if (stopPrice != null) {
      data['stop_price'] = stopPrice.toString();
    }
    log.fine('place order data: $data');

    LemonMarketsClientResponse response = await _client.sendPost(url, token, data);
    try {
      CreatedOrder result = CreatedOrder.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }

  Future<bool> activateOrder(AccessToken token, String spaceUuid, String orderUuid) async {
    String url = LemonMarketsURL.BASE_URL + '/spaces/' + spaceUuid + '/orders/' + orderUuid + '/activate/';
    LemonMarketsClientResponse response = await _client.sendPut(url, token);
    try {
      String status = response.decodedBody['status'];
      log.fine('status for orderActivation: $status');
      //TODO: better handling in case of no success
      return 'activated'.compareTo(status) == 0 && response.statusCode == 200 ? true : false;
    } catch (e) {
      log.warning(e.toString());
    }
    return false;
  }

  Future<bool> deleteOrder(AccessToken token, String spaceUuid, String orderUuid) async {
    String url = LemonMarketsURL.BASE_URL + '/spaces/' + spaceUuid + '/orders/' + orderUuid + '';
    LemonMarketsClientResponse response =  await _client.sendDelete(url, token);
    try {
      log.fine('response from delete order: ${response.decodedBody}');
      if (response.decodedBody.isEmpty && response.statusCode == 204) {
        return true;
      } else {
        //TODO: better handling in case of no success
        return false;
      }
    } catch (e) {
      log.warning(e.toString());
      //throw LemonMarketJsonException(decoded.toString(), decoded.toString());
    }
    return false;
  }

 Future<List<ExistingOrder>> getOrders(AccessToken token, String spaceUuid,
      int? createdAtUntil, int? createdAtFrom, OrderSide? side, OrderType? type,
      OrderStatus? status, int? limit, int? offset) async {
    List<String> params = _getOrderQueryParams(createdAtUntil, createdAtFrom, side, type, status, limit, offset);
    String queryParams = LemonMarketsHttpClient.generateQueryParams(params);
    String url = LemonMarketsURL.BASE_URL + '/spaces/' + spaceUuid + '/orders/'+queryParams;
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      //TODO: ListWrapper for results with next&previous -> see OHLCList
      List<ExistingOrder> result = [];
      List<dynamic> all = response.decodedBody['results'];
      all.forEach((element) {
        ExistingOrder i = ExistingOrder.fromJson(element);
        result.add(i);
      });
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
}

  List<String> _getOrderQueryParams(int? createdAtUntil, int? createdAtFrom, OrderSide? side, OrderType? type,
      OrderStatus? status, int? limit, int? offset) {
    List<String> result = [];
    if (createdAtUntil != null) {
      result.add('created_at_until='+createdAtUntil.toString());
    }
    if (createdAtFrom != null) {
      result.add('created_at_from='+createdAtFrom.toString());
    }
    if (side != null) {
      String? sideString = LemonMarketsConverter.convertSide(side);
      if (sideString != null)
      result.add('side='+sideString);
    }
    if (type != null) {
      String? typeString = LemonMarketsConverter.convertOrderType(type);
      if (typeString != null)
        result.add('type='+typeString);
    }
    if (status != null) {
      String? statusString = LemonMarketsConverter.convertOrderStatus(status);
      if (statusString != null)
        result.add('status='+statusString);
    }
    if (limit != null) {
      result.add('limit='+limit.toString());
    }
    if (offset != null) {
      result.add('offset='+offset.toString());
    }
    return result;
  }

  String _convertType(SearchType type) {
    String result = "";
    result = "type="+LemonMarketsConverter.convertSearchType(type);
    return result;
  }

}
