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

  // Market data -> Tranding venues

  test('getTradingVenues', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<TradingVenue> tradingVenues = await lm.getTradingVenues(token);
    expect(tradingVenues.result, isNotEmpty);
  });

  test('getXMUNTradingVenue', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<TradingVenue> tradingVenue = await lm.getTradingVenues(token, mics: ['XMUN']);
    expect(tradingVenue.result.length, 1);
  });

  test('getMultipleTradingVenue', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<TradingVenue> tradingVenue = await lm.getTradingVenues(token, mics: ['XMUN', 'LMBPX']);
    expect(tradingVenue.result.length, 2);
  });

}
