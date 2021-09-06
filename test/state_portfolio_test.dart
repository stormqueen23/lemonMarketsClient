import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

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

  // State -> Portfolio

  test('getPortfolioItems', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<PortfolioItem> items = await lm.getPortfolioItems(token, Credentials.spaceUuid);
    expect(items.result.length, greaterThan(0));
  });

  test('getPortfolioTransactions', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<PortfolioTransaction> items = await lm.getPortfolioTransactions(token, Credentials.spaceUuid);
    expect(items.result.length, greaterThan(0));
  });

}
