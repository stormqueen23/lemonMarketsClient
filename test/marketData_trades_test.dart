import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';
import 'package:logging/logging.dart';

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

  // Market data -> Trades

  test('getTrades', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Trade> items = await lm.getTrades(token, ['US88160R1014']);
    items.result.forEach((element) {
      debugPrint('${element.time} ${element.time.toString()}: ${element.price}€ - ${element.volume}');
    });
    expect(items.result.length, greaterThan(0));
    expect(items.result[0].isin, 'US88160R1014');
    expect(items.result[0].time.year, greaterThan(2020));
  });

  test('getTradesByDate', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    DateTime from = DateTime.fromMillisecondsSinceEpoch(1629109145919);
    DateTime to = DateTime.fromMillisecondsSinceEpoch(1629109145919).add(Duration(hours: 8));
    debugPrint('from $from to $to');
    ResultList<Trade> items = await lm.getTrades(token, ['US88160R1014'], to: to);
    items.result.forEach((element) {
      debugPrint('${element.time.toString()}: ${element.price}€ - ${element.volume}');
    });
  });

  test('getLatestTrades', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Trade> items = await lm.getLatestTrade(token, ['US88160R1014']);
    expect(items.result.length, greaterThan(0));
  });

}
