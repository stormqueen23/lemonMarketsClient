import 'package:json_annotation/json_annotation.dart';

part 'portfolioInstrument.g.dart';

@JsonSerializable()
class PortfolioInstrument {
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'isin')
  String isin;

  PortfolioInstrument(this.title, this.isin,);

  factory PortfolioInstrument.fromJson(Map<String, dynamic> json) => _$PortfolioInstrumentFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioInstrumentToJson(this);


}