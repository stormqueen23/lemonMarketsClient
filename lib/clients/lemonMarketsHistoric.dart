import 'package:lemon_markets_client/data/accessToken.dart';
import 'package:lemon_markets_client/data/ohlcList.dart';
import 'package:lemon_markets_client/exception/lemonMarketsConvertException.dart';
import 'package:lemon_markets_client/clients/lemonMarketsHttpClient.dart';
import 'package:lemon_markets_client/helper/lemonMarketsConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';
import 'package:lemon_markets_client/helper/lemonMarketsURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketsHistoric {
  final log = Logger('LemonMarketsHistoric');
  LemonMarketsHttpClient _client;

  LemonMarketsHistoric(this._client);

  Future<OHLCList> getOHLCFromUrl(AccessToken token, String url) async {
    LemonMarketsClientResponse response = await _client.sendGet(url, token);
    try {
      OHLCList result = OHLCList.fromJson(response.decodedBody);
      return result;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketsConvertException(url, e.toString(), response.statusCode, response.decodedBody.toString());
    }

  }

  Future<OHLCList> getOHLC(AccessToken token, String isin, String mic, OHLCType type, DateTime? from, DateTime? until, bool? reverseOrdering) async {
    List<String> queryParamList = _getOHLCQueryParams(from, until, reverseOrdering);
    String query = LemonMarketsHttpClient.generateQueryParams(queryParamList);

    String typeAsString = LemonMarketsConverter.convertOHLCType(type) ?? 'h1';
    String url = LemonMarketsURL.BASE_URL +
        '/trading-venues/' + mic + '/instruments/' + isin + '/data/ohlc/'+typeAsString+'/'+query;

    return getOHLCFromUrl(token, url);
  }

  List<String> _getOHLCQueryParams(DateTime? from, DateTime? until, bool? reverseOrdering) {
    List<String> result = [];
    if (from != null) {
      double value = LemonMarketsTimeConverter.getDoubleTimeForDateTime(from);
      result.add('date_from='+value.toString());
    }
    if (until != null) {
      double value = LemonMarketsTimeConverter.getDoubleTimeForDateTime(until);
      result.add('date_until='+value.toString());
    }
    if (reverseOrdering != null) {
      if (reverseOrdering) {
        result.add('ordering=date');// oldest -> newest
      } else {
        result.add('ordering=-date');
      }
    }
    return result;
  }
}
