import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  static final FirebaseService instance = FirebaseService();

  FirebaseDatabase db;
  FirebaseAuth auth;
  FirebaseApp _app;

  void setup() async {
    _app = await FirebaseApp.appNamed(FirebaseApp.defaultAppName);

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
