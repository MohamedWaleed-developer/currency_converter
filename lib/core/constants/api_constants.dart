class ApiConstants {
  static const String apiKey = '839a6021d8f74c75b71b1123';

  static const String baseUrl =
      'https://v6.exchangerate-api.com/v6';

  static String latestRatesUrl(String baseCurrency) {
    return '$baseUrl/$apiKey/latest/$baseCurrency';
  }
}