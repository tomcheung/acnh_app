import 'dart:convert';

import '../model/player.dart';

class DeeplinkLoginData {
  static final stringToBase64 = utf8.fuse(base64);

  Player loginInfo;

  DeeplinkLoginData(this.loginInfo);

  factory DeeplinkLoginData.fromBase64String(String base64String) {
    var decoded = stringToBase64.decode(base64String);
    var json = jsonDecode(decoded);
    return DeeplinkLoginData(Player.fromJson(json));
  }

  String toBase64String() {
    final extractKey = {'playerName', 'islandName', 'pinCode'};
    final value = loginInfo.toJson();
    value.removeWhere((key, value) => !extractKey.contains(key));
    return stringToBase64.encode(jsonEncode(value));
  }
}