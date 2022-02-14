import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/helper/lemonMarketsQueryConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:logging/logging.dart';

class LemonMarketsAccount {
  final log = Logger('LemonMarketsAccount');
  LemonMarketsHttpClient _client;

  LemonMarketsAccount(this._client);

  Future<TradingResult<Account>> getAccountData(AccessToken token) async {
    String url = LemonMarketsURL.getTradingUrl(token) + '/account';

    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingResult<Account> result = TradingResult<Account>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(
          url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<TradingResultList<BankStatement>> getBankStatements(AccessToken token,
      {BankStatementType? type, DateTime? from, DateTime? to, int? limit, int? page}) async {
    String url = LemonMarketsURL.getTradingUrl(token) + '/account/bankstatements/';
    List<String> result = [];
    if (type != null) {
      result.add('type='+LemonMarketsQueryConverter.convertBankStatementType(type));
    }
    if (from != null) {
      result.add('from='+LemonMarketsTimeConverter.toIsoDay(from));
    }
    if (to != null) {
      result.add('to='+LemonMarketsTimeConverter.toIsoDay(to));
    }
    if (page != null) {
      result.add("page="+page.toString());
    }
    if (limit != null) {
      result.add("limit="+limit.toString());
    }
    String query = LemonMarketsHttpClient.generateQueryParams(result);
    url = url+query;
    return getBankStatementsByUrl(token, url);
  }

  Future<TradingResultList<BankStatement>> getBankStatementsByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingResultList<BankStatement> result = TradingResultList<BankStatement>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(
          url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

  Future<TradingResultList<Document>> getDocuments(AccessToken token) async {
    String url = LemonMarketsURL.getTradingUrl(token) + '/account/documents/';
    return getDocumentsByUrl(token, url);
  }

  Future<TradingResultList<Document>> getDocumentsByUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingResultList<Document> result = TradingResultList<Document>.fromJson(response.decodedBody);
      return result;
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(
          url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }
  }

}
