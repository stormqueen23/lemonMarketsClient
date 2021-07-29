import 'package:lemon_markets_client/data/accessToken.dart';
import 'package:lemon_markets_client/data/portfolioItem.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsPortfolio {
  final log = Logger('LemonMarketsPortfolio');
  LemonMarketsHttpClient _client;

  LemonMarketsPortfolio(this._client);

  Future<ResultList<PortfolioItem>> getPortfolioItems(AccessToken token, String spaceUuid) async {
    String url = LemonMarketsURL.BASE_URL+'/spaces/'+spaceUuid+'/portfolio/';
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      ResultList<PortfolioItem> result = ResultList<PortfolioItem>.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }

  //TODO: /spaces/{space_uuid}/portfolio/transactions/
}