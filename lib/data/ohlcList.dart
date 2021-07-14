import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_market_client/data/ohlc.dart';

part 'ohlcList.g.dart';

@JsonSerializable()
class OHLCList {
  @JsonKey(name: 'next')
  String next;
  @JsonKey(name: 'previous')
  String previous;
  @JsonKey(name: 'results')
  List<OHLC> result;

  OHLCList(this.next, this.previous, this.result,);

  factory OHLCList.fromJson(Map<String, dynamic> json) => _$OHLCListFromJson(json);

  Map<String, dynamic> toJson() => _$OHLCListToJson(this);
}