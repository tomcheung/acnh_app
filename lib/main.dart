import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/firebase_service.dart';
import 'core/provider/account_provider.dart';
import 'generated/l10n.dart';
import 'page/friend/friend_page.dart';
import 'page/login/login_page.dart';
import 'page/profile/profile_page.dart';
import 'page/turnip/prediction/turnip_prediction_page.dart';
import 'page/turnip/turnip_page.dart';

void main() => runApp(AcnhApp());

class AcnhApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseService.instance.setup();

    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: AccountProvider())],
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: 'Animal crossing',
        // TODO: Move theme to separate file
        theme: ThemeData(
          cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          buttonColor: Color.fromARGB(255, 102, 184, 136),
          primarySwatch: Colors.green,
          primaryColorDark: Color.fromARGB(255, 0, 125, 117),
          backgroundColor: Color.fromARGB(255, 240, 255, 245),
          primaryTextTheme: TextTheme(
            subtitle2: TextStyle(
              color: Color.fromARGB(255, 0, 125, 117),
              fontWeight: FontWeight.bold,
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Color.fromARGB(255, 248, 244, 199),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 255, 235, 84),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 255, 235, 84),
              ),
            ),
          ),
        ),
        routes: {
          '/': (context) => RootPage(),
          '/profile': (context) => ProfilePage(),
          '/friend': (context) => FriendPage(),
          '/turnip/prediction': (context) => TurnipPredictionPage()
        },
      ),
    );
  }
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountProvider = context.watch<AccountProvider>();
    if (accountProvider.isLoading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return (accountProvider.currentUser == null)
          ? LoginPage()
          : TurnipHomePage();
    }
  }
}
