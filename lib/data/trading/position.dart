import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/amount.dart';
import 'package:lemon_markets_client/helper/lemonMarketsAmountConverter.dart';

part 'position.g.dart';

@JsonSerializable()
class Position {
  @JsonKey(name: 'isin')
  String isin;

  @JsonKey(name: 'isin_title')
  String isinTitle;

  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(
      name: 'buy_price_avg',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? buyPriceAvg;

  @JsonKey(
      name: 'estimated_price',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? estimatedPrice;

  @JsonKey(
      name: 'estimated_price_total',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? estimatedPriceTotal;

  Position(
      this.isin,
      this.isinTitle,
      this.quantity,
      this.buyPriceAvg);

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);

  Amount get sumPrice => Amount(apiValue: quantity * (buyPriceAvg?.apiValue ?? 0));

  Amount get diffAmount => (estimatedPriceTotal ?? Amount.zero()).subtractAmount(sumPrice);

  double get diffPercent => sumPrice.apiValue == 0 ? 0 : diffAmount.apiValue / sumPrice.apiValue * 100.0;

  bool get isPositive => diffPercent > 0;

  @override
  String toString() {
    return 'Position{\n'
        'quantity: $quantity,\n'
        'buyPriceAvg: $buyPriceAvg,\n'
        'isin: $isin,\n'
        'title: $isinTitle,\n'
        'estimatedPriceSingle: $estimatedPrice,\n'
        'estimatedPriceTotal: $estimatedPriceTotal,\n'
        'diffAmount: $diffAmount,\n'
        'diffPercent: $diffAmount,\n'
        '}';
  }
}
