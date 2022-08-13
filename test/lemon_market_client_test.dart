import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'credentials.dart';

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

  // Exceptions

  test('getLemonMarketsInvalidQueryException', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    DateTime from = DateTime.fromMillisecondsSinceEpoch(1629109145919);
    DateTime to = DateTime.fromMillisecondsSinceEpoch(1629109145919).add(Duration(hours: 8));
    try {
      await lm.getOHLC(token, ['US88160R1014'], OHLCType.h1, from: to, to: from, sorting: Sorting.newestFirst);
    } on LemonMarketsException catch (e) {
      expect(e.responseCode, 400);
    }
    //throwsA(TypeMatcher<LemonMarketsInvalidQueryException>());
  }
  );

  test('getLemonMarketsRateLimitException', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    try {
      for (int i = 0; i < 300; i++) {
        await lm.getOrders(token, limit: 1);
      }
    } on LemonMarketsRateLimitException catch (e1) {
      print('reset in '+e1.reset.toString()+'s -> '+e1.responseMap.toString());
    } on LemonMarketsException catch (e) {
      print('LemonMarketsException: '+e.responseCode.toString()+' '+e.responseMap.toString());

    }
    //throwsA(TypeMatcher<LemonMarketsInvalidQueryException>());
  }
  );

}
