import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/amount.dart';
import 'package:lemon_markets_client/helper/lemonMarketsAmountConverter.dart';

part 'portfolioItem.g.dart';

@JsonSerializable()
class PortfolioItem {
  @JsonKey(name: 'isin')
  String isin;

  @JsonKey(name: 'isin_title')
  String isinTitle;

  @JsonKey(name: 'space_id')
  String spaceUuid;

  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(
      name: 'buy_price_avg',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? buyPriceAvg;

  PortfolioItem(
      this.isin,
      this.isinTitle,
      this.spaceUuid,
      this.quantity,
      this.buyPriceAvg);

  factory PortfolioItem.fromJson(Map<String, dynamic> json) => _$PortfolioItemFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioItemToJson(this);

  Amount get sumPrice => Amount(apiValue: quantity * (buyPriceAvg?.apiValue ?? 0));

  @override
  String toString() {
    return 'PortfolioItem{\n'
        'quantity: $quantity,\n'
        'buyPriceAvg: $buyPriceAvg,\n'
        'isin: $isin,\n'
        'title: $isinTitle,\n'
        'spaceUuid: $spaceUuid\n'
        '}';
  }
}
