import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/data/transaction.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';
import 'package:logging/logging.dart';

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

  test('requestToken', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    expect(token, isNotNull);
  });

  test('getSpaces', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Space> spaces = await lm.getSpaces(token);
    expect(spaces.result.length, 1);
    expect(spaces.result[0].uuid, spaceUuid);
  });

  test('getTransactionsForSpace', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Transaction> list = await lm.getTransactionsForSpace(token, spaceUuid);
    expect(list.result.length, greaterThan(0));
  });

  test('getPortfolioTransactions', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<PortfolioTransaction> list = await lm.getPortfolioTransactions(token, spaceUuid);
    expect(list.result.length, greaterThan(0));
  });

  test('getTransactionsForSpaceFromUntil', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    DateTime from = DateTime(2021, 6, 23, 9);
    double fromDouble = LemonMarketsTimeConverter.getDoubleTimeForDateTime(from);
    DateTime until = DateTime(2021, 7, 15, 14, 3);
    double untilDouble = LemonMarketsTimeConverter.getDoubleTimeForDateTime(until);
    ResultList<Transaction> list = await lm.getTransactionsForSpace(token, spaceUuid, createdAtFrom: fromDouble.toInt(), createdAtUntil: untilDouble.toInt());
    expect(list.result.length, 2);
  });

  test('getTransactionsFromURL', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Transaction> list = await lm.getTransactionsForSpace(token, spaceUuid, limit: 1);
    expect(list.result.length, 1);
    expect(list.next, isNotNull);
    String nextUrl = list.next!;
    ResultList<Transaction> nextList = await lm.getTransactionsFromURL(token, nextUrl);
    expect(nextList, isNotNull);
  });

  test('getTransactionForSpace', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    Transaction transaction = await lm.getTransactionForSpace(token, spaceUuid, transactionUuidPayIn);
    expect(transaction.order, null);
  });

  test('getTradingVenues', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<TradingVenue> tradingVenues = await lm.getTradingVenues(token);
    expect(tradingVenues.result, isNotEmpty);
  });

  test('getXMUNTradingVenue', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    String mic = 'XMUN';
    TradingVenue tradingVenue = await lm.getTradingVenue(token, mic);
    expect(tradingVenue.mic, mic);
  });

  test('getXMUNOpeningDays', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    String mic = 'XMUN';
    ResultList<OpeningDay> openingDays = await lm.getTradingVenueOpeningDays(token, mic);
    expect(openingDays.result, isNotEmpty);
  });

  test('searchInstrumentsWithoutParams', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> all = await lm.searchInstruments(token);
    expect(all.result.length, greaterThan(0));
  });

  test('searchInstrumentsWithQuery', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> all = await lm.searchInstruments(token, search: 'Tesla');
    expect(all.result.length, greaterThan(0));
  });

  test('searchInstrumentsWithQueryAndType', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> all = await lm.searchInstruments(token, search: 'Tesla', type: SearchType.stock);
    expect(all.result.length, greaterThan(0));
  });

  test('searchInstrumentsWithQueryAndLimit', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> all = await lm.searchInstruments(token, search: 'Tesla', limit: "2");
    expect(all.result.length, 2);
  });

  test('searchInstrumentsWithQueryAndLimitAndOffset', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> prev = await lm.searchInstruments(token, search: 'Tesla', limit: "1", offset: 0);
    ResultList<Instrument> all = await lm.searchInstruments(token, search: 'Tesla', limit: "1", offset: 1);
    expect(prev.result.length, 1);
    expect(all.result.length, 1);
    expect(all.result.first.isin, isNot(prev.result.first.isin));
  });

  test('searchInstrumentsWithQueryAndCurrency', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> all = await lm.searchInstruments(token, search: 'Tesla', currency: 'USD');
    expect(all.result.length, greaterThan(0));
  });

  test('getOrders', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<ExistingOrder> all = await lm.getOrders(token, Credentials.spaceUuid);
    expect(all.result.length, greaterThan(0));
  });

  test('getSingleOrder', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ExistingOrder order = await lm.getOrder(token, Credentials.spaceUuid, Credentials.orderUuid);
    expect(order.uuid, Credentials.orderUuid);
  });

  test('getPortfolioItems', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<PortfolioItem> items = await lm.getPortfolioItems(token, Credentials.spaceUuid);
    expect(items.result.length, greaterThan(0));
  });

  test('getOHLC', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<OHLC> items = await lm.getOHLC(token, 'US88160R1014', OHLCType.h1);
    expect(items.result.length, greaterThan(0));
  });

  test('searchInstrumentsForTradingVenue', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Instrument> all = await lm.searchTradingVenueInstruments(token, 'XMUN');
    expect(all.result.length, greaterThan(0));
  });

  test('searchSingleInstrumentForTradingVenue', () async {
    String isin = 'US88160R1014';
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    Instrument result = await lm.searchTradingVenueInstrument(token, 'XMUN', isin);
    expect(result.isin, isin);
  });

  test('searchWarrantForInstrumentForTradingVenue', () async {
    String isin = 'US88160R1014';
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Warrant> result = await lm.searchTradingVenueInstrumentWarrants(token, 'XMUN', isin);
    expect(result.result.length, greaterThan(0));
  });

  test('searchWithLimitWarrantForInstrumentForTradingVenue', () async {
    String isin = 'US88160R1014';
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Warrant> result = await lm.searchTradingVenueInstrumentWarrants(token, 'XMUN', isin, limit: "1");
    expect(result.result.length, 1);
  });

}
