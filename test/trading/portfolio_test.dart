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
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);

    List<PortfolioItem> items = await lm.getPortfolioItems(token, spaceUuid: 'sp_pyPHTyyLL03WRlBjjpRss8FrgMP9gTDD9x');
    print('found ${items.length} portfolioItems');
    items.forEach((element) {
      print(element);
    });
  });

}
