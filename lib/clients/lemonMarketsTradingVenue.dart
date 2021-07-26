import 'package:lemon_markets_client/data/accessToken.dart';
import 'package:lemon_markets_client/data/space.dart';
import 'package:lemon_markets_client/data/spaceState.dart';
import 'package:lemon_markets_client/data/stateInfo.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsTradingVenue {
  final log = Logger('LemonMarketsTradingVenue');
  LemonMarketsHttpClient _client;

  LemonMarketsTradingVenue(this._client);

  /// /trading-venues/{mic}/instruments/
  /// /trading-venues/{mic}/instruments/{isin}/
  /// /trading-venues/{mic}/instruments/{isin}/warrants/

  Future<SpaceState> getSpaceState(AccessToken token, String uuid) async {
    String url = LemonMarketsURL.BASE_URL+'/spaces/'+uuid+'/state';
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      SpaceState result = SpaceState.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }


}