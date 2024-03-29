import 'dart:async';

import 'package:lemon_markets_client/clients/account/lemonMarketsAccount.dart';
import 'package:lemon_markets_client/clients/market/lemonMarketsSearch.dart';
import 'package:lemon_markets_client/clients/market/lemonMarketsTradingVenue.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/clients/market/lemonMarketsMarketData.dart';
import 'package:lemon_markets_client/clients/trading/lemonMarketsPositions.dart';
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

enum TradingPlan { free, go, pro, unknown }
enum DataPlan { free, go, pro, unknown }

enum TransactionType { payIn, payOut, orderBuy, orderSell, dividend, tax, unknown }

enum PositionStatementType { order_buy, order_sell, split, import, snx, unknown }

enum BankStatementType {
  payIn,
  payOut,
  orderBuy,
  orderSell,
  dividend,
  endOfDayBalance,
  tax,
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
  late LemonMarketsHttpClient _client;

  LemonMarkets() {
    _client = LemonMarketsHttpClient();
    _tradingClient = LemonMarketsOrder(_client);
    _marketClient = LemonMarketsMarketData(_client);
    _portfolioClient = LemonMarketsPortfolio(_client);
    _searchClient = LemonMarketsSearch(_client);
    _tradingVenueClient = LemonMarketsTradingVenue(_client);
    _accountClient = LemonMarketsAccount(_client);
  }

  void enableRequestLogging() {
    _client.logRequests = true;
  }

  void disableRequestLogging() {
    _client.logRequests = false;
  }

  void resetRequestLog() {
    _client.requestLog.clear();
  }

  List<RequestLogEntry> getRequestLog() {
    return _client.requestLog;
  }

  void enableRequestCount() {
    _client.countRequests = true;
  }

  void disableRequestCount() {
    _client.countRequests = false;
  }

  void resetMarketRequestCount() {
    _client.requestCounterMarketData = 0;
  }

  int getMarketRequestCount() {
    return _client.requestCounterMarketData;
  }

  void resetTradingRequestCount() {
    _client.requestCounterTrading = 0;
  }

  int getTradingRequestCount() {
    return _client.requestCounterTrading;
  }

  void resetPaperTradingRequestCount() {
    _client.requestCounterPaperTrading = 0;
  }

  int getPaperTradingRequestCount() {
    return _client.requestCounterPaperTrading;
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
      {BankStatementType? type,
      DateTime? from,
      DateTime? to,
      int? limit,
      int? page,
      Sorting? sorting,
      bool? fromBeginning}) async {
    return _accountClient.getBankStatements(token,
        type: type,
        from: from,
        to: to,
        limit: limit,
        page: page,
        sorting: sorting,
        fromBeginning: fromBeginning ?? false);
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
  Future<TradingResult<CreatedOrder>> placeOrder(AccessToken token, String isin, OrderSide side, int quantity,
      {DateTime? validUntil, Amount? stopPrice, Amount? limitPrice, String venue = 'XMUN', String? notes}) async {
    if (validUntil == null) {
      validUntil = DateTime.now().add(Duration(days: 29));
    }
    return _tradingClient.placeOrder(token, isin, validUntil, side, quantity, venue,
        stopPrice: stopPrice, limitPrice: limitPrice, notes: notes);
  }

  Future<TradingResultList<Order>> getOrders(AccessToken token,
      {DateTime? to,
      DateTime? from,
      OrderSide? side,
      OrderType? type,
      List<OrderStatus>? status,
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

  Future<TradingResultList<Order>> getOrdersByUrl(AccessToken token, String url) async {
    return _tradingClient.getOrdersByUrl(token, url);
  }

  Future<TradingResult<Order>> getOrder(AccessToken token, String orderUuid) async {
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

  // Trading -> Positions
  Future<TradingResultList<PositionStatement>> getPositionStatements(AccessToken token,
      {String? isin, int? limit, int? page, List<PositionStatementType>? types}) async {
    return _portfolioClient.getPositionStatements(token, limit: limit, page: page, isin: isin, types: types);
  }

  Future<TradingResultList<PositionStatement>> getPositionStatementsByUrl(AccessToken token, String url) async {
    return _portfolioClient.getPositionStatementsByUrl(token, url);
  }

  Future<TradingResultList<PositionPerformance>> getPositionPerformance(AccessToken token,
      {String? isin, DateTime? from, DateTime? to, Sorting? sorting, int? limit, int? page}) async {
    return _portfolioClient.getPositionPerformance(token, isin: isin, from: from, to: to, limit: limit, page: page);
  }

  Future<TradingResultList<PositionPerformance>> getPositionPerformanceByUrl(AccessToken token, String url) async {
    return _portfolioClient.getPositionPerformanceByUrl(token, url);
  }

  Future<TradingResultList<Position>> getPositions(AccessToken token, {String? isin, int? limit, int? page}) async {
    return _portfolioClient.getPositions(token, isin: isin, limit: limit, page: page);
  }

  Future<TradingResultList<Position>> getPositionsByUrl(AccessToken token, String url) async {
    return _portfolioClient.getPositionsByUrl(token, url);
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

  Future<ResultList<Quote>> getQuotes(AccessToken token, List<String> isin,
      {DateTime? from, DateTime? to, String? mic, bool? decimals, bool epoch = false, Sorting? sorting, int? limit, int? page}) async {
    return _marketClient.getQuotes(token, isin, from: from, to: to, page: page, limit: limit, sorting: sorting, decimals: decimals, epoch: epoch, mic: mic);
  }

  // Epoch parameter not supported yet. Its always true problem: epoch=true results in number and result=false results in string --> type cast problem!
  // type 'int' is not a subtype of type 'String' in type cast
  // also there is no need for this parameter because the date is returned as DateTime
  Future<ResultList<Quote>> getLatestQuote(AccessToken token, List<String> isin,
      {List<String>? mic, bool? decimals, Sorting? sorting, int? limit, int? page}) async {
    return _marketClient.getLatestQuote(token, isin,
        mic: mic, sorting: sorting, decimals: decimals, page: page, limit: limit);
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
    return _marketClient.getLatestTrade(token, isin,
        sorting: sorting, mics: mics, decimals: decimals, page: page, limit: limit);
  }


  Future<ResultList<Trade>> getTrades(AccessToken token, List<String> isin,
      {DateTime? from, DateTime? to, String? mic, bool? decimals, bool epoch = false, Sorting? sorting, int? limit, int? page}) async {
    return _marketClient.getTrades(token, isin, from: from, to: to, page: page, limit: limit, sorting: sorting, decimals: decimals, epoch: epoch, mic: mic);
  }

  Future<ResultList<Trade>> getTradesByUrl(AccessToken token, String url) async {
    return _marketClient.getTradesByUrl(token, url);
  }

}
