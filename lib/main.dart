// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'screens/jogo/jogosScreen.dart';
import 'models/jogo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(),
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Jogo> _jogos = [
    Jogo(
        id: 1,
        titulo: 'Skyrim',
        capaUrl:
            'https://upload.wikimedia.org/wikipedia/pt/a/aa/The_Elder_Scrolls_5_Skyrim_capa.png'),
    Jogo(
        id: 2,
        titulo: 'Elden Ring',
        capaUrl:
            'https://upload.wikimedia.org/wikipedia/pt/a/aa/The_Elder_Scrolls_5_Skyrim_capa.png'),
    Jogo(
        id: 3,
        titulo: 'GTA V',
        capaUrl:
            'https://upload.wikimedia.org/wikipedia/pt/a/aa/The_Elder_Scrolls_5_Skyrim_capa.png'),
    Jogo(
        id: 4,
        titulo: 'Rainbow Six Siege',
        capaUrl:
            'https://upload.wikimedia.org/wikipedia/pt/a/aa/The_Elder_Scrolls_5_Skyrim_capa.png'),
  ];

  void changetoJogosScreen(BuildContext context) {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new JogosScreen(myGames: _jogos)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Game Tips')),
      drawer: Drawer(
        child: ListView(children: <Widget>[
          SizedBox(
            height: 70,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Perfil'),
            ),
          ),
          ListTile(
            title: Text('Meus jogos'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return JogosScreen(myGames: _jogos);
              }));
            },
          )
        ]),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
            child: Text('Bem-vindo ao My Game Tips!'),
          ),
        ],
      )),
    );
  }
}
