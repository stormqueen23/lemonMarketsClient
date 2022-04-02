import 'package:intl/intl.dart';

class LemonMarketsTimeConverter {
  static DateFormat openingDayFormatter = DateFormat('yyyy-MM-dd');
  static DateFormat historicalDayFormat = DateFormat('yyyy-MM-dd');

  static DateTime getOpeningDay(String value) {
    return openingDayFormatter.parse(value);
  }

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

  static DateTime fromIsoTime(String value) {
    return DateTime.parse(value).toLocal();
  }

  static String toIsoTime(DateTime value) {
    String result = value.toUtc().toIso8601String();
    //"expires_at":"2021-12-05T06:18:54.030093+00:00" --> in post request
    //"expires_at":"2021-12-05T22:59:00.000+00:00" --> in response
    result = result.replaceAll('Z', '+00:00');
    return result;
  }

  static DateTime? fromIsoTimeNullable(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return fromIsoTime(value);
  }

  static String? toIsoTimeNullable(DateTime? value) {
    if (value == null) {
      return null;
    }
    return toIsoTime(value);
  }

  static DateFormat dayFormatter = DateFormat('yyyy-MM-dd');

  static DateTime fromIsoDay(String value) {
    DateTime d =  dayFormatter.parse(value);
    DateTime result = DateTime(d.year, d.month, d.day, 23, 59);
    return result;
  }

  static DateTime? fromIsoDayNullable(String? value) {
    if (value == null) {
      return null;
    }
    DateTime d =  dayFormatter.parse(value);
    DateTime result = DateTime(d.year, d.month, d.day, 23, 59);
    return result;
  }

  static String toIsoDay(DateTime value) {
    String result = dayFormatter.format(value);
    return result;
  }

  static String? toIsoDayNullable(DateTime? value) {
    if (value == null) {
      return null;
    }
    String result = dayFormatter.format(value);
    return result;
  }
  static DateFormat queryDayFormatter = DateFormat('yyyy-MM-dd');

  static String getOrderQueryTimeFormat(DateTime time) {
    return queryDayFormatter.format(time);
  }

  /// converts [date] into the following format: `2020-09-16T11:55:01.802248+01:00`
  static String formatISOTime(DateTime date) {
    var duration = date.timeZoneOffset;
    if (duration.isNegative)
      return (date.toIso8601String() + "-${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    else
      return (date.toIso8601String() + "+${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
  }
}
