import 'dart:ui';

import '../models/jogo.dart';
import 'package:flutter/material.dart';

class JogoItem extends StatelessWidget {
  final Jogo jogo;

  const JogoItem({Key? key, required this.jogo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.network(jogo.capaUrl));
  }
}
