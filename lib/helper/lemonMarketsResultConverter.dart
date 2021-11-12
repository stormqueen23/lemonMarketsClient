import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';

class LemonMarketsResultConverter {

  static String tDividend = 'dividend';
  static String tOrderBuy = 'order_buy';
  static String tOrderSell = 'order_sell';
  static String tPayIn = 'pay_in';
  static String tPayOut = 'pay_out';
  static String tTax = 'tax';

  static String? toTransactionType(TransactionType type) {
    if (TransactionType.dividend == type) {
      return tDividend;
    } else if (TransactionType.orderBuy == type) {
      return tOrderBuy;
    } else if (TransactionType.orderSell == type) {
      return tOrderSell;
    } else if (TransactionType.payIn == type) {
      return tPayIn;
    } else if (TransactionType.payOut == type) {
      return tPayOut;
    } else if (TransactionType.tax == type) {
      return tTax;
    }
    return null;
  }

  static TransactionType fromTransactionType(String typeAsString) {
    if (tDividend == typeAsString) {
      return TransactionType.dividend;
    } else if (tOrderBuy == typeAsString) {
      return TransactionType.orderBuy;
    } else if (tOrderSell == typeAsString) {
      return TransactionType.orderSell;
    } else if (tPayIn == typeAsString) {
      return TransactionType.payIn;
    } else if (tPayOut == typeAsString) {
      return TransactionType.payOut;
    } else if (tTax == typeAsString) {
      return TransactionType.tax;
    }
    return TransactionType.unknown;
  }

  static String aPaper = 'paper';
  static String aMoney = 'money';

  static String? toAccountMode(AccountMode mode) {
    if (AccountMode.paper == mode) {
      return aPaper;
    } else if (AccountMode.money == mode) {
      return aMoney;
    }
    return null;
  }

  static AccountMode fromAccountMode(String modeAsString) {
    if (aPaper == modeAsString) {
      return AccountMode.paper;
    } else if (aMoney == modeAsString) {
      return AccountMode.money;
    }
    throw LemonMarketsException('', 'cannot map accountMode $modeAsString', null, modeAsString, null);
  }

  static String aTradingFree = 'free';
  static String aTradingBasic = 'basic';
  static String aTradingPro = 'pro';

  static String? toAccountTradingPlan(TradingPlan mode) {
    if (TradingPlan.free == mode) {
      return aTradingFree;
    } else if (TradingPlan.basic == mode) {
      return aTradingBasic;
    } else if (TradingPlan.pro == mode) {
      return aTradingPro;
    }
    return null;
  }

  static TradingPlan fromAccountTradingPlan(String modeAsString) {
    if (aTradingFree == modeAsString) {
      return TradingPlan.free;
    } else if (aTradingBasic == modeAsString) {
      return TradingPlan.basic;
    } else if (aTradingPro == modeAsString) {
      return TradingPlan.pro;
    }
    throw LemonMarketsException('', 'cannot map tradingPlan $modeAsString', null, modeAsString, null);
  }

  static String aDataFree = 'free';
  static String aDataBasic = 'basic';
  static String aDataPro = 'pro';

  static String? toAccountDataPlan(DataPlan mode) {
    if (DataPlan.free == mode) {
      return aDataFree;
    } else if (DataPlan.basic == mode) {
      return aDataBasic;
    } else if (DataPlan.pro == mode) {
      return aDataPro;
    }
    return null;
  }

  static DataPlan fromAccountDataPlan(String modeAsString) {
    if (aDataFree == modeAsString) {
      return DataPlan.free;
    } else if (aDataBasic == modeAsString) {
      return DataPlan.basic;
    } else if (aDataPro == modeAsString) {
      return DataPlan.pro;
    }
    throw LemonMarketsException('', 'cannot map tradingPlan $modeAsString', null, modeAsString, null);
  }

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
    } else if (OrderStatus.activated == status) {
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
      return OrderStatus.activated;
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
    } else if (OrderType.stop == type) {
      return 'stop';
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
    } else if ('stop' == typeAsString) {
      return OrderType.stop;
    }
    return OrderType.unknown;
  }

  static String? toSpaceType(SpaceType type) {
    if (SpaceType.auto == type) {
      return 'auto';
    } else if (SpaceType.manual == type) {
      return 'manual';
    }
    return null;
  }

  static SpaceType fromSpaceType(String typeAsString) {
    if ('auto' == typeAsString) {
      return SpaceType.auto;
    } else if ('manual' == typeAsString) {
      return SpaceType.manual;
    }
    return SpaceType.unknown;
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