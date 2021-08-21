class LemonMarketsTimeConverter {

  /// converts from milliseconds
  static DateTime? getDateTimeForLemonMarketNullable(int? time) {
    if (time == null) {
      return null;
    }
    return getDateTimeForLemonMarket(time);
  }

  /// converts from milliseconds
  static DateTime getDateTimeForLemonMarket(int time) {
    return DateTime.fromMillisecondsSinceEpoch(time);
  }

  /// returns millisecondsSinceEpoch
  static int? getDoubleTimeForDateTimeNullable(DateTime? time) {
    if (time == null) {
      return null;
    }
    return getDoubleTimeForDateTime(time);
  }

  /// returns millisecondsSinceEpoch
  static int getDoubleTimeForDateTime(DateTime time) {
    return time.millisecondsSinceEpoch;
  }


  /// returns seconds from epoch
  static double? getUTCUnixTimestampNullable(DateTime? time) {
    if (time == null) {
      return null;
    }
    return getUTCUnixTimestamp(time);
  }

  /// returns seconds from epoch
  static double getUTCUnixTimestamp(DateTime time) {
    return time.millisecondsSinceEpoch / 1000;
  }

  /// converts from seconds
  static DateTime? getUTXUnixDateTimeForLemonMarketNullable(double? time) {
    if (time == null) {
      return null;
    }
    return getUTXUnixDateTimeForLemonMarket(time);
  }

  /// converts from seconds
  static DateTime getUTXUnixDateTimeForLemonMarket(double time) {
    return DateTime.fromMillisecondsSinceEpoch((time * 1000).ceil());
  }
}
