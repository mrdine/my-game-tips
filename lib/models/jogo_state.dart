import 'dart:collection';

import 'package:flutter/material.dart';
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

        _loadTips();

        notifyListeners();
      },
    );
  }

  Future<void> _loadTips() {
    return http.get(Uri.parse('$_baseUrl/tips.json')).then((response) {
      if (response.body != 'null') {
        final Map<String, dynamic> dadosTips = json.decode(response.body);
        final List<Tip> tips = [];

        dadosTips.forEach(
          (String id, dynamic dados) {
            final Tip tip = Tip.fromJson(dados);
            tip.id = id;
            tips.add(tip);
          },
        );

        tips.forEach((tip) {
          _jogos.firstWhere((jogo) => jogo.id == tip.gameId).addTip(tip);
        });
      }
    });
  }

  void editTip(Tip tip, Jogo jogo) {
    print(tip.titulo);
    print(jogo.id);
    _jogos
        .firstWhere((game) => game.id == jogo.id)
        .tips
        .firstWhere((top) => top.id == tip.id)
        .titulo = tip.titulo;
    _jogos
        .firstWhere((game) => game.id == jogo.id)
        .tips
        .firstWhere((top) => top.id == tip.id)
        .conteudo = tip.conteudo;
    notifyListeners();
    http
        .put(Uri.parse('$_baseUrl/tips/${tip.id}/titulo.json'),
            body: '"${tip.titulo}"')
        .then((ob) => print(ob));
    http.put(Uri.parse('$_baseUrl/tips/${tip.id}/conteudo.json'),
        body: '"${tip.conteudo}"');
    http.put(Uri.parse('$_baseUrl/tips/${tip.id}/categoria.json'),
        body: '"${tip.categoria}"');
    print('editando dica');
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
    _removerJogoTips(x);
    _jogos.remove(x);
    http.delete(Uri.parse('$_baseUrl/jogos/${x.id}.json'));
    notifyListeners();
  }

  void _removerJogoTips(Jogo x) {
    x.tips.forEach(
      (tip) async {
        await http.delete(Uri.parse('$_baseUrl/tips/${tip.id}.json'));
      },
    );
  }

  void removeTip(Tip x) {
    print(x.id);
    _jogos.firstWhere((jogo) => jogo.id == x.gameId).tips.forEach((element) {
      print(element.id);
    });
    _jogos.firstWhere((jogo) => jogo.id == x.gameId).tips.remove(x);
    print(_jogos.firstWhere((jogo) => jogo.id == x.gameId).tips);
    http.delete(Uri.parse('$_baseUrl/tips/${x.id}.json'));
    notifyListeners();
  }

  void editGame(String nome, String url, Jogo x) {
    http.put(Uri.parse('$_baseUrl/jogos/${x.id}/titulo.json'), body: '"$nome"');
    http.put(Uri.parse('$_baseUrl/jogos/${x.id}/capaUrl.json'), body: '"$url"');
    _jogos.firstWhere((jogo) => jogo.id == x.id).capaUrl = url;
    _jogos.firstWhere((jogo) => jogo.id == x.id).titulo = nome;
    notifyListeners();
  }

  void addTip(Jogo x, Tip y) async {
    final future = await http
        .post(Uri.parse('$_baseUrl/tips.json'), body: y.toJson())
        .then(
      (response) {
        _jogos.firstWhere((jogo) => jogo.id == x.id).tips.add(
              Tip(
                  id: jsonDecode(response.body)['name'],
                  titulo: y.titulo,
                  conteudo: y.conteudo,
                  categoria: y.categoria,
                  gameId: y.gameId),
            );
      },
    );
  }

  List<Jogo> getGames() {
    return _jogos;
  }

  void getTipsByGameId(String id) {
    List<Tip> dicas = [];
    final res = http.get(Uri.parse('$_baseUrl/tips.json'));
    res.then(
      (res) {
        if (res.body != null) {
          final Map<String, dynamic> tips = json.decode(res.body);
          tips.forEach(
            (key, tip) {
              if (tip['gameId'] == id) {
                dicas.add(Tip.fromJson(tip));
              }
            },
          );
          _jogos.firstWhere((jogo) => jogo.id == id).tips = dicas;
        }
      },
    );
  }

  int getNextId() {
    return _jogos.length + 1;
  }
}
