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

  test('getLimitMultipleTradingVenue', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<TradingVenue> tradingVenue = await lm.getTradingVenues(token, mics: ['XMUN', 'LMBPX'], limit: 1);
    expect(tradingVenue.result.length, 1);
  });

  test('tradingVenueIsOpen', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<TradingVenue> tradingVenues = await lm.getTradingVenues(token);
    TradingVenue tv = tradingVenues.result.first;
    DateTime at = DateTime(2022,3,20,7,0);
    bool isOpen = tv.isTradingVenueOpen(at);
    print(at.timeZoneOffset);
    print(at.timeZoneName);
    print(isOpen);
  });

  test('previousOpeningDay', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<TradingVenue> tradingVenues = await lm.getTradingVenues(token);
    TradingVenue tv = tradingVenues.result.first;
    DateTime at = DateTime(2022,3,29,9,0);
    String? prev = tv.getPreviousOpeningDay(at);
    print('previous day $prev (to date $at)');
  });

  test('nextOpeningDay', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    ResultList<TradingVenue> tradingVenues = await lm.getTradingVenues(token);
    TradingVenue tv = tradingVenues.result.first;
    DateTime at = DateTime(2022,3,26,9,0);
    String? next = tv.getNextOpeningDay(at);
    print('next day $next (to date $at)');
  });
}
