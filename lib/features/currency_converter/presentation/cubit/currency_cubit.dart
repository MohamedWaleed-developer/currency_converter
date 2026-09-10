import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/currency.dart';
import '../../domain/usecases/convert_currency.dart';
import '../../domain/usecases/get_currencies.dart';
import 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final GetCurrencies getCurrencies;
  final ConvertCurrency convertCurrency;

  CurrencyCubit(
      this.getCurrencies,
      this.convertCurrency,
      ) : super(CurrencyInitial());

  Future<void> fetchCurrencies() async {
    emit(CurrencyLoading());

    try {
      final currencies = await getCurrencies();

      Currency? fromCurrency;
      Currency? toCurrency;

      for (final currency in currencies) {
        if (currency.code == 'USD') {
          fromCurrency = currency;
        }

        if (currency.code == 'EGP') {
          toCurrency = currency;
        }
      }

      emit(
        CurrencySuccess(
          currencies: currencies,
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
        ),
      );
    } on Failure catch (failure) {
      emit(
        CurrencyError(
          failure.message,
        ),
      );
    } catch (_) {
      emit(
        CurrencyError(
          'somethingWentWrong',
        ),
      );
    }
  }

  void selectFromCurrency(Currency currency) {
    final currentState = state;

    if (currentState is! CurrencySuccess) return;

    emit(
      CurrencySuccess(
        currencies: currentState.currencies,
        fromCurrency: currency,
        toCurrency: currentState.toCurrency,
        result: null,
      ),
    );
  }

  void selectToCurrency(Currency currency) {
    final currentState = state;

    if (currentState is! CurrencySuccess) return;

    emit(
      CurrencySuccess(
        currencies: currentState.currencies,
        fromCurrency: currentState.fromCurrency,
        toCurrency: currency,
        result: null,
      ),
    );
  }

  void swapCurrencies() {
    final currentState = state;

    if (currentState is! CurrencySuccess) return;

    emit(
      CurrencySuccess(
        currencies: currentState.currencies,
        fromCurrency: currentState.toCurrency,
        toCurrency: currentState.fromCurrency,
        result: null,
      ),
    );
  }

  void convert(String amountText) {
    final currentState = state;

    if (currentState is! CurrencySuccess) return;

    final amount = double.tryParse(amountText);

    if (amount == null || amount <= 0) {
      emit(
        CurrencySuccess(
          currencies: currentState.currencies,
          fromCurrency: currentState.fromCurrency,
          toCurrency: currentState.toCurrency,
          result: null,
        ),
      );
      return;
    }

    final fromCurrency = currentState.fromCurrency;
    final toCurrency = currentState.toCurrency;

    if (fromCurrency == null || toCurrency == null) return;

    final result = convertCurrency(
      amount: amount,
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
    );

    emit(
      CurrencySuccess(
        currencies: currentState.currencies,
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        result: result,
      ),
    );
  }
}