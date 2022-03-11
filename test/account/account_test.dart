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

  //ACCOUNT
  test('getAccountData', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResult<Account> data = await lm.getAccountData(token);
    expect(data.result, isNotNull);
    print('found account data for ${data.result!.email}');
    print(data.result.toString());
  });

  test('getDocumentsData', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<Document> data = await lm.getDocuments(token);
    data.result.forEach((element) {
      print(element.toString());
    });

  });

}