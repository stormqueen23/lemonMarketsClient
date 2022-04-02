import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/market/historicalUrlResult.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';

part 'historicalUrlWrapper.g.dart';

@JsonSerializable()
class HistoricalUrlWrapper {

  @JsonKey(name: 'time', fromJson: LemonMarketsTimeConverter.fromIsoTime, toJson: LemonMarketsTimeConverter.toIsoTime)
  DateTime time;

  @JsonKey(name: 'results')
  HistoricalUrlResult result;

  HistoricalUrlWrapper(this.time, this.result);

  factory HistoricalUrlWrapper.fromJson(Map<String, dynamic> json) => _$HistoricalUrlWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$HistoricalUrlWrapperToJson(this);
}