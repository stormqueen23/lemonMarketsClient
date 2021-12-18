import 'package:lemon_markets_client/data/amount.dart';

class LemonMarketsAmountConverter {

  static int toAmount(Amount amount) {
    return amount.apiValue;
  }
  ///value = value from api
  static Amount fromAmount(int value) {
    return Amount(apiValue: value);
  }

  static int? toNullableAmount(Amount? amount) {
    if (amount == null) {
      return null;
    }
    return amount.apiValue;
  }

  ///value = value from api
  static Amount? fromNullableAmount(int? value) {
    if (value == null) {
      return null;
    }
    return Amount(apiValue: value);
  }
}