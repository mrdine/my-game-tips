import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mygametips/models/tip.dart';

class ListJogoState extends ChangeNotifier {
  final List<Jogo> _jogos = [
    Jogo(
        id: 0,
        titulo: 'Skyrim',
        capaUrl:
            'https://upload.wikimedia.org/wikipedia/pt/a/aa/The_Elder_Scrolls_5_Skyrim_capa.png',
        tips: [
          const Tip(
              id: 1,
              titulo: 'Como aprender fireball',
              conteudo: 'Aprendendo',
              categoria: 'Tutorial'),
          const Tip(
              id: 2,
              titulo: 'Como derrotar Alduin',
              conteudo: 'Apelando',
              categoria: 'Dica'),
        ]),
    Jogo(
        id: 1,
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

  void addTip(Jogo x, Tip y) {
    final jogo = _jogos.indexOf(x);
    _jogos[jogo].addTip(y);
  }

  List<Jogo> getGames() {
    return _jogos;
  }

  List<Tip> getTipsByGameId(int id) {
    return _jogos.firstWhere((jogo) => jogo.id == id).tips;
  }

  int getNextId() {
    return _jogos.length + 1;
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

  void addTip(Tip x) => tips.add(x);

  @override
  String toString() {
    return 'Jogo{id: $id, titulo: $titulo, capaUrl: $capaUrl}';
  }
}
