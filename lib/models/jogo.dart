import 'package:flutter/material.dart';
import 'package:mygametips/models/tip.dart';

class Jogo {
  final int id;
  final String titulo;
  final String capaUrl;
  List<Tip> _tips = [];
  Jogo({
    required this.id,
    required this.titulo,
    required this.capaUrl,
  });
}
