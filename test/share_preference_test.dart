import 'package:acnhpal/core/model/player.dart';
import 'package:acnhpal/core/storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('User should be save to share preference', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});

    final pref = SharedPreferenceStore.instance;
    final mockUser = Player(
        playerName: 'Test user ${DateTime.now()}',
        islandName: 'Test island',
        pinCode: '1234',
        fbToken: 'hg98hg982390gj209hj2490hja');

    await pref.setUserData(mockUser);
    final userFromPref = await pref.getUserData();

    expect(userFromPref.toJson(), mockUser.toJson());
  });
}
