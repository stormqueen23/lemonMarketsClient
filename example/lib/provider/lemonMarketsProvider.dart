import 'package:example/credentials.dart';
import 'package:flutter/material.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

class LemonMarketsProvider with ChangeNotifier {
  final LemonMarkets lm = LemonMarkets();
  Credentials credentials = Credentials();

  AccessToken? token;
  bool showTokenData = false;

  ResultList<Space>? spaces;
  bool showSpaceData = false;

  String? errorMessage;

  String? searchString;

  int? quantity;
  bool orderCreated = false;

  Future<void> requestToken(BuildContext context) async {
    await credentials.init(context);
    try {
      token = await lm.requestToken(credentials.clientId, credentials.clientSecret);
      notifyListeners();
    } on LemonMarketsException catch (e) {
      setErrorMessage(e.toString());
    }

  }

  void switchShowTokenData() {
    showTokenData = !showTokenData;
    notifyListeners();
  }

  Future<void> requestSpaceDetails() async {
    try {
      spaces = await lm.getSpaces(token!);
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
    if (token != null) {
      try {
        notifyListeners();
        return lm.searchInstruments(token!, query: searchString);
      } on LemonMarketsException catch (e) {
        setErrorMessage(e.toString());
      }
    }
  }

  Future<void> createAndActivateOrder(String isin, bool sell) async {
    debugPrint('createAndActivateOrder with quantity $quantity');
    if (quantity != null && quantity! > 0 && spaces != null && spaces!.result.isNotEmpty && token != null) {
      try {
        debugPrint('create order for $isin');
        CreatedOrder order = await lm.placeOrder(token!, spaces!.result[0].uuid, isin, sell ? OrderSide.sell : OrderSide.buy, quantity!);
        debugPrint('created order:  ${order.uuid}');
        this.quantity = null;
        orderCreated = true;
        await lm.activateOrder(token!, spaces!.result[0].uuid, order.uuid);
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