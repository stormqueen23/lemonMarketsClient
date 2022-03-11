import 'dart:async';

import 'package:lemon_markets_client/clients/account/lemonMarketsAccount.dart';
import 'package:lemon_markets_client/clients/market/lemonMarketsSearch.dart';
import 'package:lemon_markets_client/clients/market/lemonMarketsTradingVenue.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/clients/market/lemonMarketsMarketData.dart';
import 'package:lemon_markets_client/clients/trading/lemonMarketsPortfolio.dart';
import 'package:lemon_markets_client/clients/trading/lemonMarketsOrder.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:logging/logging.dart';

//Alle, Aktie, Anleihe, Fond, ETF, Optionsschein
enum SearchType { none, stock, bond, fund, etf, warrant }

enum OrderSide { buy, sell, unknown }
enum OrderStatus { inactive, activated, open, in_progress, executed, expired, cancelling, cancelled, unknown }
enum OrderType { limit, market, stopLimit, stop, unknown }

enum OHLCType { m1, h1, d1 }

enum Sorting { newestFirst, oldestFirst }

enum AccountMode { paper, money }

enum TradingPlan { free, basic, pro }
enum DataPlan { free, basic, pro }

enum TransactionType { payIn, payOut, orderBuy, orderSell, dividend, tax, unknown }

enum BankStatementType {
  payIn,
  payOut,
  orderBuy,
  orderSell,
  dividend,
  endOfDayBalance,
  interestPaid,
  interestEarned,
  unknown
}

class LemonMarkets {
  final Logger log = Logger('LemonMarkets');

  late LemonMarketsPortfolio _portfolioClient;
  late LemonMarketsOrder _tradingClient;
  late LemonMarketsMarketData _marketClient;
  late LemonMarketsSearch _searchClient;
  late LemonMarketsTradingVenue _tradingVenueClient;
  late LemonMarketsAccount _accountClient;

  LemonMarkets() {
    LemonMarketsHttpClient client = LemonMarketsHttpClient();
    _tradingClient = LemonMarketsOrder(client);
    _marketClient = LemonMarketsMarketData(client);
    _portfolioClient = LemonMarketsPortfolio(client);
    _searchClient = LemonMarketsSearch(client);
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

  Future<TradingResult<Account>> getAccountData(AccessToken token) async {
    return _accountClient.getAccountData(token);
  }

  Future<TradingResultList<BankStatement>> getBankStatements(AccessToken token,
      {BankStatementType? type, DateTime? from, DateTime? to, int? limit, int? page}) async {
    return _accountClient.getBankStatements(token, type: type, from: from, to: to, limit: limit, page: page);
  }

  Future<TradingResultList<BankStatement>> getBankStatementsByUrl(AccessToken token, String url) async {
    return _accountClient.getBankStatementsByUrl(token, url);
  }

  Future<TradingResultList<Document>> getDocuments(AccessToken token) async {
    return _accountClient.getDocuments(token);
  }

  Future<TradingResultList<Document>> getDocumentByUrl(AccessToken token, String url) async {
    return _accountClient.getDocumentsByUrl(token, url);
  }

  // Trading -> Orders

  Future<TradingResult<CreatedOrder>> placeOrder(
      AccessToken token, String isin, OrderSide side, int quantity,
      {DateTime? validUntil, Amount? stopPrice, Amount? limitPrice, String venue = 'XMUN', String? notes}) async {
    if (validUntil == null) {
      validUntil = DateTime.now().add(Duration(days: 29));
    }
    return _tradingClient.placeOrder(token, isin, validUntil, side, quantity, venue,
        stopPrice: stopPrice, limitPrice: limitPrice, notes: notes);
  }

  Future<TradingResultList<ExistingOrder>> getOrders(AccessToken token,
      {DateTime? to,
      DateTime? from,
      OrderSide? side,
      OrderType? type,
      OrderStatus? status,
      int? limit,
      int? page,
      String? isin}) async {
    return _tradingClient.getOrders(token,
        type: type,
        isin: isin,
        createdAtFrom: from,
        createdAtUntil: to,
        status: status,
        side: side,
        page: page,
        limit: limit);
  }

  Future<TradingResultList<ExistingOrder>> getOrdersByUrl(AccessToken token, String url) async {
    return _tradingClient.getOrdersByUrl(token, url);
  }

  Future<TradingResult<ExistingOrder>> getOrder(AccessToken token, String orderUuid) async {
    return _tradingClient.getOrder(token, orderUuid);
  }

  Future<ActivateOrderResult> activateOrder(AccessToken token, String orderUuid, String? pin) async {
    ActivateOrderResult result = await _tradingClient.activateOrder(token, orderUuid, pin);
    return result;
  }

  Future<DeleteOrderResult> deleteOrder(AccessToken token, String orderUuid) async {
    DeleteOrderResult result = await _tradingClient.deleteOrder(token, orderUuid);
    return result;
  }

  // Trading -> Portfolio

  Future<TradingResultList<PortfolioItem>> getPortfolioItems(AccessToken token,
      {String? isin, int? limit, int? page}) async {
    return _portfolioClient.getPortfolioItems(token, isin: isin, limit: limit, page: page);
  }

  Future<TradingResultList<PortfolioItem>> getPortfolioItemsByUrl(AccessToken token, String url) async {
    return _portfolioClient.getPortfolioItemsByUrl(token, url);
  }

  // Instruments

  Future<ResultList<Instrument>> searchInstruments(AccessToken token,
      {List<String>? mic,
      List<String>? isin,
      String? search,
      List<SearchType>? types,
      bool? tradable,
      String? currency,
      int? limit,
      int? page}) async {
    ResultList<Instrument> result = await _searchClient.searchInstruments(token,
        mic: mic,
        isin: isin,
        search: search,
        types: types,
        tradable: tradable,
        currency: currency,
        limit: limit,
        page: page);
    return result;
  }

  Future<ResultList<Instrument>> searchInstrumentsByUrl(AccessToken token, String url) async {
    return _searchClient.searchInstrumentsByUrl(token, url);
  }

  // Trading Venues

  Future<ResultList<TradingVenue>> getTradingVenues(AccessToken token,
      {List<String>? mics, int? limit, int? page}) async {
    return _tradingVenueClient.getTradingVenues(token, mics: mics, page: page, limit: limit);
  }

  Future<ResultList<TradingVenue>> getTradingVenuesByUrl(AccessToken token, String url) async {
    return _tradingVenueClient.getTradingVenues(token);
  }

  // Data -> Quotes

  // Epoch parameter not supported yet. Its always true problem: epoch=true results in number and result=false results in string --> type cast problem!
  // type 'int' is not a subtype of type 'String' in type cast
  Future<ResultList<Quote>> getLatestQuote(AccessToken token, List<String> isin,
      {List<String>? mic, bool? decimals, Sorting? sorting, int? limit, int? page}) async {
    return _marketClient.getQuotes(token, isin,
        mic: mic, sorting: sorting, decimals: decimals, latest: true, page: page, limit: limit);
  }

  Future<ResultList<Quote>> getLatestQuoteByUrl(AccessToken token, String url) async {
    return _marketClient.getQuotesByUrl(token, url);
  }

  Future<ResultList<Quote>> getQuotes(AccessToken token, List<String> isin,
      {List<String>? mic,
      bool? decimals,
      Sorting? sorting,
      DateTime? from,
      DateTime? to,
      int? limit,
      int? page}) async {
    return _marketClient.getQuotes(token, isin,
        mic: mic, sorting: sorting, decimals: decimals, from: from, to: to, limit: limit, page: page);
  }

  Future<ResultList<Quote>> getQuotesByUrl(AccessToken token, String url) async {
    return _marketClient.getQuotesByUrl(token, url);
  }

  // Data -> OHLC

  Future<ResultList<OHLC>> getLatestOHLC(AccessToken token, List<String> isin, OHLCType type,
      {List<String>? mic, bool? decimals, Sorting? sorting, int? limit, int? page}) async {
    return _marketClient.getOHLC(token, isin, type,
        sorting: sorting, mics: mic, decimals: decimals, latest: true, page: page, limit: limit);
  }

  Future<ResultList<OHLC>> getOHLC(AccessToken token, List<String> isin, OHLCType type,
      {List<String>? mics,
      DateTime? from,
      DateTime? to,
      Sorting? sorting,
      bool? decimals,
      int? limit,
      int? page}) async {
    return _marketClient.getOHLC(token, isin, type,
        mics: mics, from: from, to: to, sorting: sorting, decimals: decimals, limit: limit, page: page);
  }

  Future<ResultList<OHLC>> getOHLCByUrl(AccessToken token, String url) async {
    return _marketClient.getOHLCByUrl(token, url);
  }

  // Data -> Latest Trades

  Future<ResultList<Trade>> getLatestTrade(AccessToken token, List<String> isin,
      {List<String>? mics, bool? decimals, Sorting? sorting, int? limit, int? page}) async {
    return _marketClient.getTrades(token, isin,
        sorting: sorting, mics: mics, decimals: decimals, latest: true, page: page, limit: limit);
  }

  Future<ResultList<Trade>> getTrades(AccessToken token, List<String> isin,
      {List<String>? mic,
      bool? decimals,
      Sorting? sorting,
      DateTime? from,
      DateTime? to,
      int? limit,
      int? page}) async {
    return _marketClient.getTrades(token, isin,
        from: from, to: to, decimals: decimals, mics: mic, sorting: sorting, page: page, limit: limit);
  }

  Future<ResultList<Trade>> getTradesByUrl(AccessToken token, String url) async {
    return _marketClient.getTradesByUrl(token, url);
  }
}
