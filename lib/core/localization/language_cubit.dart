import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<String> {
  final SharedPreferences preferences;

  LanguageCubit(this.preferences)
      : super(
    preferences.getString('language') ?? 'ar',
  );

  Future<void> changeLanguage(String languageCode) async {
    await preferences.setString('language', languageCode);

    emit(languageCode);
  }
}