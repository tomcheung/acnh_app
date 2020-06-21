import 'package:flutter/material.dart';

import 'deeplink_data.dart';

RouteSettings parseDeeplink(Uri uri) {
  if (uri.pathSegments.isEmpty) {
    return null;
  }
  var routeNanme = uri.pathSegments[0];
  if (routeNanme == '#') {
    routeNanme = uri.pathSegments[1];
  }

  print('parseDeeplink $routeNanme');

  switch (routeNanme) {
    case 'login':
      return _parseLoginDeeplink(uri);
    default:
      return null;
  }
}

RouteSettings _parseLoginDeeplink(Uri uri) {
  final token = uri.queryParameters['token'];
  if (token == null) {
    print('Parse login info error: token is missing');
    return null;
  }

  print('deeplink login $token');

  try {
    final loginData = DeeplinkLoginData.fromBase64String(token);
    return RouteSettings(name: '/', arguments: loginData);
  } on Exception catch (e) {
    print('Parse login info error: ${e.toString()}');
    return null;
  }
}