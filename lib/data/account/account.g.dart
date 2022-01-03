// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      LemonMarketsTimeConverter.fromIsoDay(json['created_at'] as String),
      json['firstname'] as String?,
      json['lastname'] as String?,
      json['email'] as String,
      json['phone'] as String?,
      json['address'] as String?,
      json['billing_address'] as String?,
      json['billing_email'] as String?,
      json['billing_name'] as String?,
      json['billing_vat'] as String?,
      LemonMarketsResultConverter.fromAccountMode(json['mode'] as String),
      json['deposit_id'] as String?,
      json['client_id'] as String?,
      json['account_number'] as String?,
      json['iban_brokerage'] as String?,
      json['iban_origin'] as String?,
      json['bank_name_origin'] as String?,
      LemonMarketsAmountConverter.fromAmount(json['balance'] as int),
      LemonMarketsAmountConverter.fromAmount(json['cash_to_invest'] as int),
      LemonMarketsAmountConverter.fromAmount(json['cash_to_withdraw'] as int),
      LemonMarketsResultConverter.fromAccountTradingPlan(
          json['trading_plan'] as String),
      LemonMarketsResultConverter.fromAccountDataPlan(
          json['data_plan'] as String),
      (json['tax_allowance'] as num?)?.toDouble(),
      json['tax_allowance_start'] as String?,
      json['tax_allowance_end'] as String?,
    )..uuid = json['account_id'] as String?;

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'account_id': instance.uuid,
      'created_at': LemonMarketsTimeConverter.toIsoDay(instance.createdAt),
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'billing_address': instance.billingAddress,
      'billing_email': instance.billingEmail,
      'billing_name': instance.billingName,
      'billing_vat': instance.billingVat,
      'mode': LemonMarketsResultConverter.toAccountMode(instance.mode),
      'deposit_id': instance.depositId,
      'client_id': instance.clientId,
      'account_number': instance.accountNumber,
      'iban_brokerage': instance.ibanBrokerage,
      'iban_origin': instance.ibanOrigin,
      'bank_name_origin': instance.bankNameOrigin,
      'balance': LemonMarketsAmountConverter.toAmount(instance.balance),
      'cash_to_invest':
          LemonMarketsAmountConverter.toAmount(instance.cashToInvest),
      'cash_to_withdraw':
          LemonMarketsAmountConverter.toAmount(instance.cashToWithdraw),
      'trading_plan': LemonMarketsResultConverter.toAccountTradingPlan(
          instance.tradingPlan),
      'data_plan':
          LemonMarketsResultConverter.toAccountDataPlan(instance.dataPlan),
      'tax_allowance': instance.taxAllowance,
      'tax_allowance_start': instance.taxAllowanceStart,
      'tax_allowance_end': instance.taxAllowanceEnd,
    };
