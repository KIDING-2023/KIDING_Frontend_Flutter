//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiding_frontend/core/routes/kikiday_routes.dart';
import 'package:kiding_frontend/core/routes/space_routes.dart';
import 'package:kiding_frontend/model/game_provider.dart';
import 'package:kiding_frontend/model/timer_mode.dart';
import 'package:kiding_frontend/screen/login/start_screen.dart';
import 'package:provider/provider.dart';

const HOME_ROUTE = '/';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerModel()),
        ChangeNotifierProvider(create: (_) => GameProvider()),
      ],
      child: MyApp(),
    ),
  );
}

// class DefaultFirebaseOptions {
//   static var currentPlatform;
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HOME_ROUTE,
      routes: {
        HOME_ROUTE: (context) => StartScreen(),
        ...kikisdayRoutes,
        ...spaceRoutes,
      },
    );
  }
}
