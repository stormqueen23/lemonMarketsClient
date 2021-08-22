import 'package:lemon_markets_client/data/existingOrder.dart';

class LemonMarketsResultConverter {

  static String? toExistingOrderType(ExistingOrderSide type) {
    if (ExistingOrderSide.sell == type) {
      return 'sell';
    } else if (ExistingOrderSide.buy == type) {
      return 'buy';
    }
    return null;
  }

  static ExistingOrderSide fromExistingOrderType(String typeAsString) {
    if ('sell' == typeAsString) {
        return ExistingOrderSide.sell;
      } else if ('buy' == typeAsString) {
        return ExistingOrderSide.buy;
      }
    return ExistingOrderSide.unknown;
  }

  static double toDouble(String value) {
    return double.parse(value);
  }

  static double? toDoubleNullable(String? value) {
    if (value == null) {
      return null;
    }
    return double.parse(value);
  }

  static int toInt(String value) {
    return int.parse(value);
  }

  static int? toIntNullable(String? value) {
    if (value == null) {
      return null;
    }
    return int.parse(value);
  }
}