import 'package:lemon_markets_client/data/trading/transaction.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';
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

  test('getTransactions', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    TradingResultList<Transaction> response = await lm.getTransactions(token);
    print('get transactions: ${response.status} (${response.result.length})');
    response.result.forEach((element) {
      print('${element.type.toString()} ${element.isin}: ${element.amount.displayValue} - ${element.uuid} space: ${element.spaceId}');
    });
  });

  test('getSingleTransactions', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    // transaction pay_in --> {"status":"error","error_type":"does_not_exist","error_message":"Invalid 'transaction_id' (does not exist)"}
    Transaction transaction = await lm.getTransaction(token, 'tx_pyPLKHHVV3Xnknx729xPxZj8YHh6Xt8cLX');
    print('found transaction ${transaction.uuid}');
    print(transaction);
  });

  test('getSpaceTransactions', () async {
    AccessToken token = AccessToken(token: Credentials.JWT_TOKEN);
    // transaction pay_in --> {"status":"error","error_type":"does_not_exist","error_message":"Invalid 'transaction_id' (does not exist)"}
    TradingResultList<Transaction> response = await lm.getTransactions(token, spaceUuid: Credentials.default_space_uuid);
    print('found ${response.result.length} transaction');
    response.result.forEach((element) {
      print('${element.createdAt} uuid: ${element.uuid} space: ${element.spaceId} ${element.isin} orderUuid: ${element.orderId}');
    });
  });
}
