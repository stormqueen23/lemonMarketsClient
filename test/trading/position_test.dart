import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../credentials.dart';

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

  test('getPerformance', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<PositionPerformance> result = await lm.getPositionPerformance(token, from: DateTime.now().add(Duration(days: -365)), to: DateTime.now()  );
    print(result);

  });

  test('getStatements', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    for(int i = 0; i < 400; i++) {
      TradingResultList<PositionStatement> result = await lm.getPositionStatements(token, isin: 'DE000A2JNWZ9', types: [PositionStatementType.order_buy]);
      print(result);
    }


  });

  test('getPositions', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<Position> items = await lm.getPositions(token);
    print('found ${items.count} positions');
    items.result.forEach((element) {
      print(element);
    });
  });

  test('getLimitPositions', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<Position> items = await lm.getPositions(token, limit: 2);
    print('found ${items.result.length} positions');
    expect(items.result.length, 2);
  });

  test('getPageLimitPosition', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<Position> items = await lm.getPositions(token, limit: 3, page: 2);
    print('found ${items.result.length} positions');
    expect(items.result.length, 1);
  });

  test('getAllPositions', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<Position> items = await lm.getPositions(token);
    print('found ${items.count} positions');
    items.result.forEach((element) {
      print(element);
    });
  });
}
