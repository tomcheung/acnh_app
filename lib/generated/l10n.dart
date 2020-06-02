// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get playerName {
    return Intl.message(
      'Player Name',
      name: 'playerName',
      desc: '',
      args: [],
    );
  }

  String get islandName {
    return Intl.message(
      'Island Name',
      name: 'islandName',
      desc: '',
      args: [],
    );
  }

  String get textFieldValidationEmpty {
    return Intl.message(
      'Cannot be blank',
      name: 'textFieldValidationEmpty',
      desc: '',
      args: [],
    );
  }

  String get pageTurnip {
    return Intl.message(
      'Turnip',
      name: 'pageTurnip',
      desc: '',
      args: [],
    );
  }

  String get pageFriends {
    return Intl.message(
      'Friends',
      name: 'pageFriends',
      desc: '',
      args: [],
    );
  }

  String get pageProfile {
    return Intl.message(
      'Profile',
      name: 'pageProfile',
      desc: '',
      args: [],
    );
  }

  String get loginPageTitle {
    return Intl.message(
      'Welcome',
      name: 'loginPageTitle',
      desc: '',
      args: [],
    );
  }

  String get loginPageExistingUser {
    return Intl.message(
      'Existing user?',
      name: 'loginPageExistingUser',
      desc: '',
      args: [],
    );
  }

  String get loginPagePinCode {
    return Intl.message(
      'Pin code for previous account',
      name: 'loginPagePinCode',
      desc: '',
      args: [],
    );
  }

  String get loginPagePinCodeHelpMessage {
    return Intl.message(
      'Pin code is 6 character code to identify your account, you can find this code in profile page from logged in device',
      name: 'loginPagePinCodeHelpMessage',
      desc: '',
      args: [],
    );
  }

  String get loginPageLogin {
    return Intl.message(
      'Login',
      name: 'loginPageLogin',
      desc: '',
      args: [],
    );
  }

  String get loginPageLoginErrorTitle {
    return Intl.message(
      'Login fail',
      name: 'loginPageLoginErrorTitle',
      desc: '',
      args: [],
    );
  }

  String get turnipPurchasePrice {
    return Intl.message(
      'Purchase Price',
      name: 'turnipPurchasePrice',
      desc: '',
      args: [],
    );
  }

  String get turnipPredictPrice {
    return Intl.message(
      'Predict Price',
      name: 'turnipPredictPrice',
      desc: '',
      args: [],
    );
  }

  String get turnipPredictPageTitle {
    return Intl.message(
      'Turnip Price Prediction',
      name: 'turnipPredictPageTitle',
      desc: '',
      args: [],
    );
  }

  String get profilePinCodeDescription {
    return Intl.message(
      'Pin code is a unique identifier associate with your account, you need to use this code if you want to login on other device / reinstall this app',
      name: 'profilePinCodeDescription',
      desc: '',
      args: [],
    );
  }

  String get profileLogout {
    return Intl.message(
      'Logout',
      name: 'profileLogout',
      desc: '',
      args: [],
    );
  }

  String get clearAllData {
    return Intl.message(
      'Clear all data',
      name: 'clearAllData',
      desc: '',
      args: [],
    );
  }

  String get cleardataalerTitle {
    return Intl.message(
      'Delete all data?',
      name: 'cleardataalerTitle',
      desc: '',
      args: [],
    );
  }

  String get clearDataAlerTitleMessage {
    return Intl.message(
      'This action cannot be recovered, are you sure for that?',
      name: 'clearDataAlerTitleMessage',
      desc: '',
      args: [],
    );
  }

  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  String get processing {
    return Intl.message(
      'Processing',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  String get fluctuating {
    return Intl.message(
      'Fluctuating',
      name: 'fluctuating',
      desc: '',
      args: [],
    );
  }

  String get smallSpike {
    return Intl.message(
      'Small Spike',
      name: 'smallSpike',
      desc: '',
      args: [],
    );
  }

  String get largeSpike {
    return Intl.message(
      'Large Spike',
      name: 'largeSpike',
      desc: '',
      args: [],
    );
  }

  String get decreasing {
    return Intl.message(
      'Decreasing',
      name: 'decreasing',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}