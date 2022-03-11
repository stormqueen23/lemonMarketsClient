import 'package:flutter/material.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

class LemonMarketsProvider with ChangeNotifier {
  final LemonMarkets lm = LemonMarkets();
  AccessToken token = AccessToken(token: 'ADD_YOUR_TOKEN_HERE');

  bool showTokenData = false;

  bool showSpaceData = false;

  String? errorMessage;

  String? searchString;

  int? quantity;
  bool orderCreated = false;

  void switchShowTokenData() {
    showTokenData = !showTokenData;
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
        return null;
      }
  }

  Future<void> createAndActivateOrder(String isin, bool sell) async {
    debugPrint('createAndActivateOrder with quantity $quantity');
    if (quantity != null && quantity! > 0) {
      try {
        debugPrint('create order for $isin');
        CreatedOrder order = (await lm.placeOrder(token, isin, sell ? OrderSide.sell : OrderSide.buy, quantity!)).result!;
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