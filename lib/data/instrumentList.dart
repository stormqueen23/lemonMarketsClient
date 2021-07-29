import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/instrument.dart';

part 'instrumentList.g.dart';

@JsonSerializable()
class InstrumentList {
  @JsonKey(name: 'next')
  String? next;
  @JsonKey(name: 'prev')
  String? previous;
  @JsonKey(name: 'results')
  List<Instrument> result;

  InstrumentList(this.next, this.previous, this.result);

  factory InstrumentList.fromJson(Map<String, dynamic> json) => _$InstrumentListFromJson(json);

  Map<String, dynamic> toJson() => _$InstrumentListToJson(this);
}