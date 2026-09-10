import '../../domain/entities/currency.dart';

abstract class CurrencyState {}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencySuccess extends CurrencyState {
  final List<Currency> currencies;
  final Currency? fromCurrency;
  final Currency? toCurrency;
  final double? result;

  CurrencySuccess({
    required this.currencies,
    this.fromCurrency,
    this.toCurrency,
    this.result,
  });
}

class CurrencyError extends CurrencyState {
  final String message;

  CurrencyError(this.message);
}