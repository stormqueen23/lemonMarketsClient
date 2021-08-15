import 'package:lemon_markets_client/clients/clientData.dart';
import 'package:lemon_markets_client/data/accessToken.dart';
import 'package:lemon_markets_client/data/createdOrder.dart';
import 'package:lemon_markets_client/data/existingOrder.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/helper/lemonMarketsConverter.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsOrder {
  final log = Logger('LemonMarketsOrder');
  LemonMarketsHttpClient _client;

  LemonMarketsOrder(this._client);

  Future<CreatedOrder> placeOrder(
      AccessToken token, String spaceUuid, String isin, double validUntil, String side,
      int quantity, {double? stopPrice, double? limitPrice}) async {
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
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<ActivateOrderResponse> activateOrder(AccessToken token, String spaceUuid, String orderUuid) async {
    String url = LemonMarketsURL.BASE_URL + '/spaces/' + spaceUuid + '/orders/' + orderUuid + '/activate/';
    LemonMarketsClientResponse response = await _client.sendPut(url, token);
    try {
      String status = response.decodedBody['status'];
      log.fine('status for orderActivation: $status');
      return ActivateOrderResponse('activated'.compareTo(status) == 0 && response.statusCode == 200, response.statusCode, response.decodedBody);
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<DeleteOrderResponse> deleteOrder(AccessToken token, String spaceUuid, String orderUuid) async {
    String url = LemonMarketsURL.BASE_URL + '/spaces/' + spaceUuid + '/orders/' + orderUuid + '';
    LemonMarketsClientResponse response =  await _client.sendDelete(url, token);
    try {
      log.fine('response from delete order: ${response.decodedBody}');
      if (response.decodedBody.isEmpty && response.statusCode == 204) {
        return DeleteOrderResponse(true, response.statusCode, response.decodedBody);
      } else {
        return DeleteOrderResponse(false, response.statusCode, response.decodedBody);
      }
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<ExistingOrder> getOrder(AccessToken token, String spaceUuid, String orderUuid) async {
    String url = LemonMarketsURL.BASE_URL + '/spaces/' + spaceUuid + '/orders/'+orderUuid;
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ExistingOrder result =  ExistingOrder.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<ResultList<ExistingOrder>> getOrders(AccessToken token, String spaceUuid,
      int? createdAtUntil, int? createdAtFrom, OrderSide? side, OrderType? type,
      OrderStatus? status, int? limit, int? offset) async {
    List<String> params = _getOrderQueryParams(createdAtUntil, createdAtFrom, side, type, status, limit, offset);
    String queryParams = LemonMarketsHttpClient.generateQueryParams(params);
    String url = LemonMarketsURL.BASE_URL + '/spaces/' + spaceUuid + '/orders/'+queryParams;
    return getOrdersByUrl(token, url);
  }

  Future<ResultList<ExistingOrder>> getOrdersByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ResultList<ExistingOrder> result =  ResultList<ExistingOrder>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
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

}
