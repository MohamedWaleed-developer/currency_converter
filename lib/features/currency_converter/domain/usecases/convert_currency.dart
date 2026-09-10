import '../entities/currency.dart';

class ConvertCurrency {
  double call({
    required double amount,
    required Currency fromCurrency,
    required Currency toCurrency,
  }) {
    return (amount / fromCurrency.rate) * toCurrency.rate;
  }
}