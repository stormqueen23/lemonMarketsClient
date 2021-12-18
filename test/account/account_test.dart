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

  //ACCOUNT
  test('getAccountData', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    Account data = await lm.getAccountData(token);
    expect(data, isNotNull);
    print('found account data for ${data.email}');
    print(data.toString());
  });

}