import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/data/account/account.dart';
import 'package:lemon_markets_client/data/auth/accessToken.dart';
import 'package:lemon_markets_client/data/tradingResult.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/exception/lemonMarketsNoResultException.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';


class LemonMarketsAccount {
  final log = Logger('LemonMarketsAccount');
  LemonMarketsHttpClient _client;

  LemonMarketsAccount(this._client);

  Future<Account> getAccountData(AccessToken token) async {
    String url = LemonMarketsURL.getTradingUrl(token)+'/account';

    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      TradingResult<Account> result = TradingResult<Account>.fromJson(response.decodedBody);
      if (result.result != null) {
        return result.result!;
      } else {
        throw LemonMarketsNoResultException(
            url, 'status: ' + result.status, response.statusCode, response.decodedBody.toString());
      }
    } catch (e, stackTrace) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(
          url, e.toString(), response.statusCode, response.decodedBody.toString(), stackTrace);
    }

  }
}