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

  // Market data -> Quotes

  test('getLatestQuotes', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Quote> items = await lm.getLatestQuote(token, ['US88160R1014'],);
    expect(items.result.length, greaterThan(0));
    expect(items.result[0].time.year, greaterThan(2020));
  });

  test('getQByDate', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    DateTime from = DateTime.fromMillisecondsSinceEpoch(1629109145919);
    DateTime to = DateTime.fromMillisecondsSinceEpoch(1629109145919).add(Duration(hours: 8));
    ResultList<Quote> items1 = await lm.getQuotes(token, ['US88160R1014'], from: from, to: to, sorting: Sorting.newestFirst);
  });

  test('getQuotes', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Quote> items = await lm.getQuotes(token, ['US88160R1014'],);
    expect(items.result.length, greaterThan(0));
  });

}
