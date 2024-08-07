import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../controllers/auth_controller.dart';
import '../enums/animation_type_enum.dart';
import '../enums/enum.dart';
import '../features/screens/account-screen/account_screen.dart';
import '../features/screens/placeholder_screen.dart';
import '../features/screens/profile-screen/profile_screen.dart';
import '../features/screens/home-screen/home_screen.dart';
import '../features/screens/home-screen/wrapper.dart';
import '../features/screens/login-screen/login_screen.dart';
import '../features/screens/forgot_password_screen.dart';
import '../features/screens/recycling-log-screen/recycling_log_screen.dart';
import '../features/screens/register-screen/registration_screen.dart';
import '../features/screens/rewards-catalog-screen/rewards_catalog_screen.dart';
import '../features/screens/reward-details-screen/reward_details_screen.dart';
import '../features/screens/scan-qr-screen/scan_qr_screen.dart';
import '../features/screens/transaction-history-screen/transaction_history_screen.dart';
import '../features/screens/transaction-receipt-screen/transaction_receipt_screen.dart';
import '../models/reward_model.dart';
import '../models/transaction_model.dart';

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
          pageBuilder: (context, state) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: const RegistrationScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation,
                      child) =>
                  buildPageTransition(
                      child: child,
                      animation: animation,
                      type: AnimationType.slideLeft,
                      curve: Curves.easeInOut),
              transitionDuration: const Duration(milliseconds: 250),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: ForgotPasswordScreen.route,
          name: ForgotPasswordScreen.name,
          pageBuilder: (context, state) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: const ForgotPasswordScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation,
                      child) =>
                  buildPageTransition(
                      child: child,
                      animation: animation,
                      type: AnimationType.slideLeft,
                      curve: Curves.easeInOut),
              transitionDuration: const Duration(milliseconds: 250),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: ScanQRScreen.route,
          name: ScanQRScreen.name,
          builder: (context, _) {
            return const ScanQRScreen();
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: EditProfileScreen.route,
          name: EditProfileScreen.name,
          pageBuilder: (context, state) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: const EditProfileScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation,
                      child) =>
                  buildPageTransition(
                      child: child,
                      animation: animation,
                      type: AnimationType.slideLeft,
                      curve: Curves.easeInOut),
              transitionDuration: const Duration(milliseconds: 250),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: RewardDetailsScreen.route,
          name: RewardDetailsScreen.name,
          pageBuilder: (context, state) {
            final reward = state.extra as RewardModel;
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: RewardDetailsScreen(reward: reward),
              transitionsBuilder: (context, animation, secondaryAnimation,
                      child) =>
                  buildPageTransition(
                      child: child,
                      animation: animation,
                      type: AnimationType.slideLeft,
                      curve: Curves.easeInOut),
              transitionDuration: const Duration(milliseconds: 250),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: TransactionReceiptScreen.route,
          name: TransactionReceiptScreen.name,
          builder: (context, state) {
            final TransactionModel transaction =
                state.extra as TransactionModel;
            return TransactionReceiptScreen(transaction: transaction);
          },
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          routes: [
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: HomeScreen.route,
              name: HomeScreen.name,
              builder: (context, state) {
                return const HomeWrapper(
                  child: HomeScreen(),
                );
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
              path: PlaceholderScreen.route,
              name: PlaceholderScreen.name,
              builder: (context, _) {
                return const PlaceholderScreen();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: AccountScreen.route,
              name: AccountScreen.name,
              builder: (context, state) => const AccountScreen(),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: RecyclingLogScreen.route,
                  name: RecyclingLogScreen.name,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const RecyclingLogScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              buildPageTransition(
                                  child: child,
                                  animation: animation,
                                  type: AnimationType.slideLeft,
                                  curve: Curves.easeInOut),
                      transitionDuration: const Duration(milliseconds: 250),
                    );
                  },
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: TransactionHistoryScreen.route,
                  name: TransactionHistoryScreen.name,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const TransactionHistoryScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              buildPageTransition(
                                  child: child,
                                  animation: animation,
                                  type: AnimationType.slideLeft,
                                  curve: Curves.easeInOut),
                      transitionDuration: const Duration(milliseconds: 250),
                    );
                  },
                ),
              ],
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
