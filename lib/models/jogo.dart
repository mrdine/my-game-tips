import 'package:flutter/material.dart';
import 'package:mygametips/models/tip.dart';

class Jogo {
  final int id;
  final String titulo;
  final String capaUrl;

  //final List<Tip> tips;

  const Jogo({
    required this.id,
    required this.titulo,
    required this.capaUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'capaUrl': capaUrl,
    };
  }

  @override
  String toString() {
    return 'Jogo{id: $id, titulo: $titulo, capaUrl: $capaUrl}';
  }
}
