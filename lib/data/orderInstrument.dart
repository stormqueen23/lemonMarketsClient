import 'package:json_annotation/json_annotation.dart';

part 'orderInstrument.g.dart';

@JsonSerializable()
class OrderInstrument {
  @JsonKey(name: 'isin')
  String isin;
  @JsonKey(name: 'title')
  String title;

  OrderInstrument(this.isin, this.title);

  factory OrderInstrument.fromJson(Map<String, dynamic> json) => _$OrderInstrumentFromJson(json);

  Map<String, dynamic> toJson() => _$OrderInstrumentToJson(this);
}