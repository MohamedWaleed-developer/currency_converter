import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/currency_model.dart';

class CurrencyRemoteDataSource {
  final Dio dio;

  CurrencyRemoteDataSource(this.dio);

  Future<List<CurrencyModel>> getCurrencies() async {
    try {
      final response = await dio.get(
        ApiConstants.latestRatesUrl('USD'),
      );

      final rates =
      response.data['conversion_rates'] as Map<String, dynamic>;

      return rates.entries.map((entry) {
        return CurrencyModel.fromJson(
          entry.key,
          entry.value,
        );
      }).toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException();
      }

      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}