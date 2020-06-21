import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

import 'deeplink_parser.dart';

class DeeplinkProvider {
  final GlobalKey<NavigatorState> _navigatorKey;
  StreamSubscription _sub;

  DeeplinkProvider(this._navigatorKey);

  void initUniLink() {
    print('initUniLink');

    if (_sub != null) {
      print('DeeplinkProvider already subscript uri link');
    }

    _sub = getUriLinksStream().listen((uri) {
      print('deeplink $uri');
      final routeSetting = parseDeeplink(uri);
      if (routeSetting != null) {
        _navigatorKey.currentState.pushReplacementNamed(
          routeSetting.name,
          arguments: routeSetting.arguments,
        );
      }
    });
  }

  void dispose() async {
    await _sub.cancel();
  }
}
