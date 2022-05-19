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

  // Market data -> OHLC

  test('requestCounter', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    lm.enableRequestCount();
    lm.enableRequestLogging();
    await lm.getOHLC(token, ['DE0005775803'], OHLCType.d1, limit: 100, from: DateTime.now().add(Duration(hours: -124)));
    expect(lm.getMarketRequestCount(), 1);
    await lm.getLatestQuote(token, ['DE000PSM7770'],);
    expect(lm.getMarketRequestCount(), 2);
    lm.resetMarketRequestCount();
    expect(lm.getMarketRequestCount(), 0);
    print(lm.getRequestLog());
  });


}
