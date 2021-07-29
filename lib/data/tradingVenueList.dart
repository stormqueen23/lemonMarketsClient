import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/tradingVenue.dart';

part 'tradingVenueList.g.dart';

@JsonSerializable()
class TradingVenueList {
  @JsonKey(name: 'next')
  String? next;
  @JsonKey(name: 'prev')
  String? previous;
  @JsonKey(name: 'results')
  List<TradingVenue> result;

  TradingVenueList(this.next, this.previous, this.result);

  factory TradingVenueList.fromJson(Map<String, dynamic> json) => _$TradingVenueListFromJson(json);

  Map<String, dynamic> toJson() => _$TradingVenueListToJson(this);
}