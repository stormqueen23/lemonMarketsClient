import 'package:flutter/material.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

class LemonMarketsProvider with ChangeNotifier {
  final LemonMarkets lm = LemonMarkets();
  AccessToken token = AccessToken(token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJsZW1vbi5tYXJrZXRzIiwiaXNzIjoibGVtb24ubWFya2V0cyIsInN1YiI6InVzcl9weVBGUlNTVlZYckJiVjZKZzVrcVY0bU10emdkMVdGZGpWIiwiZXhwIjoxNjY5OTc1MDg0LCJpYXQiOjE2Mzg0MzkwODQsImp0aSI6ImFwa19weVFETUtLR0dKWTVwN0MxazEyODJEU2tsZGtQMHBCbnFZIn0.WQgAfOIXhTzVBNGFUChzewouSCNsJTKzPgLjAVwvqVo');
  String spaceIdForCreatingOrders = 'sp_pyPFRVVGGgwcKL63qmDFPcVTRwtdhmHrqD';
  //AccessToken token = AccessToken(token: 'ADD_YOUR_TOKEN_HERE');
  //String spaceIdForCreatingOrders = 'ADD_YOUR_SPACE_ID_HERE';
  bool showTokenData = false;

  TradingResultList<Space>? spaces;
  bool showSpaceData = false;

  String? errorMessage;

  String? searchString;

  int? quantity;
  bool orderCreated = false;

  void switchShowTokenData() {
    showTokenData = !showTokenData;
    notifyListeners();
  }

  Future<void> requestSpaceDetails() async {
    try {
      spaces = await lm.getSpaces(token);
      notifyListeners();
    } on LemonMarketsException catch (e) {
      setErrorMessage(e.toString());
    }
  }

  void switchShowSpaceData() {
    showSpaceData = !showSpaceData;
    notifyListeners();
  }

  void setSearchString(String value) {
    this.searchString = value;
  }

  Future<ResultList<Instrument>?> searchInstruments() async {
      try {
        notifyListeners();
        return lm.searchInstruments(token, search: searchString);
      } on LemonMarketsException catch (e) {
        setErrorMessage(e.toString());
      }

  }

  Future<void> createAndActivateOrder(String isin, bool sell) async {
    debugPrint('createAndActivateOrder with quantity $quantity');
    if (quantity != null && quantity! > 0) {
      try {
        debugPrint('create order for $isin');
        CreatedOrder order = await lm.placeOrder(token, spaceIdForCreatingOrders, isin, sell ? OrderSide.sell : OrderSide.buy, quantity!);
        debugPrint('created order:  ${order.uuid}');
        this.quantity = null;
        orderCreated = true;
        await lm.activateOrder(token, order.uuid, null);
      } on LemonMarketsException catch (e) {
        setErrorMessage(e.toString());
      }
    }
  }

  void setQuantity(String? value) {
    if (value == null || value.isEmpty) {
      this.quantity = null;
    } else {
      this.quantity = int.tryParse(value);
    }
    notifyListeners();
  }

  setErrorMessage(String? message) {
    this.errorMessage = message;
    notifyListeners();
  }
}