import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiding/core/routes/kikisday_routes.dart';
import 'package:kiding/core/routes/space_routes.dart';
import 'package:provider/provider.dart';
import 'firebase_option.dart';
import 'model/timer_model.dart';

import 'package:kiding/model/game_provider.dart';
import 'package:kiding/screen/login/start_screen.dart';

const HOME_ROUTE = '/';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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

class MyApp extends StatelessWidget {
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

