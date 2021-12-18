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

  // Market data -> Tranding venues

  test('getTradingVenues', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<TradingVenue> tradingVenues = await lm.getTradingVenues(token);
    expect(tradingVenues.result, isNotEmpty);
  });

  test('getXMUNTradingVenue', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<TradingVenue> tradingVenue = await lm.getTradingVenues(token, mics: ['XMUN']);
    expect(tradingVenue.result.length, 1);
  });

  test('getMultipleTradingVenue', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<TradingVenue> tradingVenue = await lm.getTradingVenues(token, mics: ['XMUN', 'LMBPX']);
    expect(tradingVenue.result.length, 2);
  });

}
