import '../entities/currency.dart';
import '../repo/currency_repository.dart';

class GetCurrencies {
  final CurrencyRepository repository;

  GetCurrencies(this.repository);

  Future<List<Currency>> call() {
    return repository.getCurrencies();
  }
}