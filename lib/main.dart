import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/service_locator.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/language_cubit.dart';
import 'features/currency_converter/presentation/cubit/currency_cubit.dart';
import 'features/currency_converter/presentation/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();

  setupDependencies();

  runApp(
    ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => LanguageCubit(preferences),
            ),
            BlocProvider(
              create: (_) => sl<CurrencyCubit>()..fetchCurrencies(),
            ),
          ],
          child: MyApp(),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, String>(
      builder: (context, languageCode) {
        final locale = Locale(languageCode);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tahwila',
          locale: locale,
          supportedLocales: [
            Locale('ar'),
            Locale('en'),
          ],
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Arial',
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}