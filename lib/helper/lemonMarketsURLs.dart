import 'package:lemon_markets_client/data/auth/accessToken.dart';

class LemonMarketsURL {

  static String BASE_URL_MARKET = 'https://data.lemon.markets/v1';

  static String BASE_URL_TRADING_PAPER = 'https://paper-trading.lemon.markets/v1';

  static String BASE_URL_TRADING = 'https://trading.lemon.markets/v1';

  static String AUTH_URL = 'https://auth.lemon.markets/oauth2/token';

  static String getTradingUrl(AccessToken token) {
    return token.realMoneyAccess ? BASE_URL_TRADING : BASE_URL_TRADING_PAPER;
  }

}