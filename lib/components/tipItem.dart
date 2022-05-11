// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../models/tip.dart';

class TipItem extends StatelessWidget {
  final Tip tip;

  TipItem({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GFCard(
        margin: EdgeInsets.all(10),
        height: 10,
        boxFit: BoxFit.cover,
        titlePosition: GFPosition.start,
        showOverlayImage: true,
        imageOverlay: AssetImage(
          'assets/images/tipBackground.png',
        ),
        title: GFListTile(
          titleText: tip.titulo,
          subTitleText: tip.categoria,
        ),
        content: Text(tip.conteudo),
      ),
    );
  }
}
