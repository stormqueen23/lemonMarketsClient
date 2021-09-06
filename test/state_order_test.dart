import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'credentials.dart';

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

  test('getOrders', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<ExistingOrder> all = await lm.getOrders(token, Credentials.spaceUuid);
    expect(all.result.length, greaterThan(0));
  });

  test('getSingleOrder', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ExistingOrder order = await lm.getOrder(token, Credentials.spaceUuid, Credentials.orderUuid);
    expect(order.uuid, Credentials.orderUuid);
    //check if dates are correct
    expect(order.createdAt.year, 2021);
    expect(order.validUntil.year, 2022);
    expect(order.processedAt!.year, 2021);
  });

  test('deleteOrder', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);

    CreatedOrder order = await lm.placeOrder(token, spaceUuid, 'DE000A0D6554', OrderSide.buy, 1);
    expect(order.validUntil.year, greaterThan(2020));

    DeleteOrderResponse result = await lm.deleteOrder(token, spaceUuid, order.uuid);
    expect(result.success, true);

  });

  test('activateOrder', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    CreatedOrder order = await lm.placeOrder(token, spaceUuid, 'DE000A0D6554', OrderSide.buy, 1);
    ActivateOrderResponse result = await lm.activateOrder(token, spaceUuid, order.uuid);
    expect(result.success, true);
  });

  test('placeOrderStopAndLimit', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    CreatedOrder order = await lm.placeOrder(token, spaceUuid, 'DE000A0D6554', OrderSide.buy, 1, limitPrice: 2, stopPrice: 2.50,);
    expect(order.limitPrice, 2);
    expect(order.stopPrice, 2.5);
  });

  test('placeOrderDate', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    DateTime valid = DateTime.now().add(Duration(days: 30));
    CreatedOrder order = await lm.placeOrder(token, spaceUuid, 'DE000A0D6554', OrderSide.buy, 1, validUntil: valid);
    expect(order.validUntil.year, valid.year);
    expect(order.validUntil.month, valid.month);
    expect(order.validUntil.day, valid.day);
    expect(order.validUntil.hour, valid.hour);
    expect(order.validUntil.minute, valid.minute);
    expect(order.validUntil.second, valid.second);
  });

}
