# lemon_markets_client
A simple way to access the lemon markets API (https://www.lemon.markets/)

## Create account for lemon markets
Currently the lemon market api is in beta and you can join the waitlist to get access (https://www.lemon.markets/waitlist)

## Request Access Token
If you have your credentials for the lemon market API you can request an access token:

```dart
import 'package:lemon_markets_client/lemon_markets_client.dart';
...
final String clientId = "XXX";
final String clientSecret = "YYY";

final LemonMarkets lm = LemonMarkets();
try {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
} on LemonMarketsException catch (e) {
    debugPrint(e.toString());
}
```

## Search for instrument

## Create order

## Open endpoints

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
If you want to run the example app, you need to create an asset folder with  a file 'credentials.json'\ 
(example\assets\credentials.json)
```
{
  "clientId": "YOUR_CLIENT_ID",
  "clientSecret": "YOUR_CLIENT_SECRET",
  "spaceUuid": "SPACE_UUID_FOR_CLIENT_ID"
}
```