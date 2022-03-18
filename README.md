![](https://www.lemon.markets/images/logo.svg?auto=format&fit=max)

# Lemon Markets SDK
A simple way to access the lemon markets API (https://www.lemon.markets/) in dart / flutter

## Create account for lemon markets
Currently the lemon market api is in beta and you can join the waitlist to get access (https://www.lemon.markets/waitlist)

## Create an API-Key for accessing the lemon markets API
Get/Create your API-key from the https://dashboard.lemon.markets/ 

For this SDK you will always need an instance of LemonMarkets and an instance of AccessToken.
You can specify in the AccessToken if you want to use real-money trading for this token.

```dart
import 'package:lemon_markets_client/lemon_markets_client.dart';
...

final LemonMarkets lemonMarkets = LemonMarkets();
AccessToken token = AccessToken(token: 'ADD_YOUR_TOKEN_HERE');
```

## Search for instrument

```dart
  final LemonMarkets lemonMarkets = LemonMarkets();
  AccessToken token = AccessToken(token: 'ADD_YOUR_TOKEN_HERE');
  try {
    ResultList<Instrument> result = await lemonMarkets.searchInstruments(token, search: 'Tesla');
  } on LemonMarketsException catch (e) {
    debugPrint(e.toString());
  }
```

## Create and activate an order
If you want to buy or sell an instrument you need two steps to do that.\
First you must create an order and second you need to activate this order.\
(More details for working with orders: https://docs.lemon.markets/working-with-orders)

Short example for BUY:
```dart
  final LemonMarkets lemonMarkets = LemonMarkets();
  AccessToken token = AccessToken(token: 'ADD_YOUR_TOKEN_HERE');

  TradingResult<CreatedOrder> result = await lemonMarkets.placeOrder(token, 'US88160R1014', OrderSide.buy, 5);
  String orderUuid = result.result!.uuid;
  ActivateOrderResult activateResult = lemonMarkets.activateOrder(token, orderUuid);  
```
Short example for SELL:
```dart
  final LemonMarkets lemonMarkets = LemonMarkets();
  AccessToken token = AccessToken(token: 'ADD_YOUR_TOKEN_HERE');

  TradingResult<CreatedOrder> result = await lemonMarkets.placeOrder(token, 'US88160R1014', OrderSide.sell, 5);
  String orderUuid = result.uuid;
  ActivateOrderResult activateResult = lemonMarkets.activateOrder(token, orderUuid);
```

## Building this plugin
To (re-)generate the missing *.g.dart classes run:\
```
flutter packages pub run build_runner build --delete-conflicting-outputs
 ```

## Running the example app
If you want to run the example app, you need to replace 'ADD_YOUR_TOKEN_HERE' in the LemonMarketsProvider with your token!

## Open Issuers
Withdrawals

## Contribute
Feel free to fork and add pull-requests

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Y8Y41V672)