import 'package:flutter/material.dart';
import '../../models/jogo.dart';
import '../../components/jogoItem.dart';

class JogosScreen extends StatelessWidget {
  const JogosScreen({Key? key, required this.myGames}) : super(key: key);

  final List<Jogo> myGames;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meus jogos")),
      body: Center(
          child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 2,
              children: myGames
                  .map((jogo) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: JogoItem(jogo: jogo),
                      ))
                  .toList())),
    );
  }
}
