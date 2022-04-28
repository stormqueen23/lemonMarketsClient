import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/amount.dart';
import 'package:lemon_markets_client/helper/lemonMarketsAmountConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';

part 'positionPerformance.g.dart';

@JsonSerializable()
class PositionPerformance {
  @JsonKey(name: 'isin')
  String isin;

  @JsonKey(name: 'isin_title')
  String isinTitle;

  @JsonKey(
      name: 'profit',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount profit;

  @JsonKey(
      name: 'loss',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount loss;

  @JsonKey(
      name: 'fees',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount fees;

  @JsonKey(name: 'quantity_bought')
  int quantityBought;

  @JsonKey(name: 'quantity_sold')
  int quantitySold;

  @JsonKey(name: 'quantity_open')
  int quantityOpen;

  @JsonKey(name: 'opened_at', fromJson: LemonMarketsTimeConverter.fromIsoTimeNullable, toJson: LemonMarketsTimeConverter.toIsoTimeNullable)
  DateTime? openedAt;

  @JsonKey(name: 'closed_at', fromJson: LemonMarketsTimeConverter.fromIsoTimeNullable, toJson: LemonMarketsTimeConverter.toIsoTimeNullable)
  DateTime? closedAt;

  PositionPerformance(
      this.isin,
      this.isinTitle,
      this.profit,
      this.loss,
      this.fees,
      this.quantityBought,
      this.quantitySold,
      this.quantityOpen,
      this.openedAt);

  factory PositionPerformance.fromJson(Map<String, dynamic> json) => _$PositionPerformanceFromJson(json);

  Map<String, dynamic> toJson() => _$PositionPerformanceToJson(this);

  @override
  String toString() {
    return 'PositionPerformance{\n'
        'isin: $isin,\n'
        'isinTitle: $isinTitle,\n'
        'profit: $profit,\n'
        'loss: $loss,\n'
        'fees: $fees,\n'
        'quantityBought: $quantityBought,\n'
        'quantitySold: $quantitySold,\n'
        'quantityOpen: $quantityOpen,\n'
        'openedAt: $openedAt,\n'
        'closedAt: $closedAt\n'
        '}';
  }
}
