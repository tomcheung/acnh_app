import 'package:flutter/material.dart';

import '../../page/friend/friend_page.dart';
import 'deeplink_data.dart';

RouteSettings parseDeeplink(Uri uri) {
  if (uri.pathSegments.isEmpty) {
    return null;
  }
  var routeNanme = uri.pathSegments[0];

  print('parseDeeplink $routeNanme');

  switch (routeNanme) {
    case 'login':
      return _parseLoginDeeplink(uri);
    case 'friend':
      return _parseFriendDeeplink(uri);
    default:
      return null;
  }
}

RouteSettings _parseFriendDeeplink(Uri uri) {
  final friendId = uri.queryParameters['friend_id'];
  if (friendId == null) {
    print('add friend from deeplink error: friend_id is missing');
    return null;
  }

  return RouteSettings(
    name: FriendPage.routeName,
    arguments: DeeplinkFriendAddData(friendId),
  );
}

RouteSettings _parseLoginDeeplink(Uri uri) {
  final token = uri.queryParameters['token'];
  if (token == null) {
    print('Parse login info error: token is missing');
    return null;
  }

  try {
    final loginData = DeeplinkLoginData.fromBase64String(token);
    return RouteSettings(name: '/', arguments: loginData);
  } on Exception catch (e) {
    print('Parse login info error: ${e.toString()}');
    return null;
  }
}
