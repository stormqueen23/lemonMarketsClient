import 'package:lemon_market_client/data/accessToken.dart';
import 'package:lemon_market_client/data/createdOrder.dart';
import 'package:lemon_market_client/data/existingOrder.dart';
import 'package:lemon_market_client/data/instrument.dart';
import 'package:lemon_market_client/exception/lemonMarketDecodeException.dart';
import 'package:lemon_market_client/exception/lemonMarketJsonException.dart';
import 'package:lemon_market_client/clients/lemonClient.dart';
import 'package:lemon_market_client/helper/lemonMarketConverter.dart';
import 'package:lemon_market_client/src/lemonmarket.dart';
import 'package:lemon_market_client/helper/lemonmarketURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketTrading {
  final log = Logger('LemonMarketTrading');
  LemonClient _client;

  LemonMarketTrading(this._client);

  String _convertType(SearchType type) {
    String result = "";
    result = "type="+LemonMarketConverter.convertSearchType(type);
    return result;
  }

  Future<List<Instrument>> searchInstruments(AccessToken token, String? query, SearchType type) async {
    List<Instrument> result = [];
    String URL = LemonMarketURL.BASE_URL + '/instruments/';
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

    try {
      Map<String, dynamic> decoded = await _client.sendGet(url, token);
      List<dynamic> all = decoded['results'];
      all.forEach((element) {
        Instrument i = Instrument.fromJson(element);
        result.add(i);
      });
    } catch (e) {
      log.warning(e.toString());
    }
    return result;
  }

  Future<CreatedOrder?> placeOrder(
      AccessToken token, String spaceUuid, String isin, double validUntil, String side, int quantity, double? stopPrice, double? limitPrice) async {
    String url = LemonMarketURL.BASE_URL + '/spaces/' + spaceUuid + '/orders/';
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
    Map<String, dynamic> decoded = {};
    try {
      decoded = await _client.sendPost(url, token, data);
      return CreatedOrder.fromJson(decoded);
    } on LemonMarketDecodeException {
      rethrow;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketJsonException(url, "", e.toString(), decoded.toString());
    }
  }

  Future<bool> activateOrder(AccessToken token, String spaceUuid, String orderUuid) async {
    String url = LemonMarketURL.BASE_URL + '/spaces/' + spaceUuid + '/orders/' + orderUuid + '/activate/';
    try {
      Map<String, dynamic> decoded = await _client.sendPut(url, token);
      String status = decoded['status'];
      log.fine('status for orderActivation: $status');
      return 'activated'.compareTo(status) == 0 ? true : false;
    } on LemonMarketDecodeException {
      rethrow;
    } catch (e) {
      log.warning(e.toString());
    }
    return false;
  }

  Future<bool> deleteOrder(AccessToken token, String spaceUuid, String orderUuid) async {
    String url = LemonMarketURL.BASE_URL + '/spaces/' + spaceUuid + '/orders/' + orderUuid + '';
    try {
      Map<String, dynamic> decoded = await _client.sendDelete(url, token);
      log.fine('response from delete order: $decoded');
      if (decoded.isEmpty) {
        return true;
      } else {
        return false;
      }
    } on LemonMarketDecodeException {
      rethrow;
    } catch (e) {
      log.warning(e.toString());
      //throw LemonMarketJsonException(decoded.toString(), decoded.toString());
    }
    return false;
  }

 Future<List<ExistingOrder>> getOrders(AccessToken token, String spaceUuid,
      int? createdAtUntil, int? createdAtFrom, OrderSide? side, OrderType? type,
      OrderStatus? status, int? limit, int? offset) async {
    List<ExistingOrder> result = [];
    List<String> params = _getOrderQueryParams(createdAtUntil, createdAtFrom, side, type, status, limit, offset);
    String queryParams = LemonClient.generateQueryParams(params);
    String url = LemonMarketURL.BASE_URL + '/spaces/' + spaceUuid + '/orders/'+queryParams;
    try {
      Map<String, dynamic> decoded = await _client.sendGet(url, token);
      List<dynamic> all = decoded['results'];
      all.forEach((element) {
        ExistingOrder i = ExistingOrder.fromJson(element);
        result.add(i);
      });
    } catch (e) {
      log.warning(e.toString());
    }

    return result;
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
      String? sideString = LemonMarketConverter.convertSide(side);
      if (sideString != null)
      result.add('side='+sideString);
    }
    if (type != null) {
      String? typeString = LemonMarketConverter.convertOrderType(type);
      if (typeString != null)
        result.add('type='+typeString);
    }
    if (status != null) {
      String? statusString = LemonMarketConverter.convertOrderStatus(status);
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
}
