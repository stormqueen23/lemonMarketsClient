import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../credentials.dart';

String mic = 'XMUN';
String isin = 'DE000HAG0005';

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
    CreatedOrder order = (await lm.placeOrder(token, isin, OrderSide.sell, 153, venue: mic)).result!;
    print('order ${order.uuid} created. expires at ${order.validUntil} ${order.validUntil.toIso8601String()}');

    String orderToActivate = order.uuid;
    ActivateOrderResult response = await lm.activateOrder(token, orderToActivate, null);
    print('activate order: ${response.success} (${response.responseMap.toString()})');

    expect(order, isNotNull);
    print(order);
  });


  test('createAndDeleteOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    TradingResultList<Order> orders = await lm.getOrders(token);
    print('found ${orders.result.length} orders for space');
    int numberOfOrders = orders.count ?? 0;

    CreatedOrder order = (await lm.placeOrder(token, isin, OrderSide.buy, 2, limitPrice: Amount(value: 1))).result!;
    print('order ${order.uuid} created. Estimated price: ${order.estimatedPrice.displayValue}');
    print(order);
    orders = await lm.getOrders(token);
    print('found ${orders.result.length} orders for space');
    int numberOfOrdersAfterCreation = orders.count ?? 0;
    expect(numberOfOrdersAfterCreation, equals(numberOfOrders+1));

    DeleteOrderResult response = await lm.deleteOrder(token, order.uuid);
    print('delete order: ${response.success} (${response.responseMap.toString()})');

    orders = await lm.getOrders(token);
    //int numberOfOrdersAfterDeletion = orders.count ?? 0;
    //expect(numberOfOrdersAfterDeletion, equals(numberOfOrders));
    print('found ${orders.count} orders');

  });

  test('createAndDeleteStopOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder order = (await lm.placeOrder(token, isin, OrderSide.buy, 1, stopPrice: Amount(value: 1.5))).result!;
    print('order ${order.uuid} created. expires at ${order.validUntil} ${order.validUntil.toIso8601String()}, stopPrice: ${order.stopPrice?.displayValue} (${order.stopPrice?.apiValue})');
    await lm.deleteOrder(token, order.uuid);

    order = (await lm.placeOrder(token, isin, OrderSide.buy, 1, stopPrice: Amount(value: 1))).result!;
    print('order ${order.uuid} created. expires at ${order.validUntil} ${order.validUntil.toIso8601String()}, stopPrice: ${order.stopPrice?.displayValue} (${order.stopPrice?.apiValue})');
    await lm.deleteOrder(token, order.uuid);
  });
/*
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
*/

  test('getSinceAllOrders', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<Order> orders = await lm.getOrders(token, from: DateTime.now().add(Duration(days: -7)));
    print('found ${orders.result.length} orders');
    for (Order element in orders.result) {
      print(element);
    }
  });
  test('getAllOrders', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<Order> orders = await lm.getOrders(token);
    print('found ${orders.result.length} orders');
    for (Order element in orders.result) {
      print(element);
    }
  });

  test('getByStatus', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<Order> order = await lm.getOrders(token, status: [OrderStatus.inactive, OrderStatus.expired]);
    print('found ${order.result} orders');
    print(order);
  });

  test('getFindOneOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder createdOrder = (await lm.placeOrder(token, isin, OrderSide.buy, 1, stopPrice: Amount(value: 1.5))).result!;
    Order existingOrder = (await lm.getOrder(token, createdOrder.uuid)).result!;
    print('found ${existingOrder.isin}');
    print(existingOrder);
    expect(existingOrder, isNotNull);

    lm.deleteOrder(token, existingOrder.uuid);
  });

  test('activateOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder order = (await lm.placeOrder(token, isin, OrderSide.buy, 1, stopPrice: Amount(value: 1.5))).result!;
    String orderToActivate = order.uuid;
    ActivateOrderResult response = await lm.activateOrder(token, orderToActivate, null);
    print('activate order: ${response.success} (${response.responseMap.toString()})');

    Order existingOrder = (await lm.getOrder(token, orderToActivate)).result!;
    print('found ${existingOrder.isin}: status=${existingOrder.status}, estimated price=${existingOrder.estimatedPrice}');
    print(existingOrder);
  });

  test('createAndActivateBuyOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder order = (await lm.placeOrder(token, 'DE0006048408', OrderSide.buy, 2)).result!;
    print('BUY order ${order.uuid} created. Estimated price: ${order.estimatedPrice} (${order.side})');

    ActivateOrderResult response = await lm.activateOrder(token, order.uuid, null);
    print('activate BUY order: ${response.success} (${response.responseMap.toString()})');

    Order eorder = (await lm.getOrder(token, order.uuid)).result!;
    print('found ${eorder.isin}');
    print(eorder);

  });

  test('createAndActivateSellOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    TradingResult<CreatedOrder> result = (await lm.placeOrder(token, 'DE0006048408', OrderSide.sell, 100));
    print('${result.status} | ${result.errorCode} | ${result.errorMessage}');
    if (result.result != null) {
      CreatedOrder order = result.result!;
      print('SELL order ${order.uuid} created. Estimated price: ${order.estimatedPrice} (${order.side})');

      ActivateOrderResult response = await lm.activateOrder(token, order.uuid, null);
      print('activate SELL order: ${response.success} (${response.responseMap.toString()})');
    }

  });

  test('createActivateAndDeleteOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder order = (await lm.placeOrder(token, 'DE000BASF111', OrderSide.buy, 1)).result!;
    print('order ${order.uuid} created.');

    ActivateOrderResult response = await lm.activateOrder(token, order.uuid, null);
    print('activate order: ${response.success}, mode: ${response.mode} (${response.responseMap.toString()})');

    DeleteOrderResult responseDeleted = await lm.deleteOrder(token, order.uuid);
    print('delete order: ${responseDeleted.success}, mode: ${response.mode} (${responseDeleted.responseMap.toString()})');
  });

}
