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

  // Market data -> OHLC

  test('getSpecificOHLC', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    ResultList<OHLC> items = await lm.getOHLC(token, ['DE0005775803', 'JP3249600002', 'DE0007100000', 'FR0000039109', 'US5745991068', 'NZTELE0001S4', 'US23331S1006', 'AT0000758305', 'SE0014855292', 'ES0130670112'], OHLCType.d1, limit: 100, from: DateTime.now().add(Duration(hours: -24)));
    print(items.count);
    items.result.forEach((element) {
      print(element);
    });
  });

  test('getXOHLC', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<OHLC> items = await lm.getOHLC(token, ['DE000KSAG888'], OHLCType.m1, from: DateTime.now().add(Duration(hours: -24)));
    print("count: " + items.count.toString());
  });

  test('getOHLCByDate', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    DateTime from = DateTime(2022, 3, 7);
    DateTime to = DateTime(2022, 3, 8);
    ResultList<OHLC> items = await lm.getOHLC(token, ['DE0007100000'], OHLCType.d1, from: from, sorting: Sorting.newestFirst);
    print(items);
    expect(items.result, isNotEmpty);
    ResultList<OHLC> itemsMinute = await lm.getOHLC(token, ['DE0007100000'], OHLCType.m1, from: from, to: to, sorting: Sorting.oldestFirst);
    print(itemsMinute.result.first.time.toString()+': '+itemsMinute.result.first.open.toString());
    print(itemsMinute.result.last.time.toString()+': '+itemsMinute.result.last.close.toString());
  });

  test('getLatestOHLC', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<OHLC> items = await lm.getLatestOHLC(token, ['US88160R1014'], OHLCType.h1);
    expect(items.result.length, greaterThan(0));
    expect(items.result[0].isin, 'US88160R1014');
    print(items.result[0].time);
    print(items);
  });

  test('getXOHLC', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<OHLC> items = await lm.getOHLC(token, ['US88160R1014'], OHLCType.d1);
    expect(items.result.length, greaterThan(0));
    expect(items.result[0].isin, 'US88160R1014');
  });

}
