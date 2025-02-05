import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'controllers/home_controller.dart';
import 'firebase_options.dart';
import 'i10/auth.dart';
import 'views/home_view.dart';
import 'views/routes/routes.dart';

///Configuração firebase
bool shouldUseFirebaseEmulator = false;

///Firebase
late final FirebaseApp app;

///Firebase
late final FirebaseAuth auth;

void main() async {
  Intl.defaultLocale = 'pt_BR';

  WidgetsFlutterBinding.ensureInitialized();

  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

///App
class MyApp extends StatelessWidget {
  ///Key do app
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController(),
      child: MaterialApp(
        localizationsDelegates: [
          FirebaseUILocalizations.withDefaultOverrides(const LabelOverrides()),
          FirebaseUILocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        title: 'Dashboard',
        initialRoute: '/login',
        onGenerateRoute: Routes.createRoutes,
        routes: {
          '/home': (context) => HomeView(),
        },
      ),
    );
  }
}
