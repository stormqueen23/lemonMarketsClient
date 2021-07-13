import 'package:json_annotation/json_annotation.dart';

part 'orderTradingVenue.g.dart';

@JsonSerializable()
class OrderTradingVenue {
  @JsonKey(name: 'mic')
  String mic;

  OrderTradingVenue(this.mic);

  factory OrderTradingVenue.fromJson(Map<String, dynamic> json) => _$OrderTradingVenueFromJson(json);

  Map<String, dynamic> toJson() => _$OrderTradingVenueToJson(this);


}