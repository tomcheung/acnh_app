import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static final FirebaseService instance = FirebaseService();

//FIXME: Update iOS firebase setting
//  const FirebaseOptions(
//    googleAppID: '1:297855924061:ios:c6de2b69b03a5be8',
//    gcmSenderID: '297855924061',
//    databaseURL: 'https://acnh-abb83.firebaseio.com/',
//  );
  final FirebaseOptions firebaseOptions = const FirebaseOptions(
    googleAppID: '1:1050357309254:android:092107aa8a82f8e566cf47',
    apiKey: 'AIzaSyC7svGGm06VYhEUJdwMRaH2PGoLDGDVpz0',
    databaseURL: 'https://acnh-abb83.firebaseio.com/',
  );

  FirebaseDatabase db;
  FirebaseAuth auth;
  FirebaseApp _app;

  void setup() async {
    _app = await FirebaseApp.configure(name: 'acnh', options: firebaseOptions);
    db = FirebaseDatabase(app: _app);
    auth = FirebaseAuth.fromApp(_app);
    db.setPersistenceEnabled(true);
  }

  Future<AuthResult> signIn(String token) async {
    return await FirebaseAuth.fromApp(_app).signInWithCustomToken(token: token);
  }

  Future<void> signOut() async {
    return await FirebaseAuth.fromApp(_app).signOut();
  }

  Future<String> getInstanceId() async {
    final firebaseUser = await FirebaseAuth.fromApp(_app).currentUser();
    final token = await firebaseUser.getIdToken();
    return token?.token;
  }
}
