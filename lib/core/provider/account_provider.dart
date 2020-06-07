import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../firebase_service.dart';
import '../model/player.dart';
import '../storage.dart';

class SigninError extends Error {
  final String message;

//  Exception httpError

  SigninError(this.message);
}

class AccountProvider extends ChangeNotifier {
  Player _userData;

  Player get currentUser => _userData;

  AccountProvider() {
    _fetch();
  }

  void _fetch() async {
    _userData = await SharedPreferenceStore.instance.getUserData();
    if (_userData != null) {
      signin(_userData);
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await SharedPreferenceStore.instance.setUserData(null);
    _userData = null;
    await FirebaseService.instance.signOut();
    notifyListeners();
  }

  Future<Player> signin(Player userData) async {
    print(userData.toJson());
    final response = await http.post(
      '${env.serverRoot}/v1/user',
      body: userData.toJson(),
    );

    print('Sign api response: ${response.body}');
    Player userResponse;

    if (response.statusCode == 200) {
      userResponse = Player.fromJson(jsonDecode(response.body));
    }

    if (userResponse?.playerName != null || userResponse?.islandName != null) {
      _userData = userResponse;
      await SharedPreferenceStore.instance.setUserData(_userData);

      final authResult =
          await FirebaseService.instance.signIn(userResponse.fbToken);
      print('SignIn firebase $authResult');

      notifyListeners();
      return _userData;
    } else {
      throw SigninError('Invalid login info');
    }
  }
}
