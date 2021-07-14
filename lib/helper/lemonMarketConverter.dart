import 'package:lemon_market_client/src/lemonmarket.dart';

class LemonMarketConverter {

  static String? convertOHLCType(OHLCType type) {
    if (OHLCType.d1 == type) {
      return 'd1';
    } else if (OHLCType.h1 == type) {
      return 'h1';
    } else if (OHLCType.m1 == type) {
      return 'm1';
    }
  }

  static String? convertSide(OrderSide value) {
    if (OrderSide.BUY == value) {
      return 'buy';
    } else if (OrderSide.SELL == value) {
      return 'sell';
    }
    return null;
  }

  static String? convertOrderType(OrderType value) {
    if (OrderType.market == value) {
      return 'market';
    } else if (OrderType.limit == value) {
      return 'limit';
    } else if (OrderType.stopLimit == value) {
      return 'stop_limit';
    } else if (OrderType.stopMarket == value) {
      return 'stop_market';
    }
    return null;
  }

  static String? convertOrderStatus(OrderStatus value) {
    if (OrderStatus.active == value) {
      return 'active'; //activated?
    } else if (OrderStatus.inactive == value) {
      return 'inactive';
    } else if (OrderStatus.in_progress == value) {
      return 'in_progress';
    } else if (OrderStatus.executed == value) {
      return 'executed';
    } else if (OrderStatus.expired == value) {
      return 'expired';
    } else if (OrderStatus.deleted == value) {
      return 'deleted';
    }
    return null;
  }

  static String convertSearchType(SearchType type) {
    String result = "";
    switch (type) {
      case SearchType.BOND:
        result = "bond";
        break;
      case SearchType.ETF:
        result = "ETF";
        break;
      case SearchType.FUND:
        result = "fund";
        break;
      case SearchType.STOCK:
        result = "stock";
        break;
      case SearchType.WARRANT:
        result = "warrant";
        break;
      case SearchType.NONE:
        result = "";
        break;
    }
    return result;
  }
}