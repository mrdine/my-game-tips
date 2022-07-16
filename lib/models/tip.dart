import 'dart:convert';

import 'package:flutter/material.dart';

class Tip {
  String id;
  String titulo;
  String conteudo;
  String categoria;
  final String gameId;

  Tip({
    required this.id,
    required this.titulo,
    required this.conteudo,
    required this.categoria,
    required this.gameId,
  });

  String toJson() {
    return jsonEncode({
      'gameId': gameId,
      'titulo': titulo,
      'conteudo': conteudo,
      'categoria': categoria,
    });
  }

  Map<String, Object> toMapStringObject() {
    return {
      'id': id,
      'titulo': titulo,
      'conteudo': conteudo,
      'categoria': categoria,
      'gameId': gameId,
    };
  }

  Tip.fromJson(Map<String, dynamic> json)
      : id = json.containsKey('id') ? json['id'] : '',
        gameId = json['gameId'],
        titulo = json['titulo'],
        conteudo = json['conteudo'],
        categoria = json['categoria'];
}
