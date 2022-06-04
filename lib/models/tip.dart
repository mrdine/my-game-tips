import 'dart:convert';

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

  String toJson() {
    return jsonEncode({
      'id': id,
      'titulo': titulo,
      'conteudo': conteudo,
      'categoria': categoria,
    });
  }

  Tip.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        titulo = json['titulo'],
        conteudo = json['conteudo'],
        categoria = json['categoria'];
}
