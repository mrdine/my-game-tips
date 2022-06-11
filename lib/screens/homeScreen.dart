import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mygametips/models/jogo_state.dart';
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
      crossAxisCount: 1,
      children: [
        Center(
          child: ListView(children: [
            InkWell(
                child: const GFListTile(
                    titleText: 'Meus Jogos',
                    subTitleText: 'Crie e acesse as suas próprias tips',
                    color: Color.fromARGB(255, 255, 255, 255),
                    hoverColor: Colors.grey,
                    avatar: GFImageOverlay(
                        height: 72,
                        width: 128,
                        image: AssetImage('assets/images/gamesLibrary.png'))),
                onTap: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.GAMES);
                }),
            InkWell(
                child: const GFListTile(
                    titleText: 'Explorar',
                    subTitleText: 'Acesse tips criadas por outros jogadores',
                    color: Color.fromARGB(255, 255, 255, 255),
                    hoverColor: Colors.grey,
                    avatar: GFImageOverlay(
                        height: 72,
                        width: 128,
                        image: AssetImage('assets/images/onlineLibrary.png'))),
                onTap: () {
                  //Navigator.pushReplacementNamed(context, AppRoutes.GAMES);
                }),
          ]),
        )
      ],
    )));
  }
}
