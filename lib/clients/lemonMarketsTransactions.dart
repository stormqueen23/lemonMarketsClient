import 'package:lemon_markets_client/data/accessToken.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/data/transaction.dart';
import 'package:lemon_markets_client/data/transactionList.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsTransaction {
  final log = Logger('LemonMarketsTransaction');
  LemonMarketsHttpClient _client;

  LemonMarketsTransaction(this._client);

  Future<TransactionList> getTransactionsForSpace(AccessToken token, String spaceUuid,
      {int? createdAtUntil, int? createdAtFrom, int? limit, int? offset}) async {
    String url = LemonMarketsURL.BASE_URL+'/spaces/'+spaceUuid+'/transactions/';
    //TODO: create query params
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TransactionList result = TransactionList.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }

  Future<Transaction> getTransactionForSpace(AccessToken token, String spaceUuid, String transactionUuid) async {
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
}