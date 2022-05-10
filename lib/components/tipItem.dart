import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../models/tip.dart';

class TipItem extends StatelessWidget {
  final Tip tip;

  TipItem({required this.tip});

  @override
  Widget build(BuildContext context) {
    return GFCard(
      boxFit: BoxFit.cover,
      titlePosition: GFPosition.start,
      showOverlayImage: true,
      imageOverlay: AssetImage(
        'assets/images/tipBackground.png',
      ),
      title: GFListTile(
        avatar: GFAvatar(),
        titleText: tip.titulo,
        subTitleText: tip.categoria,
      ),
      content: Text(""),
      buttonBar: GFButtonBar(
        children: <Widget>[
          GFAvatar(
            backgroundColor: GFColors.PRIMARY,
            child: Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
