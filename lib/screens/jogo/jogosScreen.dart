// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mygametips/models/jogo.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import '../../components/main_drawer.dart';
import '../../models/jogo_state.dart';
import '../../components/jogoItem.dart';
import '../../utils/app_routes.dart';
import './addJogoFormScreen.dart';

enum JogosAbas { LISTAR, ADD, LISTAR_TIPS }

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meus jogos")),
      drawer: MainDrawer(),
      body: BodyJogosScreen(
        games: Provider.of<JogoState>(context, listen: false).getGames(),
        aba: _abaAtual,
        addJogo: _addJogo,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _changeView(JogosAbas.ADD);
        },
        backgroundColor: Colors.redAccent,
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
      return ListJogos();
    } else if (widget.aba == JogosAbas.ADD) {
      return AddJogoFormScreen(widget.addJogo, null);
    } else {
      return Text('...');
    }
  }
}

class ListJogos extends StatelessWidget {
  const ListJogos({Key? key}) : super(key: key);

  _updateGame(String nome, String url, Jogo jogo, BuildContext context) {
    Provider.of<JogoState>(context, listen: false).editGame(nome, url, jogo);
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.GAMES,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JogoState>(builder: ((context, games, child) {
      return Center(
        child: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            children: games.jogo
                .map((jogo) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: GestureDetector(
                          child: JogoItem(jogo: jogo),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: 250,
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, AppRoutes.TIPS_FORM,
                                                arguments: {
                                                  'jogo': jogo,
                                                  'tip': null
                                                });
                                          },
                                          child: Text('Adicionar Dica'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, AppRoutes.GAME_TIPS,
                                                arguments: jogo);
                                          },
                                          child:
                                              Text('Ver dicas para esse jogo'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return AddJogoFormScreen(
                                                  (nome, url) => _updateGame(
                                                      nome, url, jogo, context),
                                                  jogo);
                                            }));
                                          },
                                          child: Text("Editar Jogo"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            games.removeJogo(jogo);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Remover Jogo"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Voltar'),
                                        )
                                      ],
                                    ),
                                  );
                                });
                            // Navigator.pushNamed(context, AppRoutes.GAME_TIPS,
                            //     arguments: jogo);
                          }),
                    ))
                .toList()),
      );
    }));
  }
}
