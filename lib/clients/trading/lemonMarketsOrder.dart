import 'package:lemon_markets_client/clients/clientData.dart';
import 'package:lemon_markets_client/data/amount.dart';
import 'package:lemon_markets_client/data/auth/accessToken.dart';
import 'package:lemon_markets_client/data/trading/createdOrder.dart';
import 'package:lemon_markets_client/data/trading/existingOrder.dart';
import 'package:lemon_markets_client/data/tradingResult.dart';
import 'package:lemon_markets_client/data/tradingResultList.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/helper/lemonMarketsQueryConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsResultConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsOrder {
  final log = Logger('LemonMarketsOrder');
  LemonMarketsHttpClient _client;

  LemonMarketsOrder(this._client);

  Future<TradingResult<CreatedOrder>> placeOrder(
      AccessToken token, String isin, DateTime expiresAt, OrderSide side, int quantity, String venue,
      {Amount? stopPrice, Amount? limitPrice, String? notes}) async {
    String url = LemonMarketsURL.getTradingUrl(token) + '/orders/';
    Map<String, dynamic> data = {};
    data['isin'] = isin;
    data['side'] = LemonMarketsQueryConverter.convertSideForExecution(side) ?? '';
    data['expires_at'] = LemonMarketsTimeConverter.toIsoTime(expiresAt);
    data['quantity'] = quantity;
    data['venue'] = venue;
    if (limitPrice != null) {
      data['limit_price'] = limitPrice.apiValue;
    }
    if (stopPrice != null) {
      data['stop_price'] = stopPrice.apiValue;
    }
    if (notes != null && notes.isNotEmpty) {
      data['notes'] = notes;
    }
    log.fine('place order data: $data');
    LemonMarketsClientResponse response = await _client.sendPost(url, token, data, true);
    try {
      TradingResult<CreatedOrder> result = TradingResult<CreatedOrder>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(
          url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<ActivateOrderResult> activateOrder(AccessToken token, String orderUuid, String? pin) async {
    String url = LemonMarketsURL.getTradingUrl(token) + '/orders/' + orderUuid + '/activate/';
    Map<String, String>? body;
    if (pin != null) {
      body = {};
      body['pin'] = pin;
    }
    LemonMarketsClientResponse response = await _client.sendPost(url, token, body, true);
    try {
      String status = response.decodedBody['status'];
      String modeString = response.decodedBody['mode'];
      AccountMode mode = LemonMarketsResultConverter.fromAccountMode(modeString);
      log.fine('status for orderActivation: $status in mode $modeString');
      return ActivateOrderResult(
          'ok'.compareTo(status) == 0 && response.statusCode == 200, response.statusCode, mode, response.decodedBody);
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(
          url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<DeleteOrderResult> deleteOrder(AccessToken token, String orderUuid) async {
    String url = LemonMarketsURL.getTradingUrl(token) + '/orders/' + orderUuid;
    LemonMarketsClientResponse response = await _client.sendDelete(url, token);
    try {
      String status = response.decodedBody['status'];
      String modeString = response.decodedBody['mode'];
      AccountMode mode = LemonMarketsResultConverter.fromAccountMode(modeString);
      log.fine('response from delete order: ${response.decodedBody} - $status, mode: $modeString');
      TradingResult<ExistingOrder> result = TradingResult<ExistingOrder>.fromJson(response.decodedBody);
      if (result.status == 'ok') {
        return DeleteOrderResult(true, response.statusCode, mode, response.decodedBody);
      } else {
        return DeleteOrderResult(false, response.statusCode, mode, response.decodedBody);
      }
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(
          url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<TradingResult<ExistingOrder>> getOrder(AccessToken token, String orderUuid) async {
    String url = LemonMarketsURL.getTradingUrl(token)  + '/orders/' + orderUuid;
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingResult<ExistingOrder> result = TradingResult<ExistingOrder>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(
          url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<TradingResultList<ExistingOrder>> getOrders(AccessToken token, {DateTime? createdAtUntil,
      DateTime? createdAtFrom, OrderSide? side, OrderType? type, OrderStatus? status, String? isin, int? limit, int? page}) async {
    List<String> params = _getOrderQueryParams(
        side: side,
        status: status,
        createdAtFrom: createdAtFrom,
        createdAtUntil: createdAtUntil,
        isin: isin,
        type: type,
        limit: limit,
        page: page);
    String queryParams = LemonMarketsHttpClient.generateQueryParams(params);
    String url = LemonMarketsURL.getTradingUrl(token) + '/orders/' + queryParams;
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
      String? isin,
      int? limit,
      int? page}) {
    List<String> result = [];
    if (createdAtUntil != null) {
      String toTime = LemonMarketsTimeConverter.getOrderQueryTimeFormat(createdAtUntil);
      result.add('to=' + toTime);
    }
    if (createdAtFrom != null) {
      String fromTime = LemonMarketsTimeConverter.getOrderQueryTimeFormat(createdAtFrom);
      result.add('from=' + fromTime);
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
    if (limit != null) {
      result.add('limit=' + limit.toString());
    }
    if (page != null) {
      result.add('page=' + page.toString());
    }
    return result;
  }
}
