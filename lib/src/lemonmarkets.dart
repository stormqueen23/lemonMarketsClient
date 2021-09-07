import 'dart:async';

import 'package:lemon_markets_client/clients/clientData.dart';
import 'package:lemon_markets_client/clients/lemonMarketsSearch.dart';
import 'package:lemon_markets_client/clients/lemonMarketsTradingVenue.dart';
import 'package:lemon_markets_client/clients/lemonMarketsTransactions.dart';
import 'package:lemon_markets_client/data/accessToken.dart';
import 'package:lemon_markets_client/data/createdOrder.dart';
import 'package:lemon_markets_client/data/existingOrder.dart';
import 'package:lemon_markets_client/data/instrument.dart';
import 'package:lemon_markets_client/data/quote.dart';
import 'package:lemon_markets_client/data/trade.dart';
import 'package:lemon_markets_client/data/ohlc.dart';
import 'package:lemon_markets_client/data/portfolioItem.dart';
import 'package:lemon_markets_client/data/portfolioTransaction.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/data/space.dart';
import 'package:lemon_markets_client/data/spaceState.dart';
import 'package:lemon_markets_client/data/stateInfo.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/clients/lemonMarketsAuth.dart';
import 'package:lemon_markets_client/clients/lemonMarketsMarketData.dart';
import 'package:lemon_markets_client/clients/lemonMarketsPortfolio.dart';
import 'package:lemon_markets_client/clients/lemonMarketsSpaces.dart';
import 'package:lemon_markets_client/clients/lemonMarketsOrder.dart';
import 'package:lemon_markets_client/data/tradingVenue.dart';
import 'package:lemon_markets_client/data/transaction.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:logging/logging.dart';

//Alle, Aktie, Anleihe, Fond, ETF, Optionsschein
enum SearchType { none, stock, bond, fund, etf, warrant }
enum OrderSide { buy, sell, unknown }
enum OrderStatus { inactive, active, in_progress, executed, deleted, expired, unknown }

enum OrderType { limit, market, stopLimit, stop, unknown }
enum OHLCType { m1, h1, d1 }
enum Sorting { newestFirst, oldestFirst }

class LemonMarkets {
  final Logger log = Logger('LemonMarkets');

  late LemonMarketsSpaces _spacesClient;
  late LemonMarketsPortfolio _portfolioClient;
  late LemonMarketsAuth _authClient;
  late LemonMarketsOrder _tradingClient;
  late LemonMarketsMarketData _marketClient;
  late LemonMarketsSearch _searchClient;
  late LemonMarketsTransaction _transactionClient;
  late LemonMarketsTradingVenue _tradingVenueClient;

  LemonMarkets() {
    LemonMarketsHttpClient client = LemonMarketsHttpClient();
    _spacesClient = LemonMarketsSpaces(client);
    _authClient = LemonMarketsAuth(client);
    _tradingClient = LemonMarketsOrder(client);
    _marketClient = LemonMarketsMarketData(client);
    _portfolioClient = LemonMarketsPortfolio(client);
    _searchClient = LemonMarketsSearch(client);
    _transactionClient = LemonMarketsTransaction(client);
    _tradingVenueClient = LemonMarketsTradingVenue(client);
  }

  // Authentication

  Future<AccessToken> requestToken(String clientId, String clientSecret) async {
    AccessToken token = await _authClient.requestToken(clientId, clientSecret);
    return token;
  }

  // State

  Future<StateInfo> getStateInfo(AccessToken token, {int? limit, int? offset}) async {
    return _spacesClient.getStateInfo(token, limit: limit, offset: offset);
  }

  // Spaces -> Spaces

  Future<ResultList<Space>> getSpaces(AccessToken token, {int? limit, int? offset}) async {
    return _spacesClient.getSpaces(token, limit: limit, offset: offset);
  }

  Future<ResultList<Space>> getSpacesByUrl(AccessToken token, String url) async {
    return _spacesClient.getSpacesByUrl(token, url);
  }

  Future<Space> getSpace(AccessToken token, String spaceUuid) async {
    return _spacesClient.getSpace(token, spaceUuid);
  }

  Future<SpaceState> getSpaceState(AccessToken token, String spaceUuid) async {
    return _spacesClient.getSpaceState(token, spaceUuid);
  }

  // Spaces -> Orders

  Future<ResultList<ExistingOrder>> getOrders(AccessToken token, String spaceUuid,
      {DateTime? createdAtUntil, DateTime? createdAtFrom, OrderSide? side, OrderType? type, OrderStatus? status, int? limit, int? offset}) async {
    //isin as query parameter would be nice
    return _tradingClient.getOrders(token, spaceUuid, createdAtUntil, createdAtFrom, side, type, status, limit, offset);
  }

  Future<ResultList<ExistingOrder>> getOrdersByUrl(AccessToken token, String url) async {
    return _tradingClient.getOrdersByUrl(token, url);
  }

  Future<ExistingOrder> getOrder(AccessToken token, String spaceUuid, String orderUuid) async {
    return _tradingClient.getOrder(token, spaceUuid, orderUuid);
  }

  Future<CreatedOrder> placeOrder(AccessToken token, String spaceUuid, String isin, OrderSide side, int quantity,
      {DateTime? validUntil, double? stopPrice, double? limitPrice}) async {
    if (validUntil == null) {
      validUntil = DateTime.now().add(Duration(days: 365));
    }
    CreatedOrder o = await _tradingClient.placeOrder(token, spaceUuid, isin, validUntil, side, quantity, stopPrice: stopPrice, limitPrice: limitPrice);
    return o;
  }

  Future<ActivateOrderResponse> activateOrder(AccessToken token, String spaceUuid, String orderUuid) async {
    ActivateOrderResponse result = await _tradingClient.activateOrder(token, spaceUuid, orderUuid);
    return result;
  }

  Future<DeleteOrderResponse> deleteOrder(AccessToken token, String spaceUuid, String orderUuid) async {
    DeleteOrderResponse result = await _tradingClient.deleteOrder(token, spaceUuid, orderUuid);
    return result;
  }

  // Spaces -> Portfolio

  Future<ResultList<PortfolioItem>> getPortfolioItems(AccessToken token, String spaceUuid) async {
    return _portfolioClient.getPortfolioItems(token, spaceUuid);
  }

  Future<ResultList<PortfolioItem>> getPortfolioItemsByUrl(AccessToken token, String url) async {
    return _portfolioClient.getPortfolioItemsByUrl(token, url);
  }

  Future<ResultList<PortfolioTransaction>> getPortfolioTransactions(AccessToken token, String spaceUuid,
      {DateTime? createdAtFrom, DateTime? createdAtUntil, int? limit, int? offset}) async {
    return _portfolioClient.getPortfolioTransactions(token, spaceUuid,
        createdAtFrom: createdAtFrom, createdAtUntil: createdAtUntil, limit: limit, offset: offset);
  }

  Future<ResultList<PortfolioTransaction>> getPortfolioTransactionsByUrl(AccessToken token, String url) async {
    return _portfolioClient.getPortfolioTransactionsByUrl(token, url);
  }

  // Spaces -> Transactions

  Future<ResultList<Transaction>> getTransactions(AccessToken token, String spaceUuid,
      { DateTime? createdAtFrom, DateTime? createdAtUntil,int? limit, int? offset}) async {
    return _transactionClient.getTransactions(token, spaceUuid, createdAtFrom: createdAtFrom, createdAtUntil: createdAtUntil, limit: limit, offset: offset);
  }

  Future<ResultList<Transaction>> getTransactionsByURL(AccessToken token, String url) async {
    return _transactionClient.getTransactionsByUrl(token, url);
  }

  Future<Transaction> getTransaction(AccessToken token, String spaceUuid, String transactionUuid) async {
    return _transactionClient.getTransaction(token, spaceUuid, transactionUuid);
  }

  // Instruments

  Future<ResultList<Instrument>> searchInstruments(AccessToken token,
      {List<String>? mic, List<String>? isin, String? query, List<SearchType>? types, bool? tradable, String? currency, String? limit, int? offset}) async {
    ResultList<Instrument> result = await _searchClient.searchInstruments(token,
        mic: mic, isin: isin, query: query, types: types, tradable: tradable, currency: currency, limit: limit, offset: offset);
    return result;
  }

  Future<ResultList<Instrument>> searchInstrumentsByUrl(AccessToken token, String url) async {
    ResultList<Instrument> result = await _searchClient.searchInstrumentsByUrl(token, url);
    return result;
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
  Future<ResultList<Quote>> getLatestQuotes(AccessToken token, List<String> isin, {List<String>? mic, bool? decimals, Sorting? sorting}) async {
    return _marketClient.getQuotes(token, isin, mic: mic, sorting: sorting, decimals: decimals, latest: true);
  }

  Future<ResultList<Quote>> getQuotes(AccessToken token, List<String> isin,
      {List<String>? mic, bool? decimals, Sorting? sorting, DateTime? from, DateTime? to}) async {
    return _marketClient.getQuotes(token, isin, mic: mic, sorting: sorting, decimals: decimals, from: from, to: to);
  }

  Future<ResultList<Quote>> getQuotesByUrl(AccessToken token, String url) async {
    return _marketClient.getQuotesByUrl(token, url);
  }

  // Data -> OHLC

  Future<ResultList<OHLC>> getLatestOHLC(AccessToken token, List<String> isin, OHLCType type, {List<String>? mic, bool? decimals, Sorting? sorting}) async {
    return _marketClient.getOHLC(token, isin, type, sorting: sorting, mics: mic, decimals: decimals, latest: true);
  }

  Future<ResultList<OHLC>> getOHLC(AccessToken token, List<String> isin, OHLCType type,
      {List<String>? mics, DateTime? from, DateTime? to, Sorting? sorting, bool? decimals}) async {
    return _marketClient.getOHLC(token, isin, type, mics: mics, from: from, to: to, sorting: sorting, decimals: decimals);
  }

  Future<ResultList<OHLC>> getOHLCByUrl(AccessToken token, String url) async {
    return _marketClient.getOHLCFromUrl(token, url);
  }

  // Data -> Latest Trades

  Future<ResultList<Trade>> getLatestTrade(AccessToken token, List<String> isin, {List<String>? mics, bool? decimals, Sorting? sorting}) async {
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
