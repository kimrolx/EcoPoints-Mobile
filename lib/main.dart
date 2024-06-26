import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'src/controllers/auth_controller.dart';
import 'src/routes/router.dart';
import 'src/shared/utils/local_storage_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalStorage.init();
  AuthController.initialize();
  GlobalRouter.initialize();
  await AuthController.I.loadSession();
  runApp(const MainApp());
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
