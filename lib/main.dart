import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies_app/features/onboarding/presentation/onboarding_Screen.dart';
import 'package:movies_app/features/register/presentation/register_screen.dart';
import 'core/bloc/locale/locale_bloc.dart';
import 'core/localization/app_localizations.dart';
import 'core/routes/AppRoutes.dart';
import 'features/Login/presentation/Login_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocaleBloc(),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movie App',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('ar')],
            locale: state.locale,
            builder: (context, child) {
              return Directionality(
                textDirection: state.locale.languageCode == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: child!,
              );
            },
            initialRoute: AppRoutes.onboarding,
            routes: {
              AppRoutes.onboarding: (context) => const OnboardingView(),
              AppRoutes.login: (context) => const LoginScreen(),
              AppRoutes.register: (context) => const RegisterScreen(),

            },
          );
        },
      ),
    );
  }
}
