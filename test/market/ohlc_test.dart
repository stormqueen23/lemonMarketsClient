import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../credentials.dart';

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

  // Market data -> OHLC
  
  test('getOHLC', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    ResultList<OHLC> items = await lm.getOHLC(token, ['US88160R1014'], OHLCType.h1);
    expect(items.result.length, greaterThan(0));
    expect(items.result[0].isin, 'US88160R1014');
    expect(items.result[0].time.year, greaterThan(2020));
  });

  test('getOHLCByDate', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    DateTime from = DateTime.now().add(Duration(days: -3));
    DateTime to = DateTime.now().add(Duration(days: -1));
    ResultList<OHLC> items = await lm.getOHLC(token, ['US88160R1014'], OHLCType.h1, from: from, to: to, sorting: Sorting.newestFirst);
    expect(items.result, isNotEmpty);
  });

  test('getLatestOHLC', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<OHLC> items = await lm.getLatestOHLC(token, ['US88160R1014'], OHLCType.h1);
    expect(items.result.length, greaterThan(0));
    expect(items.result[0].isin, 'US88160R1014');
  });

}
