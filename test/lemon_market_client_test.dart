import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/data/transaction.dart';
import 'package:lemon_markets_client/exception/lemonMarketsInvalidQueryException.dart';
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

  // Authentication

  test('requestToken', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    expect(token, isNotNull);
  });

  // State -> Spaces

  test('getState', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    StateInfo spaces = await lm.getStateInfo(token);
    expect(spaces, isNotNull);
  });

  test('getSpaces', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Space> spaces = await lm.getSpaces(token);
    expect(spaces.result.length, 1);
    expect(spaces.result[0].uuid, spaceUuid);
  });

  test('getSpaceByUuid', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    Space result = await lm.getSpace(token, spaceUuid);
    expect(result, isNotNull);
  });

  test('getSpaceStateByUuid', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    SpaceState result = await lm.getSpaceState(token, spaceUuid);
    expect(result, isNotNull);
  });

  // State -> Orders (post order implicity testet in delete / activate

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

  test('deleteOrder', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    CreatedOrder order = await lm.placeOrder(token, spaceUuid, 'DE000A0D6554', OrderSide.buy, 1);
    DeleteOrderResponse result = await lm.deleteOrder(token, spaceUuid, order.uuid);
    expect(result.success, true);
  });

  test('activateOrder', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    CreatedOrder order = await lm.placeOrder(token, spaceUuid, 'DE000A0D6554', OrderSide.buy, 1);
    ActivateOrderResponse result = await lm.activateOrder(token, spaceUuid, order.uuid);
    expect(result.success, true);
  });

  // State -> Portfolio

  test('getPortfolioItems', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<PortfolioItem> items = await lm.getPortfolioItems(token, Credentials.spaceUuid);
    expect(items.result.length, greaterThan(0));
  });

  test('getPortfolioTransactions', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<PortfolioTransaction> items = await lm.getPortfolioTransactions(token, Credentials.spaceUuid);
    expect(items.result.length, greaterThan(0));
  });

  // State -> Tansactions

  test('getTransactions', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Transaction> list = await lm.getTransactions(token, spaceUuid);
    expect(list.result.length, greaterThan(0));
  });

  test('getTransaction', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    Transaction transaction = await lm.getTransaction(token, spaceUuid, transactionUuidPayIn);
    expect(transaction.order, null);
  });

  test('getTransactionsFromUntil', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    DateTime from = DateTime(2021, 6, 23, 9);
    DateTime until = DateTime(2021, 7, 15, 14, 3);
    ResultList<Transaction> list = await lm.getTransactions(token, spaceUuid, createdAtFrom: from, createdAtUntil: until);
    expect(list.result.length, 2);
  });

  test('getTransactionsFromURL', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Transaction> list = await lm.getTransactions(token, spaceUuid, limit: 1);
    expect(list.result.length, 1);
    expect(list.next, isNotNull);
    String nextUrl = list.next!;
    ResultList<Transaction> nextList = await lm.getTransactionsByURL(token, nextUrl);
    expect(nextList, isNotNull);
  });

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
    expect(all.result.length, 2);
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

  // Market data -> Quotes

  test('getLatestQuotes', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Quote> items = await lm.getLatestQuotes(token, ['US88160R1014'],);
    expect(items.result.length, greaterThan(0));
  });

  test('getQByDate', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    DateTime from = DateTime.fromMillisecondsSinceEpoch(1629109145919);
    DateTime to = DateTime.fromMillisecondsSinceEpoch(1629109145919).add(Duration(hours: 8));
    debugPrint('from $from to $to');
    ResultList<OHLC> items = await lm.getOHLC(token, ['US88160R1014'], OHLCType.h1, from: from, to: to, sorting: Sorting.newestFirst);
    items.result.forEach((element) {
      debugPrint('${LemonMarketsTimeConverter.getDateTimeForLemonMarket(element.time).toString()}: ${element.open}€ - ${element.close}');
    });
    ResultList<Quote> items1 = await lm.getQuotes(token, ['US88160R1014'], from: from, to: to, sorting: Sorting.newestFirst);
    items1.result.forEach((element) {
      debugPrint('${LemonMarketsTimeConverter.getDateTimeForLemonMarket(element.time).toString()}: ${element.bit}€ - ${element.ask}');
    });
  });

  test('getQuotes', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Quote> items = await lm.getQuotes(token, ['US88160R1014'],);
    expect(items.result.length, greaterThan(0));
  });


  // Market data -> OHLC
  
  test('getOHLC', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<OHLC> items = await lm.getOHLC(token, ['US88160R1014'], OHLCType.h1);
    expect(items.result.length, greaterThan(0));
    expect(items.result[0].isin, 'US88160R1014');
  });

  test('getOHLCByDate', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    DateTime from = DateTime.fromMillisecondsSinceEpoch(1629109145919);
    DateTime to = DateTime.fromMillisecondsSinceEpoch(1629109145919).add(Duration(hours: 8));
    debugPrint('from $from to $to');
    ResultList<OHLC> items = await lm.getOHLC(token, ['US88160R1014'], OHLCType.h1, from: from, to: to, sorting: Sorting.newestFirst);
    items.result.forEach((element) {
      debugPrint('${LemonMarketsTimeConverter.getDateTimeForLemonMarket(element.time).toString()}: ${element.open}€ - ${element.close}');
    });
  });

  test('getLatestOHLC', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<OHLC> items = await lm.getLatestOHLC(token, ['US88160R1014'], OHLCType.h1);
    expect(items.result.length, greaterThan(0));
    expect(items.result[0].isin, 'US88160R1014');
  });

  // Market data -> Trades

  test('getTrades', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Trade> items = await lm.getTrades(token, ['US88160R1014']);
    items.result.forEach((element) {
      debugPrint('${element.time} ${LemonMarketsTimeConverter.getDateTimeForLemonMarket(element.time).toString()}: ${element.price}€ - ${element.volume}');
    });
    expect(items.result.length, greaterThan(0));
    expect(items.result[0].isin, 'US88160R1014');
  });

  test('getTradesByDate', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    DateTime from = DateTime.fromMillisecondsSinceEpoch(1629109145919);
    DateTime to = DateTime.fromMillisecondsSinceEpoch(1629109145919).add(Duration(hours: 8));
    debugPrint('from $from to $to');
    ResultList<Trade> items = await lm.getTrades(token, ['US88160R1014'], to: to);
    items.result.forEach((element) {
      debugPrint('${LemonMarketsTimeConverter.getDateTimeForLemonMarket(element.time).toString()}: ${element.price}€ - ${element.volume}');
    });
  });

  test('getLatestTrades', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Trade> items = await lm.getLatestTrade(token, ['US88160R1014']);
    expect(items.result.length, greaterThan(0));
  });

  // Exceptions

  test('getLemonMarketsInvalidQueryException', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
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

}
