import 'package:lemon_market_client/data/accessToken.dart';
import 'package:lemon_market_client/data/portfolioItem.dart';
import 'package:lemon_market_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_market_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_market_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsPortfolio {
  final log = Logger('LemonMarketsPortfolio');
  LemonMarketsHttpClient _client;

  LemonMarketsPortfolio(this._client);

  Future<List<PortfolioItem>> getPortfolioItems(AccessToken token, String spaceUuid) async {
    String url = LemonMarketsURL.BASE_URL+'/spaces/'+spaceUuid+'/portfolio/';
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      //TODO: ListWrapper for results with next&previous -> see OHLCList
      List<PortfolioItem> result = [];
      List<dynamic> all = response.decodedBody['results'];
      all.forEach((element) {
        PortfolioItem i = PortfolioItem.fromJson(element);
        result.add(i);
      });
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }
  }

}