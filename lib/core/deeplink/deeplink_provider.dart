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

    _sub = getLinksStream().listen((link) {
      // Shared link will have /#/ in web support
      final uri = Uri.parse(link.replaceFirst('/#/', '/'));
      print('deeplink uri $uri');
      final routeSetting = parseDeeplink(uri);
      print('deeplink result $uri: $routeSetting');
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
