// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mygametips/models/jogo.dart';
import 'package:mygametips/models/jogo_state.dart';
import 'package:mygametips/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../models/tip.dart';

class TipItem extends StatelessWidget {
  final Tip tip;
  final Jogo jogo;

  TipItem({required this.tip, required this.jogo});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, JogoState jogos, child) {
      return SizedBox(
        height: 50,
        child: GFCard(
          buttonBar: GFButtonBar(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.TIPS_FORM,
                      arguments: {'jogo': jogo, 'tip': tip});
                },
                icon: Icon(
                  Icons.edit_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  jogos.removeTip(tip);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          margin: EdgeInsets.all(10),
          height: 10,
          boxFit: BoxFit.cover,
          titlePosition: GFPosition.start,
          showOverlayImage: true,
          imageOverlay: AssetImage(
            'assets/images/tipBackground.png',
          ),
          title: GFListTile(
            onTap: () {},
            color: Colors.white,
            titleText: tip.titulo,
            subTitleText: tip.categoria,
          ),
          content: Text(tip.conteudo),
        ),
      );
    });
  }
}
