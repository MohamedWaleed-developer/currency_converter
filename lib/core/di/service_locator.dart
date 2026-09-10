import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/currency_converter/data/datasources/remote_data_source.dart';
import '../../features/currency_converter/data/repo/currency_repository_impl.dart';
import '../../features/currency_converter/domain/repo/currency_repository.dart';
import '../../features/currency_converter/domain/usecases/convert_currency.dart';
import '../../features/currency_converter/domain/usecases/get_currencies.dart';
import '../../features/currency_converter/presentation/cubit/currency_cubit.dart';

final sl = GetIt.instance;

void setupDependencies() {
  sl.registerLazySingleton<Dio>(
        () => Dio(),
  );

  sl.registerLazySingleton<CurrencyRemoteDataSource>(
        () => CurrencyRemoteDataSource(sl()),
  );

  sl.registerLazySingleton<CurrencyRepository>(
        () => CurrencyRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<GetCurrencies>(
        () => GetCurrencies(sl()),
  );

  sl.registerLazySingleton<ConvertCurrency>(
        () => ConvertCurrency(),
  );

  sl.registerFactory<CurrencyCubit>(
        () => CurrencyCubit(sl(), sl()),
  );
}