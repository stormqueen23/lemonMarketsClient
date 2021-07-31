import 'package:lemon_markets_client/data/accessToken.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/data/transaction.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsTransaction {
  final log = Logger('LemonMarketsTransaction');
  LemonMarketsHttpClient _client;

  LemonMarketsTransaction(this._client);

  Future<ResultList<Transaction>> getTransactions(AccessToken token, String spaceUuid,
      {int? createdAtUntil, int? createdAtFrom, int? limit, int? offset}) async {
    String url = LemonMarketsURL.BASE_URL+'/spaces/'+spaceUuid+'/transactions/';
    String append = _generateParamString(createdAtUntil: createdAtUntil, createdAtFrom: createdAtFrom, limit: limit, offset: offset);
    url += append;
    return getTransactionsByUrl(token, url);
  }

  Future<Transaction> getTransaction(AccessToken token, String spaceUuid, String transactionUuid) async {
    String url = LemonMarketsURL.BASE_URL+'/spaces/'+spaceUuid+'/transactions/'+transactionUuid+'/';
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      Transaction result = Transaction.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }

  Future<ResultList<Transaction>> getTransactionsByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ResultList<Transaction> result = ResultList<Transaction>.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }

  String _generateParamString({int? createdAtUntil, int? createdAtFrom, int? limit, int? offset}) {
    List<String> query = [];
    if (createdAtUntil != null) {
      query.add("created_at_until="+createdAtUntil.toString());
    }
    if (createdAtFrom != null) {
      query.add("created_at_from="+createdAtFrom.toString());
    }
    if (limit != null) {
      query.add("limit="+limit.toString());
    }
    if (offset != null) {
      query.add("offset="+offset.toString());
    }
    String result = LemonMarketsHttpClient.generateQueryParams(query);
    return result;
  }
}