import 'package:lemon_markets_client/lemon_markets_client.dart';

class LemonMarketsResultConverter {
  static String psBuy = 'order_buy';
  static String psSell = 'order_sell';
  static String psSplit = 'split';
  static String psImport = 'import';
  static String psSnx = 'snx';

  static String? toPositionStatementType(PositionStatementType value) {
    if (PositionStatementType.order_buy == value) {
      return psBuy;
    } else if (PositionStatementType.order_sell == value) {
      return psSell;
    } else if (PositionStatementType.split == value) {
      return psSplit;
    } else if (PositionStatementType.import == value) {
      return psImport;
    } else if (PositionStatementType.snx == value) {
      return psSnx;
    }
    return null;
  }

  static PositionStatementType fromPositionStatementType(String asString) {
    if (psBuy == asString) {
      return PositionStatementType.order_buy;
    } else if (psSell == asString) {
      return PositionStatementType.order_sell;
    } else if (psSplit == asString) {
      return PositionStatementType.split;
    } else if (psImport == asString) {
      return PositionStatementType.import;
    } else if (psSnx == asString) {
      return PositionStatementType.snx;
    }
    throw LemonMarketsException('', 'cannot map PositionStatementType $asString', null, asString, null);
  }


  static String bTax = 'tax_refunded';
  static String bDividend = 'dividend';
  static String bOrderBuy = 'order_buy';
  static String bOrderSell = 'order_sell';
  static String bPayIn = 'pay_in';
  static String bPayOut = 'pay_out';
  static String bEndOfDayBalance = 'eod_balance';
  static String bInterestPaid = 'interest_paid';
  static String bInterestEarned = 'interest_earned';


  static String? toBankStatementType(BankStatementType value) {
    if (BankStatementType.dividend == value) {
      return bDividend;
    } else if (BankStatementType.orderBuy == value) {
      return bOrderBuy;
    } else if (BankStatementType.orderSell == value) {
      return bOrderSell;
    } else if (BankStatementType.payIn == value) {
      return bPayIn;
    } else if (BankStatementType.payOut == value) {
      return bPayOut;
    } else if (BankStatementType.endOfDayBalance == value) {
      return bEndOfDayBalance;
    } else if (BankStatementType.interestPaid == value) {
      return bInterestPaid;
    } else if (BankStatementType.interestEarned == value) {
      return bInterestEarned;
    } else if (BankStatementType.tax == value) {
      return bTax;
    }
    return null;
  }

  static BankStatementType fromBankStatement(String value) {
    if (bPayOut == value) {
      return BankStatementType.payOut;
    } else if (bPayIn == value) {
      return BankStatementType.payIn;
    } else if (bDividend == value) {
      return BankStatementType.dividend;
    } else if (bEndOfDayBalance == value) {
      return BankStatementType.endOfDayBalance;
    } else if (bOrderBuy == value) {
      return BankStatementType.orderBuy;
    } else if (bOrderSell == value) {
      return BankStatementType.orderSell;
    } else if (bInterestPaid == value) {
      return BankStatementType.interestPaid;
    } else if (bInterestEarned == value) {
      return BankStatementType.interestEarned;
    } else if (bTax == value || 'tax' == value) {
      return BankStatementType.tax;
    }
    return BankStatementType.unknown;
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
      return 'activated';
    } else if (OrderStatus.in_progress == status) {
      return 'in_progress';
    } else if (OrderStatus.executed == status) {
      return 'executed';
    } else if (OrderStatus.expired == status) {
      return 'expired';
    } else if (OrderStatus.open == status) {
      return 'open';
    } else if (OrderStatus.cancelling == status) {
      return 'cancelling';
    } else if (OrderStatus.cancelled == status) {
      return 'cancelled';
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
    } else if ('expired' == typeAsString) {
      return OrderStatus.expired;
    } else if ('open' == typeAsString) {
      return OrderStatus.open;
    } else if ('cancelling' == typeAsString || 'canceling' == typeAsString) {
      return OrderStatus.cancelling;
    } else if ('cancelled' == typeAsString || 'canceled' == typeAsString) {
      return OrderStatus.cancelled;
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