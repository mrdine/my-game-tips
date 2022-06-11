import 'package:flutter/material.dart';
import 'package:mygametips/components/tipItem.dart';
import 'package:mygametips/models/jogo.dart';
import 'package:provider/provider.dart';

import 'package:mygametips/models/jogo_state.dart';

class ListTipsScreen extends StatelessWidget {
  ListTipsScreen({Key? key}) : super(key: key);

  noTipsGame(Jogo jogo) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Dicas para ${jogo.titulo}')),
      body: const Center(
        child: Text(
          'Não há tips para este jogo',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final jogo = ModalRoute.of(context)!.settings.arguments as Jogo;
    return Consumer<JogoState>(builder: (context, jogos, child) {
      jogos.getTipsByGameId(jogo.id);
      if (jogos.jogo.firstWhere((game) => game.id == jogo.id).tips.isNotEmpty) {
        return Scaffold(
          appBar: AppBar(title: Text('Lista de Dicas para ${jogo.titulo}')),
          body: Center(
            child: GridView.count(
                crossAxisCount: 1,
                children:
                    jogos.jogo.firstWhere((game) => game == jogo).tips.map(
                  (tip) {
                    print(tip.categoria);
                    return Padding(
                      padding: const EdgeInsets.all(1),
                      child: GestureDetector(
                          child: TipItem(tip: tip), onTap: () {}),
                    );
                  },
                ).toList()),
          ),
        );
      } else {
        return noTipsGame(jogo);
      }
    });
  }
}
