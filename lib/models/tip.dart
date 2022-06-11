import 'dart:convert';

import 'package:flutter/material.dart';

class Tip {
  final String id;
  final String titulo;
  final String conteudo;
  final String categoria;
  final String gameId;

  const Tip({
    required this.id,
    required this.titulo,
    required this.conteudo,
    required this.categoria,
    required this.gameId,
  });

  String toJson() {
    return jsonEncode({
      'id': id,
      'gameId': gameId,
      'titulo': titulo,
      'conteudo': conteudo,
      'categoria': categoria,
    });
  }

  Tip.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        gameId = json['gameId'],
        titulo = json['titulo'],
        conteudo = json['conteudo'],
        categoria = json['categoria'];
}
