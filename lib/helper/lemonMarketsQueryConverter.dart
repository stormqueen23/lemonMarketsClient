import 'package:lemon_markets_client/src/lemonmarkets.dart';

class LemonMarketsQueryConverter {

  static String? convertOHLCType(OHLCType type) {
    if (OHLCType.d1 == type) {
      return 'd1';
    } else if (OHLCType.h1 == type) {
      return 'h1';
    } else if (OHLCType.m1 == type) {
      return 'm1';
    }
  }

  static String? convertSideForSearch(OrderSide value) {
    if (OrderSide.buy == value) {
      return 'buy';
    } else if (OrderSide.sell == value) {
      return 'sell';
    }
    return null;
  }

  static String? convertSideForExecution(OrderSide value) {
    if (OrderSide.buy == value) {
      return 'buy';
    } else if (OrderSide.sell == value) {
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
    } else if (OrderType.stop == value) {
      return 'stop';
    }
    return null;
  }

  static String? convertOrderStatus(OrderStatus value) {
    if (OrderStatus.activated == value) {
      return 'activated';
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
      case SearchType.bond:
        result = "bond";
        break;
      case SearchType.etf:
        result = "ETF";
        break;
      case SearchType.fund:
        result = "fund";
        break;
      case SearchType.stock:
        result = "stock";
        break;
      case SearchType.warrant:
        result = "warrant";
        break;
      case SearchType.none:
        result = "";
        break;
    }
    return result;
  }

  static String convertSorting(Sorting sorting) {
    String result = "asc";
    switch (sorting) {
      case Sorting.newestFirst:
        result = "desc";
        break;
      case Sorting.oldestFirst:
        result = "asc";
        break;
    }
    return result;
  }
}