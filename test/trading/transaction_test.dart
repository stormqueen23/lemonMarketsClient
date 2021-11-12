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
    AccessToken token = AccessToken(Credentials.JWT_TOKEN, 1, '', 'bearer');
    TradingResultList<Transaction> response = await lm.getTransactions(token);
    print('get transactions: ${response.status} (${response.result.length})');
    response.result.forEach((element) {
      print('${element.type.toString()} ${element.isin}: ${element.amount.displayValue} - ${element.uuid}');
    });
  });

  test('getSingleTransactions', () async {
    AccessToken token = AccessToken(Credentials.JWT_TOKEN, 1, '', 'bearer');
    // transaction pay_in --> {"status":"error","error_type":"does_not_exist","error_message":"Invalid 'transaction_id' (does not exist)"}
    Transaction transaction = await lm.getTransaction(token, 'tx_pyPLKHHVV3Xnknx729xPxZj8YHh6Xt8cLX');
    print('found transaction ${transaction.uuid}');
    print(transaction);
  });
}
