import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mygametips/data/dummy_data.dart';
import 'package:mygametips/models/tip.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class JogoState extends ChangeNotifier {
  final _baseUrl = 'https://mygametips-df312-default-rtdb.firebaseio.com';

  //https://upload.wikimedia.org/wikipedia/pt/0/06/TW3_Wild_Hunt.png

  JogoState() {
    _loadJogos();
  }

  final List<Jogo> _jogos = [];

  UnmodifiableListView<Jogo> get jogos => UnmodifiableListView(_jogos);

  Future<void> _loadJogos() {
    return http.get(Uri.parse('$_baseUrl/jogos.json')).then((response) {
      final Map<String, dynamic> dadosJogos = json.decode(response.body);
      final List<Jogo> jogos = [];
      print(dadosJogos);
      dadosJogos.forEach((String id, dynamic dados) {
        final Jogo jogo = Jogo.fromJson(dados);
        jogo.id = id;
        jogos.add(jogo);
      });
      _jogos.clear();
      _jogos.addAll(jogos);
      notifyListeners();
    });
  }

  Future<void> addJogo(Jogo x) {
    final future = http.post(Uri.parse('$_baseUrl/jogos.json'),
        body: jsonEncode({
          'titulo': x.titulo,
          'capaUrl': x.capaUrl,
          'tips': x.tips.map((tip) => tip.toJson()).toList()
        }));

    return future.then((response) {
      x.id = jsonDecode(response.body)['name'];
      _jogos.add(x);
      notifyListeners();
    });
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

  List<Tip> getTipsByGameId(String id) {
    return _jogos.firstWhere((jogo) => jogo.id == id).tips;
  }

  int getNextId() {
    return _jogos.length + 1;
  }
}

class Jogo {
  String id;
  final String titulo;
  final String capaUrl;

  final List<Tip> tips;

  Jogo(
      {this.id = '0',
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

  Jogo.fromJson(Map<String, dynamic> json)
      : id = '',
        titulo = json['titulo'],
        capaUrl = json['capaUrl'],
        tips = json.containsKey('tips')
            ? jsonDecode(json['tips'])
                .map<Tip>((tip) => Tip.fromJson(tip))
                .toList()
            : [];

  void addTip(Tip x) => tips.add(x);

  @override
  String toString() {
    return 'Jogo{id: $id, titulo: $titulo, capaUrl: $capaUrl}';
  }
}
