import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/trading/portfolioItem.dart';
import 'package:lemon_markets_client/data/trading/intern/portfolioItemApi.dart';

part 'portfolio.g.dart';

@JsonSerializable()
class Portfolio {

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'results')
  Map<String, dynamic> result;

  Portfolio(this.status, this.result);

  factory Portfolio.fromJson(Map<String, dynamic> json) => _$PortfolioFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioToJson(this);

  /*
  "result": {
    "US19260Q1076": {
      "sp_pyJKLffNNByV4m8rxtG4YnfGwKJGk3bnBy":
      {
        "quantity": 1,
        "buy_quantity": 1,
        "sell_quantity": 0,
        "buy_price_avg": 2965000,
        "buy_price_min": 2965000,
        "buy_price_max": 2965000,
        "buy_price_avg_historical": 2965000,
        "sell_price_min": None,
        "sell_price_max": None,
        "sell_price_avg_historical": None,
        "orders_total": 1,
        "sell_orders_total": 0,
        "buy_orders_total": 1
      },
    },
   */
  List<PortfolioItem> getPortfolioItems() {
    List<PortfolioItem> items = [];
    result.entries.forEach((element) {
      String isin = element.key;
      Map<String, dynamic> isinDetails = element.value as Map<String, dynamic>;
      isinDetails.entries.forEach((element1) {
        String spaceUuid = element1.key;
        Map<String, dynamic> spaceDetails = element1.value as Map<String, dynamic>;
        PortfolioItemApi apiItem = PortfolioItemApi.fromJson(spaceDetails);
        items.add(PortfolioItem(
          isin,
          spaceUuid,
          apiItem.quantity,
          apiItem.quantityBuy,
          apiItem.quantitySell,
          apiItem.buyPriceAvg,
          apiItem.buyPriceMin,
          apiItem.buyPriceMax,
          apiItem.buyPriceAvgHistorical,
          apiItem.sellPriceMin,
          apiItem.sellPriceMax,
          apiItem.sellPriceAvgHistorical,
          apiItem.ordersTotal,
          apiItem.sellOrdersTotal,
          apiItem.buyOrdersTotal,
        ));
      });
    });
    return items;
  }

}