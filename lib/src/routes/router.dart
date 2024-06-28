import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../controllers/auth_controller.dart';
import '../enums/enum.dart';
import '../features/screens/account-screen/account_screen.dart';
import '../features/screens/home-screen/home_screen.dart';
import '../features/screens/home-screen/wrapper.dart';
import '../features/screens/login-screen/login_screen.dart';
import '../features/screens/forgot_password_screen.dart';
import '../features/screens/registration_screen.dart';
import '../features/screens/rewards-catalog-screen/rewards_catalog_screen.dart';
import '../features/screens/scan_qr_screen.dart';

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
    const List<String> unauthAllowedRoutes = [
      ForgotPasswordScreen.route,
      RegistrationScreen.route,
    ];

    if (AuthController.I.state == AuthState.authenticated) {
      if (state.matchedLocation == LoginScreen.route) {
        return HomeScreen.route;
      }
      return null;
    }

    if (AuthController.I.state != AuthState.authenticated) {
      if (unauthAllowedRoutes.contains(state.matchedLocation)) {
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
          path: RegistrationScreen.route,
          name: RegistrationScreen.name,
          builder: (context, _) {
            return const RegistrationScreen();
          },
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
              path: RewardsCatalogScreen.route,
              name: RewardsCatalogScreen.name,
              builder: (context, _) {
                return const RewardsCatalogScreen();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: ScanQRScreen.route,
              name: ScanQRScreen.name,
              builder: (context, _) {
                return const ScanQRScreen();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: AccountScreen.route,
              name: AccountScreen.name,
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
