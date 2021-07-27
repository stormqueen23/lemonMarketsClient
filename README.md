# lemon_markets_client
A simple way to access the lemon markets API (https://www.lemon.markets/)

## Create account for Lemon markets
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

/trading-venues/{mic}/instruments/
/trading-venues/{mic}/instruments/{isin}/
/trading-venues/{mic}/instruments/{isin}/warrants/

## Building this plugin
To generate the missing *.g.dart classes run:\
```
flutter packages pub run build_runner build --delete-conflicting-outputs
 ```