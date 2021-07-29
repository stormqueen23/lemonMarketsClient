import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/existingOrder.dart';

part 'existingOrderList.g.dart';

@JsonSerializable()
class ExistingOrderList {

  @JsonKey(name: 'next')
  String? next;
  @JsonKey(name: 'prev')
  String? previous;
  @JsonKey(name: 'results')
  List<ExistingOrder> result;

  ExistingOrderList(this.next, this.previous, this.result);

  factory ExistingOrderList.fromJson(Map<String, dynamic> json) => _$ExistingOrderListFromJson(json);

  Map<String, dynamic> toJson() => _$ExistingOrderListToJson(this);
}