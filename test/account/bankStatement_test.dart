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

  //Bank statements
  test('getBankStatements', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<BankStatement> data = await lm.getBankStatements(token);
    expect(data, isNotNull);
    print('found bank statements: #${data.count}');
    data.result.forEach((element) {
      print(element.toString());
    });
  });

  //Bank statements
  test('getFromToBankStatements', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    DateTime from = DateTime.now().add(Duration(days: -10));
    DateTime to = DateTime.now();
    TradingResultList<BankStatement> data = await lm.getBankStatements(token, from: from, to: to);
    expect(data, isNotNull);
    print('found bank statements: #${data.count}');
    data.result.forEach((element) {
      print(element.toString());
    });
  });

  //Bank statements
  test('getTypeBankStatements', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    DateTime from = DateTime.now().add(Duration(days: -10));
    DateTime to = DateTime.now();
    BankStatementType type = BankStatementType.endOfDayBalance;
    TradingResultList<BankStatement> data = await lm.getBankStatements(token, from: from, to: to, type: type);
    expect(data, isNotNull);
    print('found bank statements: #${data.count}');
    data.result.forEach((element) {
      expect(BankStatementType.endOfDayBalance, element.type);
    });
  });

  //Bank statements
  test('getAllBankStatements', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    DateTime from = DateTime.now().add(Duration(days: -10));
    DateTime to = DateTime.now();
    TradingResultList<BankStatement> data = await lm.getBankStatements(token, from: from, to: to);
    expect(data, isNotNull);
    print('found bank statements: #${data.count}');
    data.result.forEach((element) {
      print(element);
    });
  });

}