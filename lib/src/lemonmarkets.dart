import 'dart:async';

import 'package:lemon_markets_client/clients/clientData.dart';
import 'package:lemon_markets_client/clients/lemonMarketsSearch.dart';
import 'package:lemon_markets_client/clients/lemonMarketsTradingVenue.dart';
import 'package:lemon_markets_client/clients/lemonMarketsTransactions.dart';
import 'package:lemon_markets_client/data/accessToken.dart';
import 'package:lemon_markets_client/data/createdOrder.dart';
import 'package:lemon_markets_client/data/existingOrder.dart';
import 'package:lemon_markets_client/data/instrument.dart';
import 'package:lemon_markets_client/data/latestQuote.dart';
import 'package:lemon_markets_client/data/latestTrade.dart';
import 'package:lemon_markets_client/data/ohlc.dart';
import 'package:lemon_markets_client/data/openingDay.dart';
import 'package:lemon_markets_client/data/portfolioItem.dart';
import 'package:lemon_markets_client/data/portfolioTransaction.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/data/space.dart';
import 'package:lemon_markets_client/data/spaceState.dart';
import 'package:lemon_markets_client/data/stateInfo.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/clients/lemonMarketsAuth.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHistoric.dart';
import 'package:lemon_markets_client/clients/lemonMarketsMarketData.dart';
import 'package:lemon_markets_client/clients/lemonMarketsPortfolio.dart';
import 'package:lemon_markets_client/clients/lemonMarketsSpaces.dart';
import 'package:lemon_markets_client/clients/lemonMarketsTrading.dart';
import 'package:lemon_markets_client/data/tradingVenue.dart';
import 'package:lemon_markets_client/data/transaction.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:logging/logging.dart';

//Alle, Aktie, Anleihe, Fond, ETF, Optionsschein
enum SearchType { none, stock, bond, fund, etf, warrant }
enum OrderSide { buy, sell }
enum OrderStatus { inactive, active, in_progress, executed, deleted, expired }
enum OrderType { limit, market, stopLimit, stopMarket }
enum OHLCType { m1, h1, d1 }

const String defaultMic = 'XMUN';

class LemonMarkets {
  final Logger log = Logger('LemonMarkets');

  late LemonMarketsSpaces _spacesClient;
  late LemonMarketsPortfolio _portfolioClient;
  late LemonMarketsAuth _authClient;
  late LemonMarketsTrading _tradingClient;
  late LemonMarketsMarketData _marketClient;
  late LemonMarketsHistoric _historicClient;
  late LemonMarketsSearch _searchClient;
  late LemonMarketsTransaction _transactionClient;
  late LemonMarketsTradingVenue _tradingVenueClient;

  LemonMarkets() {
    LemonMarketsHttpClient client = LemonMarketsHttpClient();
    _spacesClient = LemonMarketsSpaces(client);
    _authClient = LemonMarketsAuth(client);
    _tradingClient = LemonMarketsTrading(client);
    _marketClient = LemonMarketsMarketData(client);
    _portfolioClient = LemonMarketsPortfolio(client);
    _historicClient = LemonMarketsHistoric(client);
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

  Future<Space> getSpace(AccessToken token, String spaceUuid) async {
    return _spacesClient.getSpace(token, spaceUuid);
  }

  Future<SpaceState> getSpaceState(AccessToken token, String spaceUuid) async {
    return _spacesClient.getSpaceState(token, spaceUuid);
  }

  // Spaces -> Orders

  Future<ResultList<ExistingOrder>> getOrders(AccessToken token, String spaceUuid,
      {int? createdAtUntil, int? createdAtFrom, OrderSide? side, OrderType? type, OrderStatus? status, int? limit, int? offset}) async {
    //isin as query parameter would be nice
    return _tradingClient.getOrders(token, spaceUuid, createdAtUntil, createdAtFrom, side, type, status, limit, offset);
  }

  Future<ExistingOrder> getOrder(AccessToken token, String spaceUuid, String orderUuid) async {
    return _tradingClient.getOrder(token, spaceUuid, orderUuid);
  }

  Future<CreatedOrder> placeOrder(
      AccessToken token, String spaceUuid, String isin, bool sell, int quantity, {double? validUntil, double? stopPrice, double? limitPrice}) async {
    String side = sell ? LemonMarketsURL.SELL_CONST : LemonMarketsURL.BUY_CONST;
    if (validUntil == null) {
      DateTime oneYear = DateTime.now().add(Duration(days: 365));
      validUntil = LemonMarketsTimeConverter.getDoubleTimeForDateTime(oneYear.toUtc());
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

  Future<ResultList<PortfolioTransaction>> getPortfolioTransactions(AccessToken token, String spaceUuid,
      {int? createdAtUntil, int? createdAtFrom, int? limit, int? offset}) async {
    return _portfolioClient.getPortfolioTransactions(token, spaceUuid, createdAtFrom: createdAtFrom, createdAtUntil: createdAtUntil, limit: limit, offset: offset);
  }

  Future<ResultList<PortfolioTransaction>> getPortfolioTransactionsFromUrl(AccessToken token, String url) async {
    return _portfolioClient.getPortfolioTransactionsFromUrl(token, url);
  }

  // Spaces -> Transactions

  Future<ResultList<Transaction>> getTransactionsForSpace(AccessToken token, String spaceUuid,
      {int? createdAtUntil, int? createdAtFrom, int? limit, int? offset}) async {
    return _transactionClient.getTransactionsForSpace(token, spaceUuid, createdAtFrom: createdAtFrom, createdAtUntil: createdAtUntil, limit: limit, offset: offset);
  }

  Future<ResultList<Transaction>> getTransactionsFromURL(AccessToken token, String url) async {
    return _transactionClient.getTransactionsFromUrl(token, url);
  }

  Future<Transaction> getTransactionForSpace(AccessToken token, String spaceUuid, String transactionUuid) async {
    return _transactionClient.getTransactionForSpace(token, spaceUuid, transactionUuid);
  }

  // Instruments

  Future<ResultList<Instrument>> searchInstruments(AccessToken token,
      {String? search, SearchType? type, bool? tradable, String? currency, String? limit, int? offset}) async {
    ResultList<Instrument> result = await _searchClient.searchInstruments(token, search: search, type: type, tradable: tradable, currency: currency, limit: limit, offset: offset);
    return result;
  }

  Future<ResultList<Instrument>> searchInstrumentsByUrl(AccessToken token, String url) async {
    ResultList<Instrument> result = await _searchClient.searchInstrumentsByUrl(token, url);
    return result;
  }

  // Trading Venues

  Future<ResultList<TradingVenue>> getTradingVenues(AccessToken token) async {
    return _tradingVenueClient.getTradingVenues(token);
  }

  Future<ResultList<TradingVenue>> getTradingVenuesByUrl(AccessToken token, String url) async {
    return _tradingVenueClient.getTradingVenues(token);
  }

  Future<TradingVenue> getTradingVenue(AccessToken token, String mic) async {
    return _tradingVenueClient.getTradingVenue(token, mic);
  }

  Future<ResultList<OpeningDay>> getTradingVenueOpeningDays(AccessToken token, String mic) async {
    return _tradingVenueClient.getOpeningDays(token, mic);
  }

  // Trading Venues

  //TODO -> see tradingClient

  Future<ResultList<Instrument>> searchTradingVenueInstruments(AccessToken token,
      {String mic = defaultMic, String? search, SearchType? type, bool? tradable, String? currency, String? limit, int? offset}) async {
    ResultList<Instrument> result = await _searchClient.searchTradingVenueInstruments(token, mic, search: search, type: type, tradable: tradable, currency: currency, limit: limit, offset: offset);
    return result;
  }

  Future<ResultList<Instrument>> searchTradingVenueInstrumentsByUrl(AccessToken token, String url) async {
    ResultList<Instrument> result = await _searchClient.searchTradingVenueInstrumentsByUrl(token, url);
    return result;
  }


  // Data -> Quotes

  Future<LatestQuote> getLatestQuote(AccessToken token, String isin, {String mic = defaultMic}) async {
    return _marketClient.getLatestQuote(token, isin, mic);
  }

  // Data -> OHLC

  Future<ResultList<OHLC>> getOHLC(AccessToken token, String isin, OHLCType type,
    {String mic = defaultMic, DateTime? from, DateTime? until, bool? reverseOrdering}) async {
    return _historicClient.getOHLC(token, isin, mic, type, from, until, reverseOrdering);
  }

  Future<ResultList<OHLC>> getOHLCFromUrl(AccessToken token, String url) async {
    return _historicClient.getOHLCFromUrl(token, url);
  }

  // Data -> Latest Trades

  Future<LatestTrade> getLatestTrade(AccessToken token, String isin, {String mic = defaultMic}) async {
    return _marketClient.getLatestTrade(token, isin, mic);
  }

}
