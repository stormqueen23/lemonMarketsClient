import 'package:json_annotation/json_annotation.dart';

part 'quote.g.dart';

@JsonSerializable()
class Quote {
  @JsonKey(name: 'isin')
  String isin;

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

  Quote(this.isin, this.ask, this.askVolume, this.bit, this.bitVolume, this.time);

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}