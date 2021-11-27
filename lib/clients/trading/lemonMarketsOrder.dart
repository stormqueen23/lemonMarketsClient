import 'package:lemon_markets_client/clients/clientData.dart';
import 'package:lemon_markets_client/data/auth/accessToken.dart';
import 'package:lemon_markets_client/data/trading/createdOrder.dart';
import 'package:lemon_markets_client/data/trading/existingOrder.dart';
import 'package:lemon_markets_client/data/tradingResult.dart';
import 'package:lemon_markets_client/data/tradingResultList.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/exception/lemonMarketsNoResultException.dart';
import 'package:lemon_markets_client/helper/lemonMarketsQueryConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsOrder {
  final log = Logger('LemonMarketsOrder');
  LemonMarketsHttpClient _client;

  LemonMarketsOrder(this._client);

  Future<CreatedOrder> placeOrder(
      AccessToken token, String spaceUuid, String isin, DateTime expiresAt, OrderSide side, int quantity, String venue,
      {double? stopPrice, double? limitPrice, String? notes}) async {
    String url = LemonMarketsURL.BASE_URL_TRADING_DEV + '/orders/';
    Map<String, dynamic> data = {};
    data['isin'] = isin;
    data['side'] = LemonMarketsQueryConverter.convertSideForExecution(side) ?? '';
    data['expires_at'] = LemonMarketsTimeConverter.toIsoTime(expiresAt);
    data['quantity'] = quantity;
    data['venue'] = venue;
    data['space_id'] = spaceUuid;
    if (limitPrice != null) {
      data['limit_price'] = limitPrice;
    }
    if (stopPrice != null) {
      data['stop_price'] = stopPrice;
    }
    if (notes != null && notes.isNotEmpty) {
      data['notes'] = notes;
    }
    log.fine('place order data: $data');
    LemonMarketsClientResponse response = await _client.sendPost(url, token, data, true);
    try {
      TradingResult<CreatedOrder> result = TradingResult<CreatedOrder>.fromJson(response.decodedBody);
      if (result.result != null) {
        return result.result!;
      } else {
        throw LemonMarketsNoResultException(
            url, 'status: ' + result.status, response.statusCode, response.decodedBody.toString());
      }
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(
          url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<ActivateOrderResponse> activateOrder(AccessToken token, String orderUuid, Map<String, String>? body) async {
    String url = LemonMarketsURL.BASE_URL_TRADING_DEV + '/orders/' + orderUuid + '/activate/';
    LemonMarketsClientResponse response = await _client.sendPost(url, token, body, true);
    try {
      String status = response.decodedBody['status'];
      log.fine('status for orderActivation: $status');
      return ActivateOrderResponse(
          'ok'.compareTo(status) == 0 && response.statusCode == 200, response.statusCode, response.decodedBody);
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(
          url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<DeleteOrderResponse> deleteOrder(AccessToken token, String orderUuid) async {
    String url = LemonMarketsURL.BASE_URL_TRADING_DEV + '/orders/' + orderUuid;
    LemonMarketsClientResponse response = await _client.sendDelete(url, token);
    try {
      String status = response.decodedBody['status'];
      log.fine('response from delete order: ${response.decodedBody} - $status');
      TradingResult<ExistingOrder> result = TradingResult<ExistingOrder>.fromJson(response.decodedBody);
      if (result.status == 'ok') {
        return DeleteOrderResponse(true, response.statusCode, response.decodedBody);
      } else {
        return DeleteOrderResponse(false, response.statusCode, response.decodedBody);
      }
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(
          url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<ExistingOrder> getOrder(AccessToken token, String orderUuid) async {
    String url = LemonMarketsURL.BASE_URL_TRADING_DEV  + '/orders/' + orderUuid;
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingResult<ExistingOrder> result = TradingResult<ExistingOrder>.fromJson(response.decodedBody);
      if(result.result != null) {
        return result.result!;
      } else {
        throw LemonMarketsNoResultException(url, 'status: '+result.status, response.statusCode, response.decodedBody.toString());
      }

    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(
          url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<TradingResultList<ExistingOrder>> getOrders(AccessToken token, {String? spaceUuid, DateTime? createdAtUntil,
      DateTime? createdAtFrom, OrderSide? side, OrderType? type, OrderStatus? status, String? isin}) async {
    List<String> params = _getOrderQueryParams(
        side: side,
        status: status,
        createdAtFrom: createdAtFrom,
        createdAtUntil: createdAtUntil,
        isin: isin,
        spaceUuid: spaceUuid,
        type: type);
    String queryParams = LemonMarketsHttpClient.generateQueryParams(params);
    String url = LemonMarketsURL.BASE_URL_TRADING_DEV + '/orders/' + queryParams;
    return getOrdersByUrl(token, url);
  }

  Future<TradingResultList<ExistingOrder>> getOrdersByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingResultList<ExistingOrder> result = TradingResultList<ExistingOrder>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(
          url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  List<String> _getOrderQueryParams(
      {DateTime? createdAtUntil,
      DateTime? createdAtFrom,
      OrderSide? side,
      OrderType? type,
      OrderStatus? status,
      String? spaceUuid,
      String? isin}) {
    List<String> result = [];
    if (spaceUuid != null) {
      result.add('space_id=' + spaceUuid);
    }
    if (createdAtUntil != null) {
      result.add('to=' + LemonMarketsTimeConverter.toIsoTime(createdAtUntil));
    }
    if (createdAtFrom != null) {
      result.add('from=' + LemonMarketsTimeConverter.toIsoTime(createdAtFrom));
    }
    if (isin != null) {
      result.add('isin=' + isin);
    }
    if (side != null) {
      String? sideString = LemonMarketsQueryConverter.convertSideForSearch(side);
      if (sideString != null) result.add('side=' + sideString);
    }
    if (status != null) {
      String? statusString = LemonMarketsQueryConverter.convertOrderStatus(status);
      if (statusString != null) result.add('status=' + statusString);
    }
    if (type != null) {
      String? typeString = LemonMarketsQueryConverter.convertOrderType(type);
      if (typeString != null) result.add('type=' + typeString);
    }
    return result;
  }
}
