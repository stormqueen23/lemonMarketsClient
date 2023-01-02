@Timeout(Duration(minutes: 3))

import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../credentials.dart';

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
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    DateTime from = DateTime(2022, 11, 16, 21, 45);
    DateTime to =   DateTime(2022, 11, 16, 21, 50);

    ResultList<Trade> items = await lm.getTrades(token, ['US88160R1014'], from: from, to: to);
    print(items.count);
    print(items);
  });

  test('getLatestTrades', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<Trade> items = await lm.getLatestTrade(token, ['US88160R1014']);
    expect(items.result.length, greaterThan(0));
    print(items.result.first);
  });

}
