import 'package:lemon_market_client/data/accessToken.dart';
import 'package:lemon_market_client/data/portfolioItem.dart';
import 'package:lemon_market_client/clients/lemonClient.dart';
import 'package:lemon_market_client/helper/lemonmarketURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketPortfolio {
  final log = Logger('LemonMarketPortfolio');
  LemonClient _client;

  LemonMarketPortfolio(this._client);

  Future<List<PortfolioItem>> getPortfolioItems(AccessToken token, String spaceUuid) async {
    List<PortfolioItem> result = [];
    String url = LemonMarketURL.BASE_URL+'/spaces/'+spaceUuid+'/portfolio/';
    try {
      Map<String, dynamic> decoded = await _client.sendGet(url, token);
      List<dynamic> all = decoded['results'];
      all.forEach((element) {
        PortfolioItem i = PortfolioItem.fromJson(element);
        result.add(i);
      });
    } catch (e) {
      log.warning(e.toString());
    }
    return result;
  }

}