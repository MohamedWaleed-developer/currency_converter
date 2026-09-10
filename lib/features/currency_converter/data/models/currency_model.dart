import '../../domain/entities/currency.dart';

class CurrencyModel {
  final String code;
  final double rate;

  CurrencyModel({
    required this.code,
    required this.rate,
  });

  factory CurrencyModel.fromJson(String code, dynamic rate) {
    return CurrencyModel(
      code: code,
      rate: (rate as num).toDouble(),
    );
  }
  Currency toEntity() {
    return Currency(
      code: code,
      rate: rate,
    );
  }
}