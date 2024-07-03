import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../enums/enum.dart';
import '../shared/services/user_service.dart';

class AuthController with ChangeNotifier {
  static void initialize() {
    GetIt.instance.registerSingleton<AuthController>(AuthController());
  }

  static AuthController get instance => GetIt.instance<AuthController>();
  static AuthController get I => GetIt.instance<AuthController>();

  late StreamSubscription<User?> currentAuthedUser;
  final UserFirestoreService _userService =
      GetIt.instance<UserFirestoreService>();

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
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: userName, password: password);

    User? user = userCredential.user;

    if (user != null) {
      _userService.createUserProfile();
      print(
          "Login successful: ${user.email}, ${user.displayName ?? "No Display Name"}");
    }
  }

  //* Register using email and password
  register(String userName, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: userName, password: password);

    User? user = userCredential.user;

    if (user != null) {
      _userService.createUserProfile();
      print(
          "Login successful: ${user.email}, ${user.displayName ?? "No Display Name"}");
    }
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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        _userService.createUserProfile();
        print("Login successful: ${user.email}, ${user.displayName}");
      }
    });
  }

  //* Log out
  logout() {
    print("Current User: ${_googleSignIn.currentUser}");
    if (_googleSignIn.currentUser != null) {
      _googleSignIn.signOut();
      print("Signed out: ${_googleSignIn.currentUser}");
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
