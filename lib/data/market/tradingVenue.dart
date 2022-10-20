import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/market/openingHour.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';

part 'tradingVenue.g.dart';

@JsonSerializable()
class TradingVenue {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'mic')
  String mic;

  @JsonKey(name: 'is_open')
  bool isOpen;

  @JsonKey(name: 'opening_hours')
  OpeningHour hour;

  @JsonKey(name: 'opening_days')
  List<String> openingDays;

  TradingVenue(this.name, this.title, this.mic, this.isOpen, this.hour, this.openingDays);

  factory TradingVenue.fromJson(Map<String, dynamic> json) => _$TradingVenueFromJson(json);

  Map<String, dynamic> toJson() => _$TradingVenueToJson(this);

  ///compares the day (yyyy-MM-dd)
  bool isInOpeningDays(DateTime time) {
    time = _getDateInTradingVenueTimeZone(time);
    bool result = false;
    List<DateTime> openingDaysAsDate = openingDays.map((e) => LemonMarketsTimeConverter.openingDayFormatter.parse(e)).toList();
    openingDaysAsDate.forEach((element) {
      if(element.year == time.year && element.month == time.month && element.day == time.day) {
        result = true;
      }
    });
    return result;
  }

  bool isTradingVenueOpen(DateTime at) {
    //convert at to same timezone where this venue is
    at = _getDateInTradingVenueTimeZone(at);
    bool result = isInOpeningDays(at);
    if (result) {
      //check if requested time is in opening hour
      int openingHour = getOpeningHour();
      int closingHour = getClosingHour();
      if (at.hour >= openingHour && at.hour < closingHour) {
        result = true;
      } else {
        result = false;
      }
    }
    return result;
  }

  /// returns null if given date is before the dates in list,<br/> returns the same date if it is the first in list
  String? getPreviousOpeningDay(DateTime time) {
    time = _getDateInTradingVenueTimeZone(time);
    String timeString = LemonMarketsTimeConverter.openingDayFormatter.format(time);

    //oldest first
    openingDays.sort((a,b) => a.compareTo(b));

    String? result;

    for (int i = 0; i < openingDays.length; i++) {
      result = _checkPreviousDay(timeString);
      if (result != null) {
        break;
      } else {
        time = time.add(Duration(days: 1));
        timeString = LemonMarketsTimeConverter.openingDayFormatter.format(time);
      }
    }

    return result;
  }

  String? _checkPreviousDay(String toDay) {
    int index = openingDays.indexOf(toDay);
    String? result;
    if (index == 0) {
      result = toDay;
    } else if (index > 0) {
      result = openingDays[index-1];
    }
    return result;
  }

  /// returns null if given date is after the dates in list,<br/> returns the same date if it is the last day in list
  String? getNextOpeningDay(DateTime time) {
    time = _getDateInTradingVenueTimeZone(time);
    String timeString = LemonMarketsTimeConverter.openingDayFormatter.format(time);

    //oldest first
    openingDays.sort((a,b) => a.compareTo(b));

    String? result;

    for (int i = 0; i < openingDays.length; i++) {
      result = _checkNextDay(timeString);
      if (result != null) {
        break;
      } else {
        time = time.add(Duration(days: -1));
        timeString = LemonMarketsTimeConverter.openingDayFormatter.format(time);
      }
    }

    return result;
  }

  String? _checkNextDay(String toDay) {
    int index = openingDays.indexOf(toDay);
    String? result;
    if (index == openingDays.length) {
      result = toDay;
    } else if (index >= 0) {
      result = openingDays[index+1];
    }
    return result;
  }

  int getOpeningHour() {
    return int.parse(hour.start.substring(0,2));
  }

  int getOpeningMinute() {
    return int.parse(hour.start.substring(3,5));
  }

  int getClosingHour() {
    return int.parse(hour.end.substring(0,2));
  }

  int getClosingMinute() {
    return int.parse(hour.end.substring(3,5));
  }

  String getTimezone() {
    return hour.timezone;
  }

  DateTime _getDateInTradingVenueTimeZone(DateTime at) {
    at = at.toUtc();
    Duration tradingVenueOffset = getTradingVenueOffsetToUtc(at);
    at = at.add(tradingVenueOffset);
    return at;
  }

  Duration getTradingVenueOffsetToUtc(DateTime at) {
    if (hour.timezone == 'Europe/Berlin') {
      if (at.isAfter(DateTime(at.year, 3, _getLastSundayInMonth(at.year, 3))) &&
          at.isBefore(DateTime(at.year, 10, _getLastSundayInMonth(at.year, 10)))) {
        Duration tradingVenueOffset = Duration(hours: 2);
        return tradingVenueOffset;
      }
      Duration tradingVenueOffset = Duration(hours: 1);
      return tradingVenueOffset;
    }
    return Duration(days: 0);
  }

  int _getLastSundayInMonth(int year, int month) {
    int result = 0;
    for (int i = 1; i < 32; i++) {
      DateTime test = DateTime(year, month, i);
      if (test.weekday == DateTime.sunday) {
        result = i;
      }
    }
    return result;
  }

  @override
  String toString() {
    return 'TradingVenue{name: $name, title: $title, mic: $mic}';
  }
}
