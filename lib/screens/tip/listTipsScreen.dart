import 'package:flutter/material.dart';
import 'package:mygametips/components/tipItem.dart';
import 'package:provider/provider.dart';
import 'package:getwidget/getwidget.dart';

import '../../models/jogo.dart';

class ListTipsScreen extends StatelessWidget {
  ListTipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jogo = ModalRoute.of(context)!.settings.arguments as Jogo;
    if (jogo.tips.isEmpty) {
      return const Center(
        child: Text('Não há tips para este jogo'),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: Text('Lista de Dicas para ${jogo.titulo}')),
        body: Center(
          child: GridView.count(
              crossAxisCount: 1,
              children: Provider.of<ListJogoState>(context, listen: false)
                  .getTipsByGameId(jogo.id)
                  .map((tip) => Padding(
                        padding: const EdgeInsets.all(1),
                        child: GestureDetector(
                            child: TipItem(tip: tip),
                            onTap: () {
                              print('tip ${tip.titulo} apertado');
                            }),
                      ))
                  .toList()),
        ),
      );
    }
  }
}
