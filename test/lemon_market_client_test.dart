import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lemon_markets_client/data/transaction.dart';
import 'package:lemon_markets_client/data/transactionList.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

import 'credentials.dart';


String clientId = Credentials.clientId;
String clientSecret = Credentials.clientSecret;
String spaceUuid = Credentials.spaceUuid;
String transactionUuidPayIn = Credentials.transactionUuidPayIn;

final LemonMarkets lm = LemonMarkets();

void main() {
  test('getSpaces', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    List<Space> spaces = await lm.getSpaces(token);
    expect(spaces.length, 1);
    expect(spaces[0].uuid, spaceUuid);
  });

  test('getTransactionsForSpace', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    TransactionList list = await lm.getTransactionsForSpace(token, spaceUuid);
    expect(list.result.length, greaterThan(0));
  });

  test('getTransactionForSpace', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    Transaction transaction = await lm.getTransactionForSpace(token, spaceUuid, transactionUuidPayIn);
    expect(transaction.order, null);
  });
}
