import 'package:flutter_test/flutter_test.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/data/transaction.dart';
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

  // State -> Tansactions

  test('getTransactions', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Transaction> list = await lm.getTransactions(token, spaceUuid);
    expect(list.result.length, greaterThan(0));
    expect(list.result[0].createdAt.year, greaterThan(2020));
  });

  test('getTransaction', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    Transaction transaction = await lm.getTransaction(token, spaceUuid, transactionUuidPayIn);
    expect(transaction.order, null);
  });

  test('getTransactionsFromUntil', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    DateTime from = DateTime(2021, 6, 23, 9);
    DateTime until = DateTime(2021, 7, 15, 14, 3);
    ResultList<Transaction> list = await lm.getTransactions(token, spaceUuid, createdAtFrom: from, createdAtUntil: until);
    expect(list.result.length, 2);
  });

  test('getTransactionsFromURL', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    ResultList<Transaction> list = await lm.getTransactions(token, spaceUuid, limit: 1);
    expect(list.result.length, 1);
    expect(list.next, isNotNull);
    String nextUrl = list.next!;
    ResultList<Transaction> nextList = await lm.getTransactionsByURL(token, nextUrl);
    expect(nextList, isNotNull);
  });


}
