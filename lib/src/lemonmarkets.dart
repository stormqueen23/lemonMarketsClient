import 'dart:async';

import 'package:lemon_markets_client/clients/account/lemonMarketsAccount.dart';
import 'package:lemon_markets_client/clients/clientData.dart';
import 'package:lemon_markets_client/clients/market/lemonMarketsSearch.dart';
import 'package:lemon_markets_client/clients/market/lemonMarketsTradingVenue.dart';
import 'package:lemon_markets_client/clients/trading/lemonMarketsTransactions.dart';
import 'package:lemon_markets_client/data/amount.dart';
import 'package:lemon_markets_client/data/auth/accessToken.dart';
import 'package:lemon_markets_client/data/trading/createdOrder.dart';
import 'package:lemon_markets_client/data/trading/existingOrder.dart';
import 'package:lemon_markets_client/data/market/instrument.dart';
import 'package:lemon_markets_client/data/market/quote.dart';
import 'package:lemon_markets_client/data/market/trade.dart';
import 'package:lemon_markets_client/data/market/ohlc.dart';
import 'package:lemon_markets_client/data/trading/portfolioItem.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/data/trading/space.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/clients/market/lemonMarketsMarketData.dart';
import 'package:lemon_markets_client/clients/trading/lemonMarketsPortfolio.dart';
import 'package:lemon_markets_client/clients/trading/lemonMarketsSpaces.dart';
import 'package:lemon_markets_client/clients/trading/lemonMarketsOrder.dart';
import 'package:lemon_markets_client/data/tradingResultList.dart';
import 'package:lemon_markets_client/data/market/tradingVenue.dart';
import 'package:lemon_markets_client/data/trading/transaction.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:logging/logging.dart';

//Alle, Aktie, Anleihe, Fond, ETF, Optionsschein
enum SearchType { none, stock, bond, fund, etf, warrant }

enum OrderSide { buy, sell, unknown }
enum OrderStatus { inactive, activated, in_progress, executed, deleted, expired, unknown }
enum OrderType { limit, market, stopLimit, stop, unknown }

enum OHLCType { m1, h1, d1 }

enum Sorting { newestFirst, oldestFirst }

enum SpaceType { auto, manual, unknown }

enum AccountMode { paper, money }

enum TradingPlan { free, basic, pro }
enum DataPlan { free, basic, pro }

enum TransactionType { payIn, payOut, orderBuy, orderSell, dividend, tax, unknown}

class LemonMarkets {
  final Logger log = Logger('LemonMarkets');

  late LemonMarketsSpaces _spacesClient;
  late LemonMarketsPortfolio _portfolioClient;
  //late LemonMarketsAuth _authClient;
  late LemonMarketsOrder _tradingClient;
  late LemonMarketsMarketData _marketClient;
  late LemonMarketsSearch _searchClient;
  late LemonMarketsTransaction _transactionClient;
  late LemonMarketsTradingVenue _tradingVenueClient;
  late LemonMarketsAccount _accountClient;

  LemonMarkets() {
    LemonMarketsHttpClient client = LemonMarketsHttpClient();
    _spacesClient = LemonMarketsSpaces(client);
    //_authClient = LemonMarketsAuth(client);
    _tradingClient = LemonMarketsOrder(client);
    _marketClient = LemonMarketsMarketData(client);
    _portfolioClient = LemonMarketsPortfolio(client);
    _searchClient = LemonMarketsSearch(client);
    _transactionClient = LemonMarketsTransaction(client);
    _tradingVenueClient = LemonMarketsTradingVenue(client);
    _accountClient = LemonMarketsAccount(client);
  }

  // Authentication
/*
  Future<AccessToken> requestToken(String clientId, String clientSecret) async {
    AccessToken token = await _authClient.requestToken(clientId, clientSecret);
    return token;
  }
*/
  // Account

  Future<Account> getAccountData(AccessToken token) async {
    return _accountClient.getAccountData(token);
  }

  // Trading -> Spaces

  Future<Space> createSpace(AccessToken token, String name, SpaceType type, Amount riskLimit,
      {String? description}) async {
    return _spacesClient.createSpace(token, name, type, riskLimit, description: description);
  }

  Future<TradingResultList<Space>> getSpaces(AccessToken token, {SpaceType? type}) async {
    return _spacesClient.getSpaces(token, type: type);
  }

  Future<TradingResultList<Space>> getSpacesByUrl(AccessToken token, String url) async {
    return _spacesClient.getSpacesByUrl(token, url);
  }

  Future<Space> getSpace(AccessToken token, String spaceUuid) async {
    return _spacesClient.getSpace(token, spaceUuid);
  }

  Future<Space> alterSpace(AccessToken token, String uuid, {String? name, Amount? riskLimit, String? description}) async {
    return _spacesClient.alterSpace(token, uuid, name: name, description: description, riskLimit: riskLimit);
  }

  Future<bool> deleteSpace(AccessToken token, String spaceUuid) async {
    return _spacesClient.deleteSpace(token, spaceUuid);
  }

  // Trading -> Orders

  Future<CreatedOrder> placeOrder(AccessToken token, String spaceUuid, String isin, OrderSide side, int quantity,
      {DateTime? validUntil, double? stopPrice, double? limitPrice, String venue = 'XMUN', String? notes}) async {
    if (validUntil == null) {
      validUntil = DateTime.now().add(Duration(days: 29));
    }
    return _tradingClient.placeOrder(token, spaceUuid, isin, validUntil, side, quantity, venue,
        stopPrice: stopPrice, limitPrice: limitPrice, notes: notes);
  }

  Future<TradingResultList<ExistingOrder>> getOrders(AccessToken token,
      {DateTime? createdAtUntil,
      DateTime? createdAtFrom,
      OrderSide? side,
      OrderType? type,
      OrderStatus? status,
      String? spaceUuid,
      String? isin}) async {
    return _tradingClient.getOrders(token,
        type: type,
        spaceUuid: spaceUuid,
        isin: isin,
        createdAtFrom: createdAtFrom,
        createdAtUntil: createdAtUntil,
        status: status,
        side: side);
  }

  Future<TradingResultList<ExistingOrder>> getOrdersByUrl(AccessToken token, String url) async {
    return _tradingClient.getOrdersByUrl(token, url);
  }

  Future<ExistingOrder> getOrder(AccessToken token, String orderUuid) async {
    return _tradingClient.getOrder(token, orderUuid);
  }

  Future<ActivateOrderResponse> activateOrder(AccessToken token, String orderUuid, Map<String, String>? body) async {
    ActivateOrderResponse result = await _tradingClient.activateOrder(token, orderUuid, body);
    return result;
  }

  Future<DeleteOrderResponse> deleteOrder(AccessToken token, String orderUuid) async {
    DeleteOrderResponse result = await _tradingClient.deleteOrder(token, orderUuid);
    return result;
  }

  // Trading -> Portfolio

  Future<List<PortfolioItem>> getPortfolioItems(AccessToken token, {String? spaceUuid, String? isin}) async {
    return _portfolioClient.getPortfolioItems(token, spaceUuid: spaceUuid, isin: isin);
  }

  Future<List<PortfolioItem>> getPortfolioItemsByUrl(AccessToken token, String url) async {
    return _portfolioClient.getPortfolioItemsByUrl(token, url);
  }


  // Trading -> Transactions

  Future<TradingResultList<Transaction>> getTransactions(AccessToken token,
      {String? spaceUuid, DateTime? createdAtFrom, DateTime? createdAtUntil, String? isin}) async {
    return _transactionClient.getTransactions(token, spaceUuid: spaceUuid,
        createdAtFrom: createdAtFrom, createdAtUntil: createdAtUntil, isin: isin);
  }

  Future<TradingResultList<Transaction>> getTransactionsByURL(AccessToken token, String url) async {
    return _transactionClient.getTransactionsByUrl(token, url);
  }

  Future<Transaction> getTransaction(AccessToken token, String transactionUuid) async {
    return _transactionClient.getTransaction(token, transactionUuid);
  }

  // Instruments

  Future<ResultList<Instrument>> searchInstruments(AccessToken token,
      {List<String>? mic,
      List<String>? isin,
      String? search,
      List<SearchType>? types,
      bool? tradable,
      String? currency,
      String? limit,
      int? offset}) async {
    ResultList<Instrument> result = await _searchClient.searchInstruments(token,
        mic: mic,
        isin: isin,
        search: search,
        types: types,
        tradable: tradable,
        currency: currency,
        limit: limit,
        offset: offset);
    return result;
  }

  Future<ResultList<Instrument>> searchInstrumentsByUrl(AccessToken token, String url) async {
    return _searchClient.searchInstrumentsByUrl(token, url);
  }

  // Trading Venues

  Future<ResultList<TradingVenue>> getTradingVenues(AccessToken token, {List<String>? mics}) async {
    return _tradingVenueClient.getTradingVenues(token, mics: mics);
  }

  Future<ResultList<TradingVenue>> getTradingVenuesByUrl(AccessToken token, String url) async {
    return _tradingVenueClient.getTradingVenues(token);
  }

  // Data -> Quotes

  // Epoch parameter not supported yet. Its always true problem: epoch=true results in number and result=false results in string --> type cast problem!
  // type 'int' is not a subtype of type 'String' in type cast
  Future<ResultList<Quote>> getLatestQuote(AccessToken token, List<String> isin,
      {List<String>? mic, bool? decimals, Sorting? sorting}) async {
    return _marketClient.getQuotes(token, isin, mic: mic, sorting: sorting, decimals: decimals, latest: true);
  }

  Future<ResultList<Quote>> getLatestQuoteByUrl(AccessToken token, String url) async {
    return _marketClient.getQuotesByUrl(token, url);
  }

  Future<ResultList<Quote>> getQuotes(AccessToken token, List<String> isin,
      {List<String>? mic, bool? decimals, Sorting? sorting, DateTime? from, DateTime? to}) async {
    return _marketClient.getQuotes(token, isin, mic: mic, sorting: sorting, decimals: decimals, from: from, to: to);
  }

  Future<ResultList<Quote>> getQuotesByUrl(AccessToken token, String url) async {
    return _marketClient.getQuotesByUrl(token, url);
  }

  // Data -> OHLC

  Future<ResultList<OHLC>> getLatestOHLC(AccessToken token, List<String> isin, OHLCType type,
      {List<String>? mic, bool? decimals, Sorting? sorting}) async {
    return _marketClient.getOHLC(token, isin, type, sorting: sorting, mics: mic, decimals: decimals, latest: true);
  }

  Future<ResultList<OHLC>> getOHLC(AccessToken token, List<String> isin, OHLCType type,
      {List<String>? mics, DateTime? from, DateTime? to, Sorting? sorting, bool? decimals}) async {
    return _marketClient.getOHLC(token, isin, type,
        mics: mics, from: from, to: to, sorting: sorting, decimals: decimals);
  }

  Future<ResultList<OHLC>> getOHLCByUrl(AccessToken token, String url) async {
    return _marketClient.getOHLCFromUrl(token, url);
  }

  // Data -> Latest Trades

  Future<ResultList<Trade>> getLatestTrade(AccessToken token, List<String> isin,
      {List<String>? mics, bool? decimals, Sorting? sorting}) async {
    return _marketClient.getTrades(token, isin, sorting: sorting, mics: mics, decimals: decimals, latest: true);
  }

  Future<ResultList<Trade>> getTrades(AccessToken token, List<String> isin,
      {List<String>? mic, bool? decimals, Sorting? sorting, DateTime? from, DateTime? to}) async {
    return _marketClient.getTrades(token, isin, from: from, to: to, decimals: decimals, mics: mic, sorting: sorting);
  }

  Future<ResultList<Trade>> getTradesByUrl(AccessToken token, String url) async {
    return _marketClient.getTradesByUrl(token, url);
  }
}
