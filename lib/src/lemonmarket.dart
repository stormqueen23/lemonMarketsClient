import 'dart:async';

import 'package:lemon_market_client/data/accessToken.dart';
import 'package:lemon_market_client/data/createdOrder.dart';
import 'package:lemon_market_client/data/existingOrder.dart';
import 'package:lemon_market_client/data/instrument.dart';
import 'package:lemon_market_client/data/latestQuote.dart';
import 'package:lemon_market_client/data/latestTrade.dart';
import 'package:lemon_market_client/data/ohlc.dart';
import 'package:lemon_market_client/data/portfolioItem.dart';
import 'package:lemon_market_client/data/space.dart';
import 'package:lemon_market_client/data/spaceState.dart';
import 'package:lemon_market_client/data/stateInfo.dart';
import 'package:lemon_market_client/exception/lemonMarketDecodeException.dart';
import 'package:lemon_market_client/exception/lemonMarketJsonException.dart';
import 'package:lemon_market_client/clients/lemonClient.dart';
import 'package:lemon_market_client/clients/lemonmarketAuth.dart';
import 'package:lemon_market_client/clients/lemonmarketHistoric.dart';
import 'package:lemon_market_client/clients/lemonmarketMarketData.dart';
import 'package:lemon_market_client/clients/lemonmarketPortfolio.dart';
import 'package:lemon_market_client/clients/lemonmarketSpaces.dart';
import 'package:lemon_market_client/clients/lemonmarketTrading.dart';
import 'package:lemon_market_client/helper/lemonmarketURLs.dart';
import 'package:logging/logging.dart';

//Alle, Aktie, Anleihe, Fond, ETF, Optionsschein
enum SearchType {NONE, STOCK, BOND, FUND, ETF, WARRANT}
enum OrderSide {BUY, SELL}
enum OrderStatus {inactive, active, in_progress, executed, deleted, expired}
enum OrderType {limit, market, stopLimit, stopMarket}
enum OHLCType {m1, h1, d1}

class LemonMarket {
  final Logger log = Logger('LemonMarket');
  
  late LemonMarketSpaces _spacesClient;
  late LemonMarketPortfolio _portfolioClient;
  late LemonMarketAuth _authClient;
  late LemonMarketTrading _tradingClient;
  late LemonMarketMarketData _marketClient;
  late LemonMarketHistoric _historicClient;

  bool failSilent;

  LemonMarket({this.failSilent = false}) {
    LemonClient client = LemonClient();
    _spacesClient = LemonMarketSpaces(client);
    _authClient = LemonMarketAuth(client);
    _tradingClient = LemonMarketTrading(client);
    _marketClient = LemonMarketMarketData(client);
    _portfolioClient = LemonMarketPortfolio(client);
    _historicClient = LemonMarketHistoric(client);
  }

  Future<AccessToken?> requestToken(String clientId, String clientSecret) async {
    try {
      AccessToken? token = await _authClient.requestToken(clientId, clientSecret);
      return token;
    } on LemonMarketDecodeException catch (e) {
      if (!failSilent) {
        log.warning('LemonMarketException: ${e.cause}');
        rethrow;
      }
    } on LemonMarketJsonException catch (e) {
      if (!failSilent) {
        log.warning('LemonMarketJsonException: ${e.cause}');
        rethrow;
      }
    }
  }

  Future<List<Instrument>> searchInstruments(AccessToken token, String? query, SearchType type) async {
    List<Instrument> result = [];
    try {
      result = await _tradingClient.searchInstruments(token, query, type);
    } on LemonMarketDecodeException catch (e) {
      log.warning('LemonMarketException: ${e.cause}');
    }

    return result;
  }

  Future<CreatedOrder?> placeOrder(AccessToken token, String spaceUuid, String isin, bool sell, int quantity, double? validUntil, double? stopPrice, double? limitPrice) async {
    String side = sell ? LemonMarketURL.SELL_CONST : LemonMarketURL.BUY_CONST;
    if (validUntil == null) {
      DateTime oneYear = DateTime.now().add(Duration(days: 365));
      validUntil = oneYear.toUtc().millisecondsSinceEpoch / 1000;
    }
    try {
      CreatedOrder? o = await _tradingClient.placeOrder(token, spaceUuid, isin, validUntil, side, quantity, stopPrice, limitPrice);
      return o;
    } on LemonMarketDecodeException catch (e) {
      log.warning('LemonMarketDecodeException: ${e.cause}');
    } on LemonMarketJsonException catch (e) {
      log.warning('LemonMarketJsonException: ${e.cause}');
      //TODO rethrow -> if we rethrow the exception must be handled elsewhere

    }
  }

  Future<bool> activateOrder(AccessToken token, String spaceUuid, String orderUuid) async {
    try {
      bool result = await _tradingClient.activateOrder(token, spaceUuid, orderUuid);
      return result;
    } on LemonMarketDecodeException catch (e) {
      log.warning('LemonMarketException: ${e.cause}');
      return false;
    }
  }

  Future<bool> deleteOrder(AccessToken token, String spaceUuid, String orderUuid) async {
    try {
      bool result = await _tradingClient.deleteOrder(token, spaceUuid, orderUuid);
      return result;
    } on LemonMarketDecodeException catch (e) {
      log.warning('LemonMarketException: ${e.cause}');
      return false;
    }
  }

  Future <List<ExistingOrder>> getAllOrders(AccessToken token, String spaceUuid) async {
    return _tradingClient.getAllOrders(token, spaceUuid);
  }

  Future <List<ExistingOrder>> getOrders(AccessToken token, String spaceUuid, OrderSide side, OrderStatus status) async {
    //isin as query parameter would be nice
    return _tradingClient.getAllOrders(token, spaceUuid);
  }

  Future<LatestTrade?> getLatestTrade(AccessToken token, String isin) async {
    String mic = 'XMUN';
    return _marketClient.getLatestTrade(token, isin, mic);
  }

  Future<LatestQuote?> getLatestQuote(AccessToken token, String isin) async {
    String mic = 'XMUN';
    return _marketClient.getLatestQuote(token, isin, mic);
  }

  Future<List<Space>> getSpaces(AccessToken token) async {
    return _spacesClient.getSpaces(token);
  }

  Future<Space?> getSpace(AccessToken token, String spaceUuid) async {
    return _spacesClient.getSpace(token, spaceUuid);
  }

  Future<SpaceState?> getSpaceState(AccessToken token, String spaceUuid) async {
    return _spacesClient.getSpaceState(token, spaceUuid);
  }

  Future<StateInfo?> getSpaceInfo(AccessToken token) async {
    return _spacesClient.getSpaceInfo(token);
  }

  Future<List<PortfolioItem>> getPortfolioItems(AccessToken token, String spaceUuid) async {
    return _portfolioClient.getPortfolioItems(token, spaceUuid);
  }

  Future<List<OHLC>> getOHLC(AccessToken token, String isin, OHLCType type, DateTime? from, DateTime? until, bool? reverseOrdering) async {
    String mic = 'XMUN';
    return _historicClient.getOHLC(token, isin, mic, type, from, until, reverseOrdering);
  }
}