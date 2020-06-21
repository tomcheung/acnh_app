// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Player Name`
  String get playerName {
    return Intl.message(
      'Player Name',
      name: 'playerName',
      desc: '',
      args: [],
    );
  }

  /// `Island Name`
  String get islandName {
    return Intl.message(
      'Island Name',
      name: 'islandName',
      desc: '',
      args: [],
    );
  }

  /// `Cannot be blank`
  String get textFieldValidationEmpty {
    return Intl.message(
      'Cannot be blank',
      name: 'textFieldValidationEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Turnip`
  String get pageTurnip {
    return Intl.message(
      'Turnip',
      name: 'pageTurnip',
      desc: '',
      args: [],
    );
  }

  /// `Friends`
  String get pageFriends {
    return Intl.message(
      'Friends',
      name: 'pageFriends',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get pageProfile {
    return Intl.message(
      'Profile',
      name: 'pageProfile',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get loginPageTitle {
    return Intl.message(
      'Welcome',
      name: 'loginPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Existing user?`
  String get loginPageExistingUser {
    return Intl.message(
      'Existing user?',
      name: 'loginPageExistingUser',
      desc: '',
      args: [],
    );
  }

  /// `Pin code for previous account`
  String get loginPagePinCode {
    return Intl.message(
      'Pin code for previous account',
      name: 'loginPagePinCode',
      desc: '',
      args: [],
    );
  }

  /// `Pin code is 6 character code to identify your account, you can find this code in profile page from logged in device`
  String get loginPagePinCodeHelpMessage {
    return Intl.message(
      'Pin code is 6 character code to identify your account, you can find this code in profile page from logged in device',
      name: 'loginPagePinCodeHelpMessage',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginPageLogin {
    return Intl.message(
      'Login',
      name: 'loginPageLogin',
      desc: '',
      args: [],
    );
  }

  /// `Login fail`
  String get loginPageLoginErrorTitle {
    return Intl.message(
      'Login fail',
      name: 'loginPageLoginErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Price`
  String get turnipPurchasePrice {
    return Intl.message(
      'Purchase Price',
      name: 'turnipPurchasePrice',
      desc: '',
      args: [],
    );
  }

  /// `Predict Price`
  String get turnipPredictPrice {
    return Intl.message(
      'Predict Price',
      name: 'turnipPredictPrice',
      desc: '',
      args: [],
    );
  }

  /// `Turnip Price Prediction`
  String get turnipPredictPageTitle {
    return Intl.message(
      'Turnip Price Prediction',
      name: 'turnipPredictPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pin code is a unique identifier associate with your account, you need to use this code if you want to login on other device / reinstall this app`
  String get profilePinCodeDescription {
    return Intl.message(
      'Pin code is a unique identifier associate with your account, you need to use this code if you want to login on other device / reinstall this app',
      name: 'profilePinCodeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get profileLogout {
    return Intl.message(
      'Logout',
      name: 'profileLogout',
      desc: '',
      args: [],
    );
  }

  /// `Clear all data`
  String get clearAllData {
    return Intl.message(
      'Clear all data',
      name: 'clearAllData',
      desc: '',
      args: [],
    );
  }

  /// `Delete all data?`
  String get cleardataalerTitle {
    return Intl.message(
      'Delete all data?',
      name: 'cleardataalerTitle',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be recovered, are you sure for that?`
  String get clearDataAlerTitleMessage {
    return Intl.message(
      'This action cannot be recovered, are you sure for that?',
      name: 'clearDataAlerTitleMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processing {
    return Intl.message(
      'Processing',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Fluctuating`
  String get fluctuating {
    return Intl.message(
      'Fluctuating',
      name: 'fluctuating',
      desc: '',
      args: [],
    );
  }

  /// `Small Spike`
  String get smallSpike {
    return Intl.message(
      'Small Spike',
      name: 'smallSpike',
      desc: '',
      args: [],
    );
  }

  /// `Large Spike`
  String get largeSpike {
    return Intl.message(
      'Large Spike',
      name: 'largeSpike',
      desc: '',
      args: [],
    );
  }

  /// `Decreasing`
  String get decreasing {
    return Intl.message(
      'Decreasing',
      name: 'decreasing',
      desc: '',
      args: [],
    );
  }

  /// `Copy login magic link`
  String get copyLoginMagicLink {
    return Intl.message(
      'Copy login magic link',
      name: 'copyLoginMagicLink',
      desc: '',
      args: [],
    );
  }

  /// `Magic link copied`
  String get magicLinkCopiedTitle {
    return Intl.message(
      'Magic link copied',
      name: 'magicLinkCopiedTitle',
      desc: '',
      args: [],
    );
  }

  /// `You can use this link to login in other device`
  String get magicLinkCopiedMessage {
    return Intl.message(
      'You can use this link to login in other device',
      name: 'magicLinkCopiedMessage',
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