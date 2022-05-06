import 'package:flutter/material.dart';

class Tip {
  final int id;
  final String titulo;
  final String conteudo;
  final String categoria;

  const Tip({
    required this.id,
    required this.titulo,
    required this.conteudo,
    required this.categoria,
  });
}
