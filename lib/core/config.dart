import 'package:flutter/cupertino.dart';

class AppConfig {
  final String serverRoot;

  const AppConfig({@required this.serverRoot});

  static const _production = AppConfig(
      serverRoot: 'https://us-central1-acnh-abb83.cloudfunctions.net',
  );
}

final env = AppConfig._production;