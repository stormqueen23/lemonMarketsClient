@Timeout(Duration(seconds: 480))

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

  // Market data -> Quotes

  test('determineBitAskSpread', () async {
    Quote item = Quote('TEST', 100, 1, 99, 1, DateTime.now(), 'TEST');
    print('bid: ${item.bit}, ask: ${item.ask}, spread: ${item.bidAskSpread}');
    expect(item.bidAskSpread, 1.0);
  });

  test('getLatestQuotes', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<Quote> items = await lm.getLatestQuote(token, ['DE000PSM7770'],);
    expect(items.result.length, greaterThan(0));
    expect(items.result[0].time.year, greaterThan(2020));
    Quote item = items.result[0];
    print('bid: ${item.bit}, ask: ${item.ask}, spread: ${item.bidAskSpread}, time ${item.time}');
  });

  test('getHistoricalQuotes', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    String isin = 'DE0007037129';
    DateTime day = DateTime(2022,4,14);

    HistoricalUrlWrapper result = await lm.getQuotesForDate(token, isin, day);
    while (result.result.url == null) {
      await Future.delayed(Duration(seconds: 20));
      result = await lm.getQuotesForDate(token, isin, day);
    }
    print(result.result.url);
    String data = await lm.getHistoricalData(result.result.url!);
    print(data);
  });
}
