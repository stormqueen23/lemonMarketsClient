# lemon_market_client
A simple way to access the lemon markets API (https://www.lemon.markets/)

## Create account for Lemon markets
Currently the lemon market api is in beta and you can join the waitlist to get access (https://www.lemon.markets/waitlist)

## Request Access Token
If you have your credentials for the lemon market API you can request an access token:

```dart
final String clientId = "XXX";
final String clientSecret = "YYY";

final LemonMarkets lm = LemonMarkets();
AccessToken token = await lm.requestToken(clientId, clientSecret);
```

## Search for instrument

## Create order