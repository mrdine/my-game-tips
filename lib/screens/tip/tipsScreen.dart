import 'package:flutter/material.dart';
import 'package:mygametips/components/tipItem.dart';
import 'package:provider/provider.dart';
import 'package:getwidget/getwidget.dart';

import '../../models/jogo.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({Key? key}) : super(key: key);

  @override
  _TipsScreenState createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  @override
  Widget build(BuildContext context) {
    final jogo = ModalRoute.of(context)!.settings.arguments as Jogo;
    return Scaffold(
        body: ListTips(
      jogo: jogo,
    ));
  }
}

class ListTips extends StatelessWidget {
  const ListTips({Key? key, required this.jogo}) : super(key: key);

  final Jogo jogo;

  @override
  Widget build(BuildContext context) {
    if (jogo.tips.length == 0) {
      return Center(
        child: Text('Não há tips para este jogo'),
      );
    } else {
      return Center(
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
      );
    }
  }
}
