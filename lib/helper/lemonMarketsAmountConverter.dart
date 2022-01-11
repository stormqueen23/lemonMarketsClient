import 'package:lemon_markets_client/data/amount.dart';

class LemonMarketsAmountConverter {

  static int toAmount(Amount amount) {
    return amount.apiValue;
  }
  ///value = value from api
  static Amount fromAmount(num value) {
    return Amount(apiValue: value.toInt());
  }

  static int? toNullableAmount(Amount? amount) {
    if (amount == null) {
      return null;
    }
    return amount.apiValue;
  }

  ///value = value from api
  static Amount? fromNullableAmount(num? value) {
    if (value == null) {
      return null;
    }
    return Amount(apiValue: value.toInt());
  }
}