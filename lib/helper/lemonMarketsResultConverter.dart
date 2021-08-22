import 'package:lemon_markets_client/src/lemonmarkets.dart';

class LemonMarketsResultConverter {

  static String? toOrderSide(OrderSide type) {
    if (OrderSide.sell == type) {
      return 'sell';
    } else if (OrderSide.buy == type) {
      return 'buy';
    }
    return null;
  }

  static OrderSide fromOrderSide(String typeAsString) {
    if ('sell' == typeAsString) {
        return OrderSide.sell;
      } else if ('buy' == typeAsString) {
        return OrderSide.buy;
      }
    return OrderSide.unknown;
  }

  static String? toOrderStatus(OrderStatus status) {
    if (OrderStatus.inactive == status) {
      return 'inactive';
    } else if (OrderStatus.active == status) {
      return 'active';
    } else if (OrderStatus.in_progress == status) {
      return 'in_progress';
    } else if (OrderStatus.executed == status) {
      return 'executed';
    } else if (OrderStatus.deleted == status) {
      return 'deleted';
    } else if (OrderStatus.expired == status) {
      return 'expired';
    }
    return null;
  }

  static OrderStatus fromOrderStatus(String typeAsString) {
    if ('inactive' == typeAsString) {
      return OrderStatus.inactive;
    } else if ('active' == typeAsString || 'activated' == typeAsString) {
      return OrderStatus.active;
    } else if ('in_progress' == typeAsString) {
      return OrderStatus.in_progress;
    } else if ('executed' == typeAsString) {
      return OrderStatus.executed;
    } else if ('deleted' == typeAsString) {
      return OrderStatus.deleted;
    } else if ('expired' == typeAsString) {
      return OrderStatus.expired;
    }
    return OrderStatus.unknown;
  }

  static String toOrderType(OrderType type) {
    if (OrderType.market == type) {
      return 'market';
    } else if (OrderType.limit == type) {
      return 'limit';
    } else if (OrderType.stopLimit == type) {
      return 'stop_limit';
    } else if (OrderType.stopMarket == type) {
      return 'stop_market';
    }
    return '';
  }

  static OrderType fromOrderType(String typeAsString) {
    if ('market' == typeAsString) {
      return OrderType.market;
    } else if ('limit' == typeAsString) {
      return OrderType.limit;
    } else if ('stop_limit' == typeAsString) {
      return OrderType.stopLimit;
    } else if ('stop_market' == typeAsString) {
      return OrderType.stopMarket;
    }
    return OrderType.unknown;
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