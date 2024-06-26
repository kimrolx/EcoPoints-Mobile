import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../enums/enum.dart';
import '../shared/utils/local_storage_util.dart';

class AuthController with ChangeNotifier {
  static void initialize() {
    GetIt.instance.registerSingleton<AuthController>(AuthController());
  }

  static AuthController get instance => GetIt.instance<AuthController>();
  static AuthController get I => GetIt.instance<AuthController>();

  AuthState state = AuthState.unauthenticated;
  SimulatedAPI api = SimulatedAPI();

  AuthController() {
    loadSession();
  }

  //* Log in
  login(String userName, String password) async {
    bool isLoggedIn = await api.login(userName, password);
    if (isLoggedIn) {
      await LocalStorage().saveSession(userName);
      state = AuthState.authenticated;
      notifyListeners();
      print("Login status: $isLoggedIn. Current State: $state");
    }
  }

  //* Log out
  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 2));
    state = AuthState.unauthenticated;
    notifyListeners();
    await LocalStorage().clearSession();
    print("Logged out...");
    print("Session cleared, state reset to unauthenticated");
  }

  //* Load Session
  Future<void> loadSession() async {
    String? userName = await LocalStorage().loadSession();
    if (userName != null) {
      state = AuthState.authenticated;
    } else {
      state = AuthState.unauthenticated;
    }
    notifyListeners();
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
