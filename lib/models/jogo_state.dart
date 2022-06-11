import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mygametips/data/dummy_data.dart';
import 'package:mygametips/models/jogo.dart';
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

  UnmodifiableListView<Jogo> get jogo => UnmodifiableListView(_jogos);

  Future<void> _loadJogos() {
    return http.get(Uri.parse('$_baseUrl/jogos.json')).then(
      (response) {
        final Map<String, dynamic> dadosJogos = json.decode(response.body);
        final List<Jogo> jogos = [];
        dadosJogos.forEach(
          (String id, dynamic dados) {
            final Jogo jogo = Jogo.fromJson(dados);
            jogo.id = id;
            jogos.add(jogo);
          },
        );
        _jogos.clear();
        _jogos.addAll(jogos);
        notifyListeners();
      },
    );
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

  void addTip(Jogo x, Tip y) async {
    final future = await http.post(
      Uri.parse('$_baseUrl/tips.json'),
      body: y.toJson(),
    );
  }

  List<Jogo> getGames() {
    return _jogos;
  }

  void getTipsByGameId(String id) {
    print('fazendo request $id');
    List<Tip> dicas = [];
    final res = http.get(Uri.parse('$_baseUrl/tips.json'));
    res.then(
      (res) {
        final Map<String, dynamic> tips = json.decode(res.body);
        tips.forEach(
          (key, tip) {
            if (tip['gameId'] == id) {
              print(tip);
              dicas.add(Tip.fromJson(tip));
            }
          },
        );
        _jogos.firstWhere((jogo) => jogo.id == id).tips = dicas;
      },
    );
  }

  int getNextId() {
    return _jogos.length + 1;
  }
}
