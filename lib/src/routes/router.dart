import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../controllers/auth_controller.dart';
import '../enums/enum.dart';
import '../features/screens/account_screen.dart';
import '../features/screens/auth/login_screen.dart';
import '../features/screens/home/home_screen.dart';
import '../features/screens/home/home_wrapper.dart';
import '../features/screens/sample_screen.dart';

class GlobalRouter {
  static void initialize() {
    GetIt.instance.registerSingleton<GlobalRouter>(GlobalRouter());
  }

  static GlobalRouter get instance => GetIt.instance<GlobalRouter>();

  static GlobalRouter get I => GetIt.instance<GlobalRouter>();

  late GoRouter router;
  late GlobalKey<NavigatorState> _rootNavigatorKey;
  late GlobalKey<NavigatorState> _shellNavigatorKey;

  Future<String?> handleRedirect(
      BuildContext context, GoRouterState state) async {
    if (AuthController.I.state == AuthState.authenticated) {
      if (state.matchedLocation == LoginScreen.route) {
        return HomeScreen.route;
      }
      return null;
    }
    if (AuthController.I.state != AuthState.authenticated) {
      if (state.matchedLocation == LoginScreen.route) {
        return null;
      }
      return LoginScreen.route;
    }
    return null;
  }

  GlobalRouter() {
    _rootNavigatorKey = GlobalKey<NavigatorState>();
    _shellNavigatorKey = GlobalKey<NavigatorState>();

    router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: HomeScreen.route,
      redirect: handleRedirect,
      refreshListenable: AuthController.I,
      routes: [
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: LoginScreen.route,
          name: LoginScreen.name,
          builder: (context, _) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: AccountScreen.route,
          name: AccountScreen.name,
          builder: (context, _) {
            return const AccountScreen();
          },
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: CounterScreen.route,
              name: CounterScreen.name,
              builder: (context, _) {
                return const CounterScreen();
              },
            ),
          ],
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          routes: [
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: HomeScreen.route,
              name: HomeScreen.name,
              builder: (context, _) {
                return const HomeScreen();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: "/account",
              name: "Wrapped Account",
              builder: (context, _) {
                return const AccountScreen();
              },
            ),
          ],
          builder: (context, state, child) {
            return HomeWrapper(
              child: child,
            );
          },
        ),
      ],
    );
  }
}
