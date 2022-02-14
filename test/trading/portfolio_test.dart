import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../credentials.dart';

String spaceUuid = Credentials.spaceUuid;

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
    TradingResultList<PortfolioItem> items = await lm.getPortfolioItems(token, spaceUuid: spaceUuid,);
    print('found ${items.count} portfolioItems');
    items.result.forEach((element) {
      print(element);
    });
  });

  test('getLimitPortfolioItems', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<PortfolioItem> items = await lm.getPortfolioItems(token, spaceUuid: spaceUuid, limit: 2);
    print('found ${items.result.length} portfolioItems');
    expect(items.result.length, 2);
  });

  test('getPageLimitPortfolioItems', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<PortfolioItem> items = await lm.getPortfolioItems(token, spaceUuid: spaceUuid, limit: 3, page: 2);
    print('found ${items.result.length} portfolioItems');
    expect(items.result.length, 1);
  });
}
