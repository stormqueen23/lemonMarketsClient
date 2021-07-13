import 'package:json_annotation/json_annotation.dart';

part 'latestQuote.g.dart';

@JsonSerializable()
class LatestQuote {
  @JsonKey(name: 'a')
  double ask;
  @JsonKey(name: 'a_v')
  double askVolume;
  @JsonKey(name: 'b')
  double bit;
  @JsonKey(name: 'b_v')
  double bitVolume;
  @JsonKey(name: 't')
  double time;

  LatestQuote(this.ask, this.askVolume, this.bit, this.bitVolume, this.time);

  factory LatestQuote.fromJson(Map<String, dynamic> json) => _$LatestQuoteFromJson(json);

  Map<String, dynamic> toJson() => _$LatestQuoteToJson(this);
}