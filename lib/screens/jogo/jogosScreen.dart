// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/main_drawer.dart';
import '../../models/jogo.dart';
import '../../components/jogoItem.dart';
import '../../utils/app_routes.dart';
import './addJogoFormScreen.dart';

enum JogosAbas { LISTAR, ADD }

class JogosScreen extends StatefulWidget {
  const JogosScreen({Key? key}) : super(key: key);

  @override
  State<JogosScreen> createState() => _JogosScreenState();
}

class _JogosScreenState extends State<JogosScreen> {
  /*Jogo(
        id: 1,
        titulo: 'Skyrim',
        capaUrl:
            'https://upload.wikimedia.org/wikipedia/pt/a/aa/The_Elder_Scrolls_5_Skyrim_capa.png')*/

  JogosAbas _abaAtual = JogosAbas.LISTAR;

  _addJogo(String titulo, String capaUrl) {}

  _changeView(JogosAbas aba) {
    setState(() {
      _abaAtual = aba;
      print(_abaAtual);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meus jogos")),
      drawer: MainDrawer(),
      body: BodyJogosScreen(
        games: Provider.of<ListJogoState>(context, listen: false).getGames(),
        aba: _abaAtual,
        addJogo: _addJogo,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _changeView(JogosAbas.ADD);
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
      ),
    );
  }
}

class BodyJogosScreen extends StatefulWidget {
  final List<Jogo> games;
  final JogosAbas aba;

  final void Function(String titulo, String capaUrl) addJogo;

  const BodyJogosScreen(
      {Key? key, required this.games, required this.aba, required this.addJogo})
      : super(key: key);

  @override
  State<BodyJogosScreen> createState() => _BodyJogosScreenState();
}

class _BodyJogosScreenState extends State<BodyJogosScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.aba == JogosAbas.LISTAR) {
      print('oi');
      return ListJogos();
    } else if (widget.aba == JogosAbas.ADD) {
      return AddJogoFormScreen(widget.addJogo);
    } else {
      return Text('...');
    }
  }
}

class ListJogos extends StatelessWidget {
  const ListJogos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('hellow');
    return Center(
      child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          children: Provider.of<ListJogoState>(context, listen: false)
              .getGames()
              .map((jogo) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: JogoItem(jogo: jogo),
                  ))
              .toList()),
    );
  }
}
