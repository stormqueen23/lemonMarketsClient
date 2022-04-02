import 'package:json_annotation/json_annotation.dart';

part 'historicalUrlResult.g.dart';

@JsonSerializable()
class HistoricalUrlResult {

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'url')
  String? url;

  HistoricalUrlResult(this.status, this.url);

  factory HistoricalUrlResult.fromJson(Map<String, dynamic> json) => _$HistoricalUrlResultFromJson(json);

  Map<String, dynamic> toJson() => _$HistoricalUrlResultToJson(this);
}