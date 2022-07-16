import 'dart:ui';

import 'package:mygametips/models/jogo.dart';

import '../models/jogo_state.dart';
import 'package:flutter/material.dart';

class JogoItem extends StatelessWidget {
  final Jogo jogo;

  const JogoItem({Key? key, required this.jogo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.network(
      jogo.capaUrl,
      errorBuilder: (context, error, stackTrace) {
        return Column(
          children: [new Icon(Icons.error), Text(jogo.titulo)],
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    ));
  }
}
