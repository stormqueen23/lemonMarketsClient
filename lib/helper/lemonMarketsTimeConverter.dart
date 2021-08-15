class LemonMarketsTimeConverter {
  static double factor = 1;

  static DateTime getDateTimeForLemonMarket(double time) {
    return DateTime.fromMillisecondsSinceEpoch((time * factor).ceil());
  }

  static double getDoubleTimeForDateTime(DateTime time) {
    return time.millisecondsSinceEpoch / factor;
  }

  static double getUTCUnixTimestamp(DateTime time) {
    return time.millisecondsSinceEpoch / 1000;
  }
}
