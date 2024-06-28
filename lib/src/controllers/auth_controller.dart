import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../enums/enum.dart';

class AuthController with ChangeNotifier {
  static void initialize() {
    GetIt.instance.registerSingleton<AuthController>(AuthController());
  }

  static AuthController get instance => GetIt.instance<AuthController>();
  static AuthController get I => GetIt.instance<AuthController>();

  late StreamSubscription<User?> currentAuthedUser;

  AuthState state = AuthState.unauthenticated;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  listen() {
    currentAuthedUser =
        FirebaseAuth.instance.authStateChanges().listen(handleUserChanges);
  }

  void handleUserChanges(User? user) {
    print("handleUserChanges: ${user?.email}, ${user?.displayName}");
    if (user == null) {
      state = AuthState.unauthenticated;
    } else {
      state = AuthState.authenticated;
    }
    print("State: $state");
    notifyListeners();
  }

  //* Log in using email and password
  login(String userName, String password) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: userName, password: password);
  }

  //* Register using email and password
  register(String userName, String password) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: userName, password: password);
  }

  //* Log in with Google Provider
  loginWithGoogle() async {
    GoogleSignInAccount? gSign = await _googleSignIn.signIn();

    if (gSign == null) throw Exception("No Signed In Account");

    GoogleSignInAuthentication googleAuth = await gSign.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseAuth.instance.signInWithCredential(credential);
  }

  //* Log out
  logout() {
    if (_googleSignIn.currentUser != null) {
      _googleSignIn.signOut();
    }
    return FirebaseAuth.instance.signOut();
  }

  //* Load Session
  loadSession() async {
    listen();
    User? user = FirebaseAuth.instance.currentUser;
    handleUserChanges(user);
  }

  @override
  void dispose() {
    currentAuthedUser.cancel();
    super.dispose();
  }
}

class SimulatedAPI {
  Map<String, String> users = {"testUser": "123456789ABCabc!"};

  Future<bool> login(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 4));
    if (users[userName] == null) throw Exception("User does not exist");
    if (users[userName] != password) throw Exception("password does not match");
    return users[userName] == password;
  }
}
