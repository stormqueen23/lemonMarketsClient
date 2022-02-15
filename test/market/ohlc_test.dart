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

  test('getOHLC', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    ResultList<OHLC> items = await lm.getOHLC(token, ['IL0011582033'], OHLCType.h1, from: DateTime.now().add(Duration(hours: -9)));
    expect(items.result.length, greaterThan(0));
    expect(items.result[0].isin, 'IL0011582033');
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
