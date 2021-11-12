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

  // Market data -> Instruments

  test('searchInstrumentsWithoutParams', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> all = await lm.searchInstruments(token);
    expect(all.result.length, greaterThan(0));
  });

  test('searchInstrumentsByIsin', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> all = await lm.searchInstruments(token, isin: ['DE000A0D6554']);
    expect(all.result.length, 1);
  });

  test('searchInstrumentsByMultipleIsin', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> all = await lm.searchInstruments(token, isin: ['DE000A0D6554', 'US88160R1014']);
    expect(all.result.length, 2);
  });

  test('searchInstrumentsWithQuery', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> all = await lm.searchInstruments(token, query: 'Tesla');
    expect(all.result.length, greaterThan(0));
  });

  test('searchInstrumentsWithQueryAndType', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> all = await lm.searchInstruments(token, query: 'Tesla', types: [SearchType.stock]);
    expect(all.result.length, greaterThan(0));
  });

  test('searchInstrumentsWithQueryAndMultipleType', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> all = await lm.searchInstruments(token, query: 'Tesla', types: [SearchType.stock, SearchType.warrant]);
    expect(all.result.length, greaterThan(0));
  });

  test('searchInstrumentsWithQueryAndLimit', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> all = await lm.searchInstruments(token, query: 'Tesla', limit: "2");
    expect(all.result.length, 2, reason: "Expected result: 2, given result: ${all.result.length}");
  });

  test('searchInstrumentsWithQueryAndLimitAndOffset', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> prev = await lm.searchInstruments(token, query: 'Tesla', limit: "1", offset: 0);
    ResultList<Instrument> all = await lm.searchInstruments(token, query: 'Tesla', limit: "1", offset: 1);
    expect(prev.result.length, 1);
    expect(all.result.length, 1);
    expect(all.result.first.isin, isNot(prev.result.first.isin));
  });

  test('searchInstrumentsWithQueryAndCurrency', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> all = await lm.searchInstruments(token, query: 'Tesla', currency: 'EUR');
    expect(all.result.length, greaterThan(0));
  });

}
