import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../enums/enum.dart';
import '../shared/utils/local_storage_util.dart';

class AuthController with ChangeNotifier {
  static void initialize() {
    GetIt.instance.registerSingleton<AuthController>(AuthController());
  }

  static AuthController get instance => GetIt.instance<AuthController>();
  static AuthController get I => GetIt.instance<AuthController>();

  late StreamSubscription<User?> currentAuthedUser;

  AuthState state = AuthState.unauthenticated;
  SimulatedAPI api = SimulatedAPI();

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
    bool isLoggedIn = await api.login(userName, password);
    if (isLoggedIn) {
      await LocalStorage().saveSession(userName);
      state = AuthState.authenticated;
      notifyListeners();
      print("Login status: $isLoggedIn. Current State: $state");
    }
  }

  //* Log in with Google Provider
  loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //* Log out
  logout() {
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
