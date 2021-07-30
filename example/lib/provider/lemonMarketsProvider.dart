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

  StateInfo? stateInfo;

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
        return lm.searchInstruments(token!, search: searchString);
      } on LemonMarketsException catch (e) {
        setErrorMessage(e.toString());
      }
    }
  }

  Future<void> requestStateInfo() async {
    stateInfo = await lm.getStateInfo(token!);
  }

  setErrorMessage(String message) {
    this.errorMessage = message;
    notifyListeners();
  }
}