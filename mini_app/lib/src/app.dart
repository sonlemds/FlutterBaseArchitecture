import 'package:flutter/material.dart';
import 'package:mini_app/src/routes/app_router.dart';
import 'package:resources/resources.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MiniApp extends StatelessWidget {
  const MiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      restorationScopeId: 'mini-app',
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.codGray,
          primarySwatch: Colors.blue,
          fontFamily: AppFontFamily.poppins.font,
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: AppColors.white,
            errorStyle: TextStyle(height: 0),
            border: defaultInputBorder,
            focusedBorder: defaultInputBorder,
            errorBorder: defaultInputBorder,
          )),
      debugShowCheckedModeBanner: false,
      supportedLocales: AppLocalization.delegate.supportedLocales,
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide(color: AppColors.periwinkleGray, width: 1));