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
      if ('sell'.compareTo(typeAsString) == 0) {
        return ExistingOrderSide.sell;
      } else if ('buy'.compareTo(typeAsString) == 0) {
        return ExistingOrderSide.buy;
      }
    return ExistingOrderSide.unknown;
  }

}