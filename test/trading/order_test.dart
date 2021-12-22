import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../credentials.dart';

String spaceUuid = Credentials.spaceUuid;
String mic = 'ALLDAY';
String isin = 'DE000BASF111';

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
    CreatedOrder order = await lm.placeOrder(token, spaceUuid, isin, OrderSide.buy, 1, venue: mic);
    print('order ${order.uuid} created. expires at ${order.validUntil} ${order.validUntil.toIso8601String()}');
    expect(order, isNotNull);
    print(order);
  });


  test('createAndDeleteOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    TradingResultList<ExistingOrder> orders = await lm.getOrders(token, spaceUuid: spaceUuid);
    print('found ${orders.result.length} orders for space');
    int numberOfOrders = orders.count ?? 0;

    CreatedOrder order = await lm.placeOrder(token, spaceUuid, isin, OrderSide.buy, 2, limitPrice: Amount(value: 1));
    print('order ${order.uuid} created. Estimated price: ${order.estimatedPrice.displayValue}');
    print(order);
    orders = await lm.getOrders(token, spaceUuid: spaceUuid);
    print('found ${orders.result.length} orders for space');
    int numberOfOrdersAfterCreation = orders.count ?? 0;
    expect(numberOfOrdersAfterCreation, equals(numberOfOrders+1));

    DeleteOrderResponse response = await lm.deleteOrder(token, order.uuid);
    print('delete order: ${response.success} (${response.responseMap.toString()})');

    orders = await lm.getOrders(token, spaceUuid: spaceUuid);
    //int numberOfOrdersAfterDeletion = orders.count ?? 0;
    //expect(numberOfOrdersAfterDeletion, equals(numberOfOrders));
    print('found ${orders.count} orders');

  });

  test('createAndDeleteStopOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder order = await lm.placeOrder(token, spaceUuid, isin, OrderSide.buy, 1, stopPrice: Amount(value: 1.5));
    print('order ${order.uuid} created. expires at ${order.validUntil} ${order.validUntil.toIso8601String()}, stopPrice: ${order.stopPrice?.displayValue} (${order.stopPrice?.apiValue})');
    await lm.deleteOrder(token, order.uuid);

    order = await lm.placeOrder(token, spaceUuid, isin, OrderSide.buy, 1, stopPrice: Amount(value: 1));
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
  test('getAllOrders', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<ExistingOrder> orders = await lm.getOrders(token);
    print('found ${orders.result.length} orders');
    for (ExistingOrder element in orders.result) {
      print(element);
    }
  });

  test('getByStatus', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<ExistingOrder> order = await lm.getOrders(token, status: OrderStatus.activated);
    print('found ${order.result} orders');
    print(order);
  });

  test('getFindOneOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder createdOrder = await lm.placeOrder(token, spaceUuid, isin, OrderSide.buy, 1, stopPrice: Amount(value: 1.5));
    ExistingOrder existingOrder = await lm.getOrder(token, createdOrder.uuid);
    print('found ${existingOrder.isin}');
    print(existingOrder);
    expect(existingOrder, isNotNull);

    lm.deleteOrder(token, existingOrder.uuid);
  });

  test('activateOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder order = await lm.placeOrder(token, spaceUuid, isin, OrderSide.buy, 1, stopPrice: Amount(value: 1.5));
    String orderToActivate = order.uuid;
    ActivateOrderResponse response = await lm.activateOrder(token, orderToActivate, null);
    print('activate order: ${response.success} (${response.responseMap.toString()})');

    ExistingOrder existingOrder = await lm.getOrder(token, orderToActivate);
    print('found ${existingOrder.isin}: status=${existingOrder.status}, estimated price=${existingOrder.estimatedPrice}');
    print(existingOrder);
  });

  test('createAndActivateBuyOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder order = await lm.placeOrder(token, spaceUuid, 'DE0006048408', OrderSide.buy, 2);
    print('BUY order ${order.uuid} created. Estimated price: ${order.estimatedPrice} (${order.side})');

    ActivateOrderResponse response = await lm.activateOrder(token, order.uuid, null);
    print('activate BUY order: ${response.success} (${response.responseMap.toString()})');

    ExistingOrder eorder = await lm.getOrder(token, order.uuid);
    print('found ${eorder.isin}');
    print(eorder);

  });

  test('createAndActivateSellOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder order = await lm.placeOrder(token, spaceUuid, 'DE0006048408', OrderSide.sell, 1);
    print('SELL order ${order.uuid} created. Estimated price: ${order.estimatedPrice} (${order.side})');

    ActivateOrderResponse response = await lm.activateOrder(token, order.uuid, null);
    print('activate SELL order: ${response.success} (${response.responseMap.toString()})');

  });

  test('createActivateAndDeleteOrder', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    CreatedOrder order = await lm.placeOrder(token, spaceUuid, 'DE000BASF111', OrderSide.buy, 1);
    print('order ${order.uuid} created.');

    ActivateOrderResponse response = await lm.activateOrder(token, order.uuid, null);
    print('activate order: ${response.success} (${response.responseMap.toString()})');

    DeleteOrderResponse responseDeleted = await lm.deleteOrder(token, order.uuid);
    print('delete order: ${responseDeleted.success} (${responseDeleted.responseMap.toString()})');
  });

}
