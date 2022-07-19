// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mygametips/screens/tip/tipFormScreen.dart';
import 'package:mygametips/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'screens/jogo/jogosScreen.dart';
import 'screens/tip/listTipsScreen.dart';
import 'models/jogo_state.dart';
import 'utils/app_routes.dart';
import 'screens/tabsScreen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<void> intializeApp(BuildContext context) async {
    await Firebase.initializeApp();
  }

  Future<void> initMessage(
      BuildContext context, NotificationService service) async {
    final token = await FirebaseMessaging.instance.getToken();
    print(token);
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print('Recebi uma mensagem ${event.data}');
      service.showLocalNotification(CustomNotification(
          id: 12, title: event.data['titulo'], body: event.data['body']));
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (constext) => JogoState(),
      child: MultiProvider(
        providers: [
          Provider<NotificationService>(
            create: (context) => NotificationService(),
          ),
        ],
        child: FutureBuilder(
            future: intializeApp(context),
            builder: (context, snp) {
              final notifyService =
                  Provider.of<NotificationService>(context, listen: false);
              initMessage(context, notifyService);
              return MaterialApp(
                title: 'My game tips',
                theme: ThemeData(
                    colorScheme: ThemeData().colorScheme.copyWith(
                        primary: Colors.redAccent, secondary: Colors.amber),
                    //primarySwatch: Colors.purple,
                    //accentColor: Colors.amber,
                    fontFamily: 'Raleway',
                    canvasColor: Color.fromARGB(255, 247, 247, 241),
                    textTheme: ThemeData.light().textTheme.copyWith(
                            headline6: TextStyle(
                          fontSize: 20,
                          fontFamily: 'RobotoCondensed',
                        ))),
                initialRoute: '/',
                routes: {
                  AppRoutes.HOME: (ctx) => TabsScreen(),
                  AppRoutes.GAMES: (ctx) => JogosScreen(),
                  AppRoutes.GAME_TIPS: (ctx) => ListTipsScreen(),
                  AppRoutes.TIPS_FORM: (ctx) => TipFormScreen(),
                  //AppRoutes.SETTINGS: (ctx) => SettingsScreen(),
                },
              );
            }),
      ),
    );
  }
}
