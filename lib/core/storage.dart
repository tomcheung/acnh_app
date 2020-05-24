import 'package:shared_preferences/shared_preferences.dart';
import 'model/player.dart';

class SharedPreferenceStore {
  static final SharedPreferenceStore instance = SharedPreferenceStore._();

  SharedPreferenceStore._();

  Future<Player> getUserData() async {
    final pref = await SharedPreferences.getInstance();

    var userKeys = pref.getKeys();
    userKeys.retainWhere((k) => k.startsWith('user.'));

    if (userKeys.isEmpty) {
      return null;
    }

    var map = <String, dynamic>{};

    for (var keyWithPrefix in userKeys) {
      final key = keyWithPrefix.replaceFirst('user.', '');
      map[key] = pref.getString(keyWithPrefix);
    }

    return Player.fromJson(map);
  }

  Future<bool> setUserData(Player user) async {
    final pref = await SharedPreferences.getInstance();

    if (user != null) {
      user.toJson().forEach((key, value) async {
        await pref.setString('user.$key', value);
      });
    } else {
      var userKeys = pref.getKeys();
      userKeys.retainWhere((k) => k.startsWith('user.'));
      for (var key in userKeys) {
        pref.remove(key);
      }
    }

    return true;
  }
}
