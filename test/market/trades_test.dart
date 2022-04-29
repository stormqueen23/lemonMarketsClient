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

  test('getLatestTrades', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<Trade> items = await lm.getLatestTrade(token, ['US88160R1014']);
    expect(items.result.length, greaterThan(0));
  });

  test('getHistoricalTrades', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    String isin = 'DE0007037129';
    DateTime day = DateTime(2022,3,1);

    HistoricalUrlWrapper result = await lm.getTradesForDate(token, isin, day);
    while (result.result.url == null) {
      await Future.delayed(Duration(seconds: 20));
      result = await lm.getTradesForDate(token, isin, day);
    }
    print(result.result.url);
    String data = await lm.getHistoricalData(result.result.url!);

    print(data);
  });
}
