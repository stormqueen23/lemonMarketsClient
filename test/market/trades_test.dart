import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../credentials.dart';

String spaceUuid = Credentials.spaceUuid;

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
    ResultList<Trade> items = await lm.getTrades(token, ['FR0000182479']);
    expect(items.result.length, greaterThan(0));
    expect(items.result[0].isin, 'FR0000182479');
    expect(items.result[0].time.year, greaterThan(2020));
    print(items.result.first);
  });

  test('getTradesByDate', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    //DateTime from = DateTime.fromMillisecondsSinceEpoch(1629109145919);
    DateTime to = DateTime.now().add(Duration(hours: -8));
    ResultList<Trade> items = await lm.getTrades(token, ['US88160R1014'], to: to);
    expect(items.result, isNotEmpty);
  });

  test('getLatestTrades', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<Trade> items = await lm.getLatestTrade(token, ['US88160R1014']);
    expect(items.result.length, greaterThan(0));
  });

}
