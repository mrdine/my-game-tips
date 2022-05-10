import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mygametips/models/tip.dart';

class ListJogoState extends ChangeNotifier {
  final List<Jogo> _jogos = [];
  UnmodifiableListView<Jogo> get jogos => UnmodifiableListView(_jogos);
  void addJogo(Jogo x) {
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
  final int id;
  final String titulo;
  final String capaUrl;

  final List<Tip> tips;

  Jogo(
      {required this.id,
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
