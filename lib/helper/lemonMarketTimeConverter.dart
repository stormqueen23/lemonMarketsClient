class LemonMarketTimeConverter {

  static DateTime getDateTimeForLemonMarket(double time) {
    return DateTime.fromMillisecondsSinceEpoch((time * 1000).ceil());
  }

  static double getDoubleTimeForDateTime(DateTime time) {
    return time.millisecondsSinceEpoch / 1000;
  }
}
