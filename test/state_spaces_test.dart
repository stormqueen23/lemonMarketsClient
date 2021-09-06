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

  // State -> Spaces

  test('getState', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    StateInfo spaces = await lm.getStateInfo(token);
    expect(spaces, isNotNull);
  });

  test('getSpaces', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Space> spaces = await lm.getSpaces(token);
    expect(spaces.result.length, 1);
    expect(spaces.result[0].uuid, spaceUuid);
  });

  test('getSpaceByUuid', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    Space result = await lm.getSpace(token, spaceUuid);
    expect(result, isNotNull);
  });

  test('getSpaceStateByUuid', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    SpaceState result = await lm.getSpaceState(token, spaceUuid);
    expect(result, isNotNull);
  });

}
