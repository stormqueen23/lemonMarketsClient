import 'package:flutter_test/flutter_test.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';
import 'package:logging/logging.dart';

import 'credentials.dart';

String clientId = Credentials.clientId;
String clientSecret = Credentials.clientSecret;
String spaceUuid = Credentials.spaceUuid;
String transactionUuidPayIn = Credentials.transactionUuidPayIn;

final LemonMarkets lm = LemonMarkets();

void main() {
  setUp(() {
    //logging
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      print('${record.loggerName} [${record.level.name}]: ${record.time}: ${record.message}');
    });
  }
  );

  // Authentication

  test('requestToken', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);

    //check if expiresIn is in seconds
    int nowInSeconds = LemonMarketsTimeConverter.getUTCUnixTimestamp(DateTime.now()).floor();
    DateTime expireDate = LemonMarketsTimeConverter.getUTXUnixDateTimeForLemonMarket((nowInSeconds + token.expiresIn).toDouble());

    expect(token, isNotNull);
    expect(expireDate.year, greaterThan(DateTime
        .now()
        .year - 1));
  });

}