import 'package:flutter/material.dart';
import 'package:mygametips/models/jogo.dart';
import 'package:provider/provider.dart';

import '../components/main_drawer.dart';
import '../utils/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      children: [
        Center(
          child: InkWell(
              child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(child: Text('Meus Jogos'))),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.GAMES);
              }),
        )
      ],
    )));
  }
}
