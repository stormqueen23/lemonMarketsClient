import 'package:lemon_market_client/data/accessToken.dart';
import 'package:lemon_market_client/data/ohlc.dart';
import 'package:lemon_market_client/exception/lemonMarketDecodeException.dart';
import 'package:lemon_market_client/exception/lemonMarketJsonException.dart';
import 'package:lemon_market_client/clients/lemonClient.dart';
import 'package:lemon_market_client/helper/lemonMarketConverter.dart';
import 'package:lemon_market_client/helper/lemonMarketTimeConverter.dart';
import 'package:lemon_market_client/src/lemonmarket.dart';
import 'package:lemon_market_client/helper/lemonmarketURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketHistoric {
  final log = Logger('LemonMarketHistoric');
  LemonClient _client;

  LemonMarketHistoric(this._client);

  Future<List<OHLC>> getOHLC(AccessToken token, String isin, String mic, OHLCType type, DateTime? from, DateTime? until, bool? reverseOrdering) async {
    List<OHLC> result = [];

    List<String> queryParamList = _getOHLCQueryParams(from, until, reverseOrdering);
    String query = LemonClient.generateQueryParams(queryParamList);

    String typeAsString = LemonMarketConverter.convertOHLCType(type) ?? 'h1';
    String url = LemonMarketURL.BASE_URL +
        '/trading-venues/' + mic + '/instruments/' + isin + '/data/ohlc/'+typeAsString+'/'+query;

    Map<String, dynamic> decoded = {};
    try {
      decoded = await _client.sendGet(url, token);
      List<dynamic> all = decoded['results'];
      all.forEach((element) {
        OHLC i = OHLC.fromJson(element);
        result.add(i);
      });
    } on LemonMarketDecodeException {
      rethrow;
    } catch (e) {
      log.warning(e.toString());
      throw LemonMarketJsonException(url, "", e.toString(), decoded.toString());
    }
    return result;
  }

  List<String> _getOHLCQueryParams(DateTime? from, DateTime? until, bool? reverseOrdering) {
    List<String> result = [];
    if (from != null) {
      double value = LemonMarketTimeConverter.getDoubleTimeForDateTime(from);
      result.add('date_from='+value.toString());
    }
    if (until != null) {
      double value = LemonMarketTimeConverter.getDoubleTimeForDateTime(until);
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
