import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../credentials.dart';

String clientId = Credentials.clientId;
String clientSecret = Credentials.clientSecret;
String spaceUuid = Credentials.spaceUuid;
String transactionUuidPayIn = Credentials.transactionUuidPayIn;

final LemonMarkets lm = LemonMarkets();

void main() {
  setUp(() {
    //logging
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      print('${record.loggerName} [${record.level.name}]: ${record.time}: ${record.message}');
    });
  }
  );

  test('createOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder order = await lm.placeOrder(token, Credentials.default_space_uuid, 'DE000BASF111', OrderSide.buy, 1);
    print('order ${order.uuid} created. expires at ${order.validUntil} ${order.validUntil.toIso8601String()}');
    print(order);
  });

  test('deleteOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    DeleteOrderResponse response = await lm.deleteOrder(token, 'ord_pyPKVWWmmBZlFNKCcBTGssWlZnbJWt7V42');
    print('delete order: ${response.success} (${response.responseMap.toString()})');
  });

  test('createAndDeleteOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder order = await lm.placeOrder(token, Credentials.default_space_uuid, 'DE000BASF111', OrderSide.buy, 2);
    print('order ${order.uuid} created. Estimated price: ${order.estimatedPrice.displayValue}');
    print(order);

    DeleteOrderResponse response = await lm.deleteOrder(token, order.uuid);
    print('delete order: ${response.success} (${response.responseMap.toString()})');
  });

  test('createAndDeleteStopOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder order = await lm.placeOrder(token, Credentials.default_space_uuid, 'DE000BASF111', OrderSide.buy, 1, stopPrice: 1.5);
    print('order ${order.uuid} created. expires at ${order.validUntil} ${order.validUntil.toIso8601String()}, stopPrice: ${order.stopPrice?.displayValue} (${order.stopPrice?.apiValue})');
    await lm.deleteOrder(token, order.uuid);

    order = await lm.placeOrder(token, Credentials.default_space_uuid, 'DE000BASF111', OrderSide.buy, 1, stopPrice: 1);
    print('order ${order.uuid} created. expires at ${order.validUntil} ${order.validUntil.toIso8601String()}, stopPrice: ${order.stopPrice?.displayValue} (${order.stopPrice?.apiValue})');
    await lm.deleteOrder(token, order.uuid);
  });

  test('activateAllInactiveOrders', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<ExistingOrder> orders = await lm.getOrders(token);
    print('found ${orders.result.length} orders');
    for (ExistingOrder element in orders.result) {
      print('${element.side} ${element.isin}: ${element.status}, ${element.uuid} - ${element.estimatedPrice?.displayValue}');
      if (element.status == OrderStatus.inactive) {
        await lm.activateOrder(token, element.uuid, null).then((value) => print(value.success.toString()));
      }
    }
  });

  test('getAllOrders', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<ExistingOrder> orders = await lm.getOrders(token);
    print('found ${orders.result.length} orders');
    for (ExistingOrder element in orders.result) {
      print(element);
    }
  });

  test('getOneOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ExistingOrder order = await lm.getOrder(token, 'ord_pyPLYggttrFHJ2LFhC66Y5HXg2V0wYHDZV');
    print('found ${order.isin}');
    print(order);
  });

  test('activateOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    String orderToActivate = 'ord_pyPKWDDWWjrkXBhZfD81Zwn8C7T7xnRMdX';
    ActivateOrderResponse response = await lm.activateOrder(token, orderToActivate, null);
    print('activate order: ${response.success} (${response.responseMap.toString()})');

    ExistingOrder order = await lm.getOrder(token, orderToActivate);
    print('found ${order.isin}: status=${order.status}, estimated price=${order.estimatedPrice}');
    print(order);
  });

  test('createAndActivateBuyOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder order = await lm.placeOrder(token, Credentials.default_space_uuid, 'DE0006048408', OrderSide.buy, 2);
    print('BUY order ${order.uuid} created. Estimated price: ${order.estimatedPrice} (${order.side})');

    ActivateOrderResponse response = await lm.activateOrder(token, order.uuid, null);
    print('activate BUY order: ${response.success} (${response.responseMap.toString()})');

    ExistingOrder eorder = await lm.getOrder(token, order.uuid);
    print('found ${eorder.isin}');
    print(eorder);

  });

  test('createAndActivateSellOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder order = await lm.placeOrder(token, Credentials.default_space_uuid, 'DE0006048408', OrderSide.sell, 1);
    print('SELL order ${order.uuid} created. Estimated price: ${order.estimatedPrice} (${order.side})');

    ActivateOrderResponse response = await lm.activateOrder(token, order.uuid, null);
    print('activate SELL order: ${response.success} (${response.responseMap.toString()})');

  });

  test('createActivateAndDeleteOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder order = await lm.placeOrder(token, Credentials.default_space_uuid, 'DE000BASF111', OrderSide.buy, 1);
    print('order ${order.uuid} created.');

    ActivateOrderResponse response = await lm.activateOrder(token, order.uuid, null);
    print('activate order: ${response.success} (${response.responseMap.toString()})');

    DeleteOrderResponse responseDeleted = await lm.deleteOrder(token, order.uuid);
    print('delete order: ${responseDeleted.success} (${responseDeleted.responseMap.toString()})');
  });

}
