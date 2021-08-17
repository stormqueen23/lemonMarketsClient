class LemonMarketsTimeConverter {
  static double factor = 1;

  static DateTime getDateTimeForLemonMarket(double time) {
    return DateTime.fromMillisecondsSinceEpoch((time * factor).ceil());
  }

  static int getDoubleTimeForDateTime(DateTime time) {
    return (time.millisecondsSinceEpoch / factor).floor();
  }

  static int getUTCUnixTimestamp(DateTime time) {
    return (time.millisecondsSinceEpoch / 1000).floor();
  }
}
