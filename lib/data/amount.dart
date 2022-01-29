import 'dart:math';

class Amount {
  int scale = 4;

  String currency;

  late int apiValue;
  late double value;

  /// [apiValue] is the value for the lemonMarkesAPI<br/>
  /// [value] is the value in the currency<br/><br/>
  /// eg.: creating an Amount with 2.50€<br/>
  /// Amount(apiValue: 2500) or <br/>
  /// Amount(value: 2.5)
  Amount({int? apiValue, double? value, this.currency = '€'}) {
    if (apiValue != null) {
      this.apiValue = apiValue;
      this.value = apiValue / (max(1, pow(10, scale)));
    } else if (value != null) {
      this.value = value;
      this.apiValue = (value * (max(1, pow(10, scale)))).floor();
    }

  }

 String get displayValue => value.toStringAsFixed(2)+' '+currency;

  @override
  String toString() {
    return '$displayValue ($apiValue)';
  }

  Amount multiply(num value) {
    return Amount(apiValue: (value*apiValue).round());
  }

  Amount divide(num value) {
    return Amount(apiValue: (apiValue/value).round());
  }

  Amount addAmount(Amount value) {
    return Amount(apiValue: apiValue+value.apiValue);
  }

  Amount subtractAmount(Amount value) {
    return Amount(apiValue: apiValue-value.apiValue);
  }

  static Amount zero() {
    return Amount(apiValue: 0);
  }
}