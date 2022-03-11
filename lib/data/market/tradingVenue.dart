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

  ///only compares the day! (yyyy-MM-dd)
  bool isInOpeningDays(DateTime time) {
    bool result = false;
    List<DateTime> openingDaysAsDate = openingDays.map((e) => LemonMarketsTimeConverter.openingDayFormatter.parse(e)).toList();
    openingDaysAsDate.forEach((element) {
      if(element.year == time.year && element.month == time.month && element.day == time.day) {
        result = true;
      }
    });
    return result;
  }

  DateTime? getPreviousOpeningDayEnd(DateTime time) {
   DateTime? result = _getPreviousOpeningDay(time);
    if (result == null) {
      return null;
    }
    result = DateTime(result.year, result.month, result.day, int.parse(hour.end.substring(0,2)));
    return result;
  }

  DateTime? getPreviousOpeningDayStart(DateTime time) {
   DateTime? result = _getPreviousOpeningDay(time);
    if (result == null) {
      return null;
    }
    result = DateTime(result.year, result.month, result.day, int.parse(hour.start.substring(0,2)));
    return result;
  }

  DateTime? _getPreviousOpeningDay(DateTime time) {
    DateTime? result;
    String timeString = LemonMarketsTimeConverter.openingDayFormatter.format(time);
    DateTime adjustedTime = LemonMarketsTimeConverter.openingDayFormatter.parse(timeString);
    List<DateTime> openingDaysAsDate = openingDays.map((e) => LemonMarketsTimeConverter.openingDayFormatter.parse(e)).toList();
    //latest first!
    openingDaysAsDate.sort((a, b) => a.compareTo(b));
    for(DateTime element in openingDaysAsDate) {
      if(element.isBefore(adjustedTime)) {
        result = element;
      } else {
        break;
      }
    };
    return result;
  }

  DateTime getNextOpeningDayStart(DateTime time) {
   DateTime result = time;
    String timeString = LemonMarketsTimeConverter.openingDayFormatter.format(time);
    DateTime adjustedTime = LemonMarketsTimeConverter.openingDayFormatter.parse(timeString);
    List<DateTime> openingDaysAsDate = openingDays.map((e) => LemonMarketsTimeConverter.openingDayFormatter.parse(e)).toList();
    //latest first!
    openingDaysAsDate.sort((a, b) => a.compareTo(b));
    for(DateTime element in openingDaysAsDate) {
      if(element.isAfter(adjustedTime)) {
        result = element;
        break;
      }
    };
    result = DateTime(result.year, result.month, result.day, int.parse(hour.start.substring(0,2)));
    return result;
  }

  bool isTradingVenueOpen(DateTime at) {
    bool result = isInOpeningDays(at);

    OpeningHour oh = hour;
    String currentOpeningDay = LemonMarketsTimeConverter.openingDayFormatter.format(at);

    if (result) {
      //check if requested time is in opening hour
      String start = oh.start;
      DateTime startDate = LemonMarketsTimeConverter.getOpeningDayWithHour(start, currentOpeningDay);
      String end = oh.end;
      DateTime endDate = LemonMarketsTimeConverter.getOpeningDayWithHour(end, currentOpeningDay);

      result = (at.isAfter(startDate) && at.isBefore(endDate)) ||
          at.isAtSameMomentAs(startDate) ||
          at.isAtSameMomentAs(endDate);
    }

    return result;
  }
}
