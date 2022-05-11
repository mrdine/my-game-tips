import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mygametips/models/tip.dart';

class ListJogoState extends ChangeNotifier {
  final List<Jogo> _jogos = [
    Jogo(
        id: 1,
        titulo: 'Skyrim',
        capaUrl:
            'https://upload.wikimedia.org/wikipedia/pt/a/aa/The_Elder_Scrolls_5_Skyrim_capa.png',
        tips: [
          Tip(
              id: 1,
              titulo: 'Como aprender fireball',
              conteudo: 'Aprendendo',
              categoria: 'Tutorial'),
          Tip(
              id: 2,
              titulo: 'Como derrotar Alduin',
              categoria: 'Dica',
              conteudo: 'Apelando'),
        ]),
    Jogo(
        id: 2,
        titulo: 'The Witcher 3',
        capaUrl:
            'https://upload.wikimedia.org/wikipedia/pt/0/06/TW3_Wild_Hunt.png',
        tips: []),
  ];
  UnmodifiableListView<Jogo> get jogos => UnmodifiableListView(_jogos);
  void addJogo(Jogo x) {
    x.id = _jogos.length;
    _jogos.add(x);
    notifyListeners();
  }

  void removeJogo(Jogo x) {
    _jogos.remove(x);
    notifyListeners();
  }

  List<Jogo> getGames() {
    return _jogos;
  }

  List<Tip> getTipsByGameId(int id) {
    return _jogos.firstWhere((jogo) => jogo.id == id).tips;
  }
}

class Jogo {
  int id;
  final String titulo;
  final String capaUrl;

  final List<Tip> tips;

  Jogo(
      {this.id = 0,
      required this.titulo,
      required this.capaUrl,
      required this.tips});

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
