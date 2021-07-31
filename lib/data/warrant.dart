import 'package:json_annotation/json_annotation.dart';

part 'warrant.g.dart';

@JsonSerializable()
class Warrant {
  @JsonKey(name: 'isin')
  String isin;

  @JsonKey(name: 'wkn')
  String wkn;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'symbol')
  String symbol;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'currency')
  String currency;

  @JsonKey(name: 'tradable')
  bool tradable;

  Warrant(this.isin, this.wkn, this.title, this.type, this.symbol, this.name, this.currency, this.tradable);

  factory Warrant.fromJson(Map<String, dynamic> json) => _$WarrantFromJson(json);

  Map<String, dynamic> toJson() => _$WarrantToJson(this);
}