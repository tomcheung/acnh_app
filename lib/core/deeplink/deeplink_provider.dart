import 'dart:async';

import 'package:acnhpal/core/deeplink/deeplink_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class DeeplinkProvider {
  GlobalKey<NavigatorState> _navigatorKey;
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
