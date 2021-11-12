import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../credentials.dart';

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

  test('getPortfolioItems', () async {
    AccessToken token = AccessToken(Credentials.JWT_TOKEN, 1, '', 'bearer');
    List<PortfolioItem> items = await lm.getPortfolioItems(token);
    print('found ${items.length} portfolioItems');
    items.forEach((element) {
      print(element);
    });
  });

}
