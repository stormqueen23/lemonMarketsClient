import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/amount.dart';
import 'package:lemon_markets_client/helper/lemonMarketsAmountConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsResultConverter.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';
import 'package:lemon_markets_client/src/lemonmarkets.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  @JsonKey(name: 'account_id')
  String? uuid;

  @JsonKey(
      name: 'created_at', fromJson: LemonMarketsTimeConverter.fromIsoDay, toJson: LemonMarketsTimeConverter.toIsoDay)
  DateTime createdAt;

  @JsonKey(
      name: 'approved_at', fromJson: LemonMarketsTimeConverter.fromIsoDayNullable, toJson: LemonMarketsTimeConverter.toIsoDayNullable)
  DateTime? approvedAt;

  @JsonKey(name: 'firstname')
  String? firstname;

  @JsonKey(name: 'lastname')
  String? lastname;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'billing_address')
  String? billingAddress;

  @JsonKey(name: 'billing_email')
  String? billingEmail;

  @JsonKey(name: 'billing_name')
  String? billingName;

  @JsonKey(name: 'billing_vat')
  String? billingVat;

  @JsonKey(
      name: 'mode',
      fromJson: LemonMarketsResultConverter.fromAccountMode,
      toJson: LemonMarketsResultConverter.toAccountMode)
  AccountMode mode;

  @JsonKey(name: 'deposit_id')
  String? depositId;

  @JsonKey(name: 'client_id')
  String? clientId;

  @JsonKey(name: 'account_number')
  String? accountNumber;

  @JsonKey(name: 'iban_brokerage')
  String? ibanBrokerage;

  @JsonKey(name: 'iban_origin')
  String? ibanOrigin;

  @JsonKey(name: 'bank_name_origin')
  String? bankNameOrigin;

  @JsonKey(
      name: 'balance', fromJson: LemonMarketsAmountConverter.fromAmount, toJson: LemonMarketsAmountConverter.toAmount)
  Amount balance;

  @JsonKey(
      name: 'cash_to_invest',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount cashToInvest;

  @JsonKey(
      name: 'cash_to_withdraw',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount cashToWithdraw;

  @JsonKey(
      name: 'trading_plan',
      fromJson: LemonMarketsResultConverter.fromAccountTradingPlan,
      toJson: LemonMarketsResultConverter.toAccountTradingPlan)
  TradingPlan tradingPlan;

  @JsonKey(
      name: 'data_plan',
      fromJson: LemonMarketsResultConverter.fromAccountDataPlan,
      toJson: LemonMarketsResultConverter.toAccountDataPlan)
  DataPlan dataPlan;


  @JsonKey(name: 'tax_allowance',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? taxAllowance;

  @JsonKey(name: 'tax_allowance_start')
  String? taxAllowanceStart;

  @JsonKey(name: 'tax_allowance_end')
  String? taxAllowanceEnd;

  @JsonKey(
      name: 'amount_bought_intraday',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount amountBoughtIntraday;

  @JsonKey(
      name: 'amount_sold_intraday',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount amountSoldIntraday;

  @JsonKey(
      name: 'amount_open_orders',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount amountOpenOrders;

  @JsonKey(
      name: 'amount_open_withdrawals',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount amountOpenWithdrawals;

  @JsonKey(
      name: 'amount_estimate_taxes',
      fromJson: LemonMarketsAmountConverter.fromAmount,
      toJson: LemonMarketsAmountConverter.toAmount)
  Amount amountEstimatedTaxes;

  Account(
      this.createdAt,
      this.approvedAt,
      this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.address,
      this.billingAddress,
      this.billingEmail,
      this.billingName,
      this.billingVat,
      this.mode,
      this.depositId,
      this.clientId,
      this.accountNumber,
      this.ibanBrokerage,
      this.ibanOrigin,
      this.bankNameOrigin,
      this.balance,
      this.cashToInvest,
      this.cashToWithdraw,
      this.tradingPlan,
      this.dataPlan,
      this.taxAllowance,
      this.taxAllowanceStart,
      this.taxAllowanceEnd,
      this.amountBoughtIntraday,
      this.amountEstimatedTaxes,
      this.amountOpenOrders,
      this.amountOpenWithdrawals,
      this.amountSoldIntraday);

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  @override
  String toString() {
    return 'Account{\n'
        'uuid: $uuid,\n'
        'createdAt: $createdAt,\n'
        'firstname: $firstname,\n'
        'lastname: $lastname,\n'
        'email: $email,\n'
        'phone: $phone,\n'
        'address: $address,\n'
        'billingAddress: $billingAddress,\n'
        'billingEmail: $billingEmail,\n'
        'billingName: $billingName,\n'
        'billingVat: $billingVat,\n'
        'mode: $mode,\n'
        'depositId: $depositId,\n'
        'clientId: $clientId,\n'
        'accountNumber: $accountNumber,\n'
        'ibanBrokerage: $ibanBrokerage,\n'
        'ibanOrigin: $ibanOrigin,\n'
        'bankNameOrigin: $bankNameOrigin,\n'
        'balance: $balance,\nc'
        'cashToInvest: $cashToInvest,\n'
        'cashToWithdraw: $cashToWithdraw,\n'
        'amountBoughtIntraday: $amountBoughtIntraday,\n'
        'amountSoldIntraday: $amountSoldIntraday,\n'
        'amountOpenOrders: $amountOpenOrders,\n'
        'amountOpenWithdrawals: $amountOpenWithdrawals,\n'
        'amountEstimatedTaxes: $amountEstimatedTaxes,\n'
        'tradingPlan: $tradingPlan,\n'
        'dataPlan: $dataPlan,\n'
        'taxAllowance: $taxAllowance,\n'
        'taxAllowanceStart: $taxAllowanceStart,\n'
        'taxAllowanceEnd: $taxAllowanceEnd\n'
        '}';
  }
}
