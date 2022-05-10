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
    return Center(
      child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          children: Provider.of<ListJogoState>(context, listen: false)
              .getTipsByGameId(jogo.id)
              .map((tip) => Padding(
                    padding: const EdgeInsets.all(20),
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
