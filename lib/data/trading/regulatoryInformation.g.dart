// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regulatoryInformation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegulatoryInformation _$RegulatoryInformationFromJson(
        Map<String, dynamic> json) =>
    RegulatoryInformation(
      LemonMarketsAmountConverter.fromNullableAmount(
          json['costs_entry'] as int?),
      json['costs_entry_pct'] as String?,
      LemonMarketsAmountConverter.fromNullableAmount(
          json['costs_running'] as int?),
      json['costs_running_pct'] as String?,
      LemonMarketsAmountConverter.fromNullableAmount(
          json['costs_product'] as int?),
      json['costs_product_pct'] as String?,
      LemonMarketsAmountConverter.fromNullableAmount(
          json['costs_exit'] as int?),
      json['costs_exit_pct'] as String?,
      LemonMarketsAmountConverter.fromNullableAmount(
          json['yield_reduction_year'] as int?),
      json['yield_reduction_year_pct'] as String?,
      LemonMarketsAmountConverter.fromNullableAmount(
          json['yield_reduction_year_following'] as int?),
      json['yield_reduction_year_following_pct'] as String?,
      LemonMarketsAmountConverter.fromNullableAmount(
          json['yield_reduction_year_exit'] as int?),
      json['yield_reduction_year_exit_pct'] as String?,
      LemonMarketsAmountConverter.fromNullableAmount(
          json['estimated_yield_reduction_total'] as int?),
      json['estimated_yield_reduction_total_pct'] as String?,
      json['estimated_holding_duration_years'] as String?,
      json['KIID'] as String?,
      json['legal_disclaimer'] as String,
    );

Map<String, dynamic> _$RegulatoryInformationToJson(
        RegulatoryInformation instance) =>
    <String, dynamic>{
      'costs_entry':
          LemonMarketsAmountConverter.toNullableAmount(instance.costsEntry),
      'costs_entry_pct': instance.costsEntryPercent,
      'costs_running':
          LemonMarketsAmountConverter.toNullableAmount(instance.costsRunning),
      'costs_running_pct': instance.costsRunningPercent,
      'costs_product':
          LemonMarketsAmountConverter.toNullableAmount(instance.costsProduct),
      'costs_product_pct': instance.costsProductPercent,
      'costs_exit':
          LemonMarketsAmountConverter.toNullableAmount(instance.costsExit),
      'costs_exit_pct': instance.costsExitPercent,
      'yield_reduction_year': LemonMarketsAmountConverter.toNullableAmount(
          instance.yieldReductionYear),
      'yield_reduction_year_pct': instance.yieldReductionYearPercent,
      'yield_reduction_year_following':
          LemonMarketsAmountConverter.toNullableAmount(
              instance.yieldReductionYearFollowing),
      'yield_reduction_year_following_pct':
          instance.yieldReductionYearFollowingPercent,
      'yield_reduction_year_exit': LemonMarketsAmountConverter.toNullableAmount(
          instance.yieldReductionYearExit),
      'yield_reduction_year_exit_pct': instance.yieldReductionYearExitPercent,
      'estimated_yield_reduction_total':
          LemonMarketsAmountConverter.toNullableAmount(
              instance.estimatedYieldReductionTotal),
      'estimated_yield_reduction_total_pct':
          instance.estimatedYieldReductionTotalPercent,
      'estimated_holding_duration_years':
          instance.estimatedHoldingDurationYears,
      'KIID': instance.kiid,
      'legal_disclaimer': instance.legalDisclaimer,
    };
