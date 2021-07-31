import 'package:json_annotation/json_annotation.dart';

part 'searchTradingVenue.g.dart';

@JsonSerializable()
class SearchTradingVenue {
  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'mic')
  String mic;

  SearchTradingVenue(this.title, this.mic);

  factory SearchTradingVenue.fromJson(Map<String, dynamic> json) => _$SearchTradingVenueFromJson(json);

  Map<String, dynamic> toJson() => _$SearchTradingVenueToJson(this);
}
