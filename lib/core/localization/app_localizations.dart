import 'package:flutter/material.dart';

import 'ar.dart';
import 'en.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    )!;
  }

  String get(String key) {
    final translations = locale.languageCode == 'ar' ? ar : en;

    return translations[key] ?? key;
  }

  String get appName => get('appName');
  String get appSubtitle => get('appSubtitle');
  String get tagline => get('tagline');

  String get currency => get('currency');
  String get description => get('description');

  String get amount => get('amount');
  String get enterAmount => get('enterAmount');

  String get from => get('from');
  String get to => get('to');

  String get selectCurrency => get('selectCurrency');
  String get searchCurrency => get('searchCurrency');
  String get noCurrencyFound => get('noCurrencyFound');

  String get convert => get('convert');
  String get conversionResult => get('conversionResult');
  String get exchangeRate => get('exchangeRate');

  String get lastUpdated => get('lastUpdated');
  String get updatedNow => get('updatedNow');

  String get somethingWentWrong => get('somethingWentWrong');
  String get checkConnection => get('checkConnection');
  String get retry => get('retry');

  String get chooseLanguage => get('chooseLanguage');
  String get arabic => get('arabic');
  String get english => get('english');

  String get preparing => get('preparing');
}

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ar', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return false;
  }
}