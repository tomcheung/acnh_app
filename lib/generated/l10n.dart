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