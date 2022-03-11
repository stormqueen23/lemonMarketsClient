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
    print('bid: ${item.bit}, ask: ${item.ask}, spread: ${item.bidAskSpread}');
  });

  test('getQByDate', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    DateTime from = DateTime.now().add(Duration(days: -5));
    DateTime to = DateTime.now().add(Duration(hours: -5));
    ResultList<Quote> items = await lm.getQuotes(token, ['US88160R1014'], from: from, to: to, sorting: Sorting.newestFirst);
    expect(items.result, isNotEmpty);
  });

  test('getQuotes', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<Quote> items = await lm.getQuotes(token, ['US88160R1014'],);
    expect(items.result.length, greaterThan(0));
  });

}
