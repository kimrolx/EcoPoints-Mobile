import 'package:ecopoints/src/shared/services/qr_code_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'firebase_options.dart';
import 'src/controllers/auth_controller.dart';
import 'src/routes/router.dart';
import 'src/shared/services/recycling_log_service.dart';
import 'src/shared/services/registration_form_service.dart';
import 'src/shared/services/rewards_firestore_service.dart';
import 'src/shared/services/transaction_service.dart';
import 'src/shared/services/firebase_services.dart';
import 'src/shared/services/user_profile_service.dart';
import 'src/shared/utils/cooldown_timer_util.dart';
import 'src/shared/utils/local_storage_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalStorage.init();
  setupServices();
  GlobalRouter.initialize();
  await AuthController.I.loadSession();

  runApp(const MainApp());
}

void setupServices() {
  GetIt.instance.registerSingleton<CooldownTimerUtil>(CooldownTimerUtil());
  GetIt.instance
      .registerLazySingleton<RegistrationService>(() => RegistrationService());
  GetIt.instance.registerSingleton<FirebaseServices>(FirebaseServices());
  GetIt.instance.registerSingleton<UserProfileService>(UserProfileService());
  GetIt.instance.registerSingleton<QrCodeService>(QrCodeService());
  GetIt.instance.registerSingleton<RewardsService>(RewardsService());
  GetIt.instance
      .registerLazySingleton<RecyclingLogService>(() => RecyclingLogService());
  GetIt.instance
      .registerLazySingleton<TransactionService>(() => TransactionService());
  AuthController.initialize();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: GlobalRouter.I.router,
      title: 'EcoPoints',
    );
  }
}
