import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/amount.dart';
import 'package:lemon_markets_client/helper/lemonMarketsAmountConverter.dart';

part 'regulatoryInformation.g.dart';

@JsonSerializable()
class RegulatoryInformation {

  @JsonKey(name: 'costs_entry',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? costsEntry;
  @JsonKey(name: 'costs_entry_pct')
  String? costsEntryPercent;

  @JsonKey(name: 'costs_running',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? costsRunning;
  @JsonKey(name: 'costs_running_pct')
  String? costsRunningPercent;

  @JsonKey(name: 'costs_product',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? costsProduct;
  @JsonKey(name: 'costs_product_pct')
  String? costsProductPercent;

  @JsonKey(name: 'costs_exit',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? costsExit;
  @JsonKey(name: 'costs_exit_pct')
  String? costsExitPercent;

  @JsonKey(name: 'yield_reduction_year',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? yieldReductionYear;
  @JsonKey(name: 'yield_reduction_year_pct')
  String? yieldReductionYearPercent;

  @JsonKey(name: 'yield_reduction_year_following',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? yieldReductionYearFollowing;
  @JsonKey(name: 'yield_reduction_year_following_pct')
  String? yieldReductionYearFollowingPercent;

  @JsonKey(name: 'yield_reduction_year_exit',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? yieldReductionYearExit;
  @JsonKey(name: 'yield_reduction_year_exit_pct')
  String? yieldReductionYearExitPercent;

  @JsonKey(name: 'estimated_yield_reduction_total',
      fromJson: LemonMarketsAmountConverter.fromNullableAmount,
      toJson: LemonMarketsAmountConverter.toNullableAmount)
  Amount? estimatedYieldReductionTotal;
  @JsonKey(name: 'estimated_yield_reduction_total_pct')
  String? estimatedYieldReductionTotalPercent;

  @JsonKey(name: 'estimated_holding_duration_years')
  String? estimatedHoldingDurationYears;

  @JsonKey(name: 'KIID')
  String? kiid;

  @JsonKey(name: 'legal_disclaimer')
  String legalDisclaimer;

  RegulatoryInformation(
      this.costsEntry,
      this.costsEntryPercent,
      this.costsRunning,
      this.costsRunningPercent,
      this.costsProduct,
      this.costsProductPercent,
      this.costsExit,
      this.costsExitPercent,
      this.yieldReductionYear,
      this.yieldReductionYearPercent,
      this.yieldReductionYearFollowing,
      this.yieldReductionYearFollowingPercent,
      this.yieldReductionYearExit,
      this.yieldReductionYearExitPercent,
      this.estimatedYieldReductionTotal,
      this.estimatedYieldReductionTotalPercent,
      this.estimatedHoldingDurationYears,
      this.kiid,
      this.legalDisclaimer);

  factory RegulatoryInformation.fromJson(Map<String, dynamic> json) => _$RegulatoryInformationFromJson(json);

  Map<String, dynamic> toJson() => _$RegulatoryInformationToJson(this);

  @override
  String toString() {
    return 'RegulatoryInformation{\n'
        'costsEntry: $costsEntry,\n'
        'costsEntryPercent: $costsEntryPercent,\n'
        'costsRunning: $costsRunning,\n'
        'costsRunningPercent: $costsRunningPercent,\n'
        'costsProduct: $costsProduct,\n'
        'costsProductPercent: $costsProductPercent,\n'
        'costsExit: $costsExit,\n'
        'costsExitPercent: $costsExitPercent,\n'
        'yieldReductionYear: $yieldReductionYear,\n'
        'yieldReductionYearPercent: $yieldReductionYearPercent,\n'
        'yieldReductionYearFollowing: $yieldReductionYearFollowing,\n'
        'yieldReductionYearFollowingPercent: $yieldReductionYearFollowingPercent,\n'
        'yieldReductionYearExit: $yieldReductionYearExit,\n'
        'yieldReductionYearExitPercent: $yieldReductionYearExitPercent,\n'
        'estimatedYieldReductionTotal: $estimatedYieldReductionTotal,\n'
        'estimatedYieldReductionTotalPercent: $estimatedYieldReductionTotalPercent,\n'
        'estimatedHoldingDurationYears: $estimatedHoldingDurationYears,\n'
        'kiid: $kiid,\n'
        'legalDisclaimer: $legalDisclaimer\n'
        '}';
  }
}
