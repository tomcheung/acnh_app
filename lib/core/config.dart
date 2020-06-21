import 'package:flutter/cupertino.dart';

class AppConfig {
  final String serverRoot;
  final String friendCodePrefix = 'ANH-';
  final String universalLinkHost = 'https://acnh-abb83.web.app';

  const AppConfig({@required this.serverRoot});

  static const _production = AppConfig(
    serverRoot: 'https://us-central1-acnh-abb83.cloudfunctions.net/api',
  );
}

const env = AppConfig._production;