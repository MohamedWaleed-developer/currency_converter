import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/currency.dart';
import '../../domain/repo/currency_repository.dart';
import '../datasources/remote_data_source.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDataSource remoteDataSource;

  CurrencyRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Currency>> getCurrencies() async {
    try {
      final models = await remoteDataSource.getCurrencies();

      return models.map((model) {
        return model.toEntity();
      }).toList();
    } on NetworkException {
      throw NetworkFailure(
        'checkConnection',
      );
    } on ServerException {
      throw ServerFailure(
        'somethingWentWrong',
      );
    }
  }
}