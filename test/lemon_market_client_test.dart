import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lemon_markets_client/data/portfolioTransactionList.dart';
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

  test('getTransactionsForPortfolio', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    PortfolioTransactionList list = await lm.getTransactionsForPortfolio(token, spaceUuid);
    expect(list.result.length, greaterThan(0));
  });

  test('getTransactionsForSpaceFromUntil', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    DateTime from = DateTime(2021, 6, 23, 9);
    double fromDouble = LemonMarketsTimeConverter.getDoubleTimeForDateTime(from);
    DateTime until = DateTime(2021, 7, 15, 14, 3);
    double untilDouble = LemonMarketsTimeConverter.getDoubleTimeForDateTime(until);
    TransactionList list = await lm.getTransactionsForSpace(token, spaceUuid, createdAtFrom: fromDouble.toInt(), createdAtUntil: untilDouble.toInt());
    expect(list.result.length, 2);
  });

  test('getTransactionsFromURL', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    TransactionList list = await lm.getTransactionsForSpace(token, spaceUuid, limit: 1);
    expect(list.result.length, 1);
    expect(list.next, isNotNull);
    String nextUrl = list.next!;
    TransactionList nextList = await lm.getTransactionsFromURL(token, nextUrl);
    expect(nextList, isNotNull);
  });

  test('getTransactionForSpace', () async {
    AccessToken token = await lm.requestToken(clientId, clientSecret);
    Transaction transaction = await lm.getTransactionForSpace(token, spaceUuid, transactionUuidPayIn);
    expect(transaction.order, null);
  });
}
