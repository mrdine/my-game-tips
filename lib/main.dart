// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/jogo/jogosScreen.dart';
import 'screens/tip/tipsScreen.dart';
import 'models/jogo.dart';
import 'utils/app_routes.dart';
import 'screens/tabsScreen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (constext) => ListJogoState(),
      child: MaterialApp(
        title: 'My game tips',
        theme: ThemeData(
            colorScheme: ThemeData()
                .colorScheme
                .copyWith(primary: Colors.purple, secondary: Colors.amber),
            //primarySwatch: Colors.purple,
            //accentColor: Colors.amber,
            fontFamily: 'Raleway',
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                ))),
        initialRoute: '/',
        routes: {
          AppRoutes.HOME: (ctx) => TabsScreen(),
          AppRoutes.GAMES: (ctx) => JogosScreen(),
          AppRoutes.GAME_TIPS: (ctx) => TipsScreen(),
          //AppRoutes.TIPS: (ctx) => TipsScreen(),
          //AppRoutes.SETTINGS: (ctx) => SettingsScreen(),
        },
      ),
    );
  }
}
