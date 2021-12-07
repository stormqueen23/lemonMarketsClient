import 'package:lemon_markets_client/data/auth/accessToken.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/data/tradingResult.dart';
import 'package:lemon_markets_client/data/tradingResultList.dart';
import 'package:lemon_markets_client/data/trading/transaction.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/exception/lemonMarketsNoResultException.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsTransaction {
  final log = Logger('LemonMarketsTransaction');
  LemonMarketsHttpClient _client;

  LemonMarketsTransaction(this._client);

  Future<TradingResultList<Transaction>> getTransactions(AccessToken token,
      {String? spaceUuid, DateTime? createdAtUntil, DateTime? createdAtFrom, String? isin}) async {
    String url = LemonMarketsURL.getTradingUrl(token) + '/transactions/';
    String append = _generateParamString(createdAtUntil: createdAtUntil, createdAtFrom: createdAtFrom, spaceUuid: spaceUuid, isin: isin);
    url += append;
    return getTransactionsByUrl(token, url);
  }

  Future<Transaction> getTransaction(AccessToken token, String transactionUuid) async {
    String url = LemonMarketsURL.getTradingUrl(token) + '/transactions/' + transactionUuid+'/';
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingResult<Transaction> result = TradingResult<Transaction>.fromJson(response.decodedBody);
      if (result.status == "ok" && result.result != null) {
        return result.result!;
      }
      throw LemonMarketsNoResultException(
          url, 'status: ' + result.status, response.statusCode, response.decodedBody.toString());
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<TradingResultList<Transaction>> getTransactionsByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingResultList<Transaction> result = TradingResultList<Transaction>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  String _generateParamString({DateTime? createdAtUntil, DateTime? createdAtFrom, String? spaceUuid, String? isin}) {
    List<String> query = [];
    if (createdAtUntil != null) {
      query.add("created_at_until="+LemonMarketsTimeConverter.toIsoTime(createdAtUntil).toString());
    }
    if (createdAtFrom != null) {
      query.add("created_at_from="+LemonMarketsTimeConverter.toIsoTime(createdAtFrom).toString());
    }
    if (spaceUuid != null) {
      query.add("space_id="+spaceUuid);
    }
    if (isin != null) {
      query.add("isin="+isin);
    }
    //query.add("type=order_buy");
    String result = LemonMarketsHttpClient.generateQueryParams(query);
    return result;
  }
}