import 'package:lemon_markets_client/lemon_markets_client.dart';

class LemonMarketsQueryConverter {

  static String? convertOHLCType(OHLCType type) {
    if (OHLCType.d1 == type) {
      return 'd1';
    } else if (OHLCType.h1 == type) {
      return 'h1';
    } else if (OHLCType.m1 == type) {
      return 'm1';
    }
    return null;
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
    } else if (OrderStatus.open == value) {
      return 'open';
    } else if (OrderStatus.cancelled == value) {
      return 'canceled';
    } else if (OrderStatus.cancelling == value) {
      return 'canceling';
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

  static String bDividend = 'dividend';
  static String bOrderBuy = 'order_buy';
  static String bOrderSell = 'order_sell';
  static String bPayIn = 'pay_in';
  static String bPayOut = 'pay_out';
  static String bEndOfDayBalance = 'eod_balance';
  static String bTax = 'tax_refund';
  static String bInterestPaid = 'interest_paid';
  static String bInterestEarned = 'interest_earned';


  static String convertBankStatementType(BankStatementType value) {
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
    } else if (BankStatementType.tax == value) {
      return bTax;
    } else if (BankStatementType.interestPaid == value) {
      return bInterestPaid;
    } else if (BankStatementType.interestEarned == value) {
      return bInterestEarned;
    }
    return '';
  }

  static String convertPositionStatementType(PositionStatementType type) {
    String result = '';
    switch (type) {
      case PositionStatementType.snx:
        result = LemonMarketsResultConverter.psSnx;
        break;
      case PositionStatementType.import:
        result = LemonMarketsResultConverter.psImport;
        break;
      case PositionStatementType.split:
        result = LemonMarketsResultConverter.psSplit;
        break;
      case PositionStatementType.order_sell:
        result = LemonMarketsResultConverter.psSell;
        break;
      case PositionStatementType.order_buy:
        result = LemonMarketsResultConverter.psBuy;
        break;
    }
    return result;
  }
}