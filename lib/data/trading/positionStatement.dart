import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

part 'positionStatement.g.dart';

@JsonSerializable()
class PositionStatement {
/*
  type*	PositionTypestring
  title: PositionType
  An enumeration.
*/

  @JsonKey(name: 'id')
  String uuid;

  @JsonKey(name: 'order_id')
  String? orderUuid;

  @JsonKey(name: 'external_id')
  String? externalUuid;

  @JsonKey(
      name: 'type', fromJson: LemonMarketsResultConverter.fromPositionStatementType, toJson: LemonMarketsResultConverter.toPositionStatementType)
  PositionStatementType type;

  @JsonKey(name: 'isin')
  String isin;

  @JsonKey(name: 'isin_title')
  String? isinTitle;

  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(
      name: 'date', fromJson: LemonMarketsTimeConverter.fromDay, toJson: LemonMarketsTimeConverter.toDay)
  DateTime date;

  @JsonKey(
      name: 'created_at', fromJson: LemonMarketsTimeConverter.fromIsoTime, toJson: LemonMarketsTimeConverter.toIsoTime)
  DateTime createdAt;

  PositionStatement(this.uuid,
      this.isin,
      this.type,
      this.quantity,
      this.date,
      this.createdAt);

  factory PositionStatement.fromJson(Map<String, dynamic> json) => _$PositionStatementFromJson(json);

  Map<String, dynamic> toJson() => _$PositionStatementToJson(this);

  @override
  String toString() {
    return 'PositionStatement{\nuuid: $uuid,\norderUuid: $orderUuid,\nexternalUuid: $externalUuid,\ntype: $type,\nisin: $isin,\nisinTitle: $isinTitle,\nquantity: $quantity,\ndate: $date,\ncreatedAt: $createdAt\n}';
  }
}
