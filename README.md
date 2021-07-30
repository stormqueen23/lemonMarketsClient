# lemon_markets_client
A simple way to access the lemon markets API (https://www.lemon.markets/)

## Create account for lemon markets
Currently the lemon market api is in beta and you can join the waitlist to get access (https://www.lemon.markets/waitlist)

## Request Access Token
If you have your credentials for the lemon market API you can request an access token:

```dart
import 'package:lemon_markets_client/lemon_markets_client.dart';
...
final String clientId = "YOUR_CLIENT_ID";
final String clientSecret = "YOUR_CLIENT_SECRET";

final LemonMarkets lemonMarkets = LemonMarkets();
try {
    AccessToken token = await lemonMarkets.requestToken(clientId, clientSecret);
} on LemonMarketsException catch (e) {
    debugPrint(e.toString());
}
```
## Information for all endpoints
You always need an instance of LemonMarkets and an Access Token for calling an endpoint. 
```dart
final LemonMarkets lemonMarkets = LemonMarkets();
AccessToken token = await lemonMarkets.requestToken('YOUR_CLIENT_ID', 'YOUR_CLIENT_SECRET');
```
## Search for instrument
One-liner:
```dart
  ResultList<Instrument> result = await lemonMarkets.searchInstruments(token, search: 'Tesla');
```

Complete example: 

```dart
import 'package:lemon_markets_client/lemon_markets_client.dart';
...
final String clientId = "YOUR_CLIENT_ID";
final String clientSecret = "YOUR_CLIENT_SECRET";

final LemonMarkets lemonMarkets = LemonMarkets();
try {
    AccessToken token = await lemonMarkets.requestToken(clientId, clientSecret);
    ResultList<Instrument> result = await lemonMarkets.searchInstruments(token, search: searchString)
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
  CreatedOrder result = await lemonMarkets.placeOrder(token, 'SPACE_UUID', 'US88160R1014', false, 5);
  String orderUuid = result.uuid;
  bool success = lemonMarkets.activateOrder(token, 'SPACE_UUID', orderUuid);  
```
Short example for SELL:
```dart
  CreatedOrder result = await lemonMarkets.placeOrder(token, 'SPACE_UUID', 'US88160R1014', true, 5);
  String orderUuid = result.uuid;
  bool success =  lemonMarkets.activateOrder(token, 'SPACE_UUID', orderUuid);
```



## TODO
### Not implemented endpoints:

/spaces/{space_uuid}/orders/{order_uuid}

/trading-venues/{mic}/instruments/ \
/trading-venues/{mic}/instruments/{isin}/ \
/trading-venues/{mic}/instruments/{isin}/warrants/ 

## Building this plugin
To generate the missing *.g.dart classes run:\
```
flutter packages pub run build_runner build --delete-conflicting-outputs
 ```

## Running the example app
If you want to run the example app, you need to create an asset folder with  a file 'credentials.json' 
(example\assets\credentials.json)
```
{
  "clientId": "YOUR_CLIENT_ID",
  "clientSecret": "YOUR_CLIENT_SECRET",
  "spaceUuid": "SPACE_UUID_FOR_CLIENT_ID"
}
```