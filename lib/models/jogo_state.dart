import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mygametips/models/jogo.dart';
import 'package:mygametips/models/tip.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mygametips/utils/connection_util.dart';

import '../utils/db_util.dart';

class JogoState extends ChangeNotifier {
  final _baseUrl = 'https://mygametips-df312-default-rtdb.firebaseio.com';

  final QTD_OFFLINE_JOGOS = 5;

  //https://upload.wikimedia.org/wikipedia/pt/0/06/TW3_Wild_Hunt.png

  JogoState() {
    _loadJogos();
  }

  final List<Jogo> _jogos = [];

  UnmodifiableListView<Jogo> get jogo => UnmodifiableListView(_jogos);

  Future<void> _loadJogos() async {
    if (await ConnectionUtils.isConnected()) {
      return http.get(Uri.parse('$_baseUrl/jogos.json')).then(
        (response) async {
          if (response.statusCode == 200) {
            await DbUtil.deleteAll(['jogos', 'tips']);

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

            await _loadTips();

            for (Jogo jogo in _jogos.getRange(
                0,
                _jogos.length > QTD_OFFLINE_JOGOS
                    ? QTD_OFFLINE_JOGOS
                    : _jogos.length)) {
              await DbUtil.insert('jogos', jogo.toMapStringObject());
              await DbUtil.insertAll('tips',
                  jogo.tips.map((tip) => tip.toMapStringObject()).toList());
            }
          } else {
            final dataList = await DbUtil.getData('jogos');
            _jogos.clear();
            _jogos.addAll(dataList
                .map((e) => Jogo(
                    id: e['id'],
                    titulo: e['titulo'],
                    capaUrl: e['capaUrl'],
                    tips: []))
                .toList());

            await _loadTips();
          }
          notifyListeners();
        },
      );
    } else {
      final dataList = await DbUtil.getData('jogos');
      _jogos.clear();
      _jogos.addAll(dataList
          .map((e) => Jogo(
              id: e['id'],
              titulo: e['titulo'],
              capaUrl: e['capaUrl'],
              tips: []))
          .toList());

      await _loadTips();
      notifyListeners();
    }
  }

  Future<void> _loadTips() async {
    if (await ConnectionUtils.isConnected()) {
      return http.get(Uri.parse('$_baseUrl/tips.json')).then((response) async {
        final List<Tip> tips = [];
        if (response.statusCode == 200) {
          if (response.body != 'null') {
            final Map<String, dynamic> dadosTips = json.decode(response.body);

            dadosTips.forEach(
              (String id, dynamic dados) {
                final Tip tip = Tip.fromJson(dados);
                tip.id = id;
                tips.add(tip);
              },
            );
          }
        } else {
          final dataList = await DbUtil.getData('tips');
          tips.addAll(dataList
              .map((e) => Tip(
                    id: e['id'],
                    titulo: e['titulo'],
                    conteudo: e['conteudo'],
                    categoria: e['categoria'],
                    gameId: e['gameId'],
                  ))
              .toList());
        }
        tips.forEach((tip) {
          _jogos.firstWhere((jogo) => jogo.id == tip.gameId).addTip(tip);
        });
      });
    } else {
      List<Tip> tips = [];
      final dataList = await DbUtil.getData('tips');
      tips.addAll(dataList
          .map((e) => Tip(
                id: e['id'],
                titulo: e['titulo'],
                conteudo: e['conteudo'],
                categoria: e['categoria'],
                gameId: e['gameId'],
              ))
          .toList());
      tips.forEach((tip) {
        _jogos.firstWhere((jogo) => jogo.id == tip.gameId).addTip(tip);
      });
    }
  }

  void editTip(Tip tip, Jogo jogo) {
    _jogos
        .firstWhere((game) => game.id == jogo.id)
        .tips
        .removeWhere(((element) => element.id == tip.id));
    _jogos.firstWhere((game) => game.id == jogo.id).tips.add(tip);
    notifyListeners();

    http
        .put(Uri.parse('$_baseUrl/tips/${tip.id}.json'), body: tip.toJson())
        .then((ob) => print(ob));

    DbUtil.update('tips', tip.toMapStringObject());

    print('Editando dica');
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
    DbUtil.deleteGameAndTips(x.id);
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

    DbUtil.delete('tips', x.id);

    notifyListeners();
  }

  void editGame(String nome, String url, Jogo x) {
    http.put(Uri.parse('$_baseUrl/jogos/${x.id}/titulo.json'), body: '"$nome"');
    http.put(Uri.parse('$_baseUrl/jogos/${x.id}/capaUrl.json'), body: '"$url"');
    _jogos.firstWhere((jogo) => jogo.id == x.id).capaUrl = url;
    _jogos.firstWhere((jogo) => jogo.id == x.id).titulo = nome;

    x.capaUrl = url;
    x.titulo = nome;

    DbUtil.update('jogos', x.toMapStringObject());

    notifyListeners();
  }

  void addTip(Jogo x, Tip y) async {
    final future = await http
        .post(Uri.parse('$_baseUrl/tips.json'), body: y.toJson())
        .then(
      (response) async {
        if (response.statusCode == 200) {
          Tip novaTip = Tip(
              id: jsonDecode(response.body)['name'],
              titulo: y.titulo,
              conteudo: y.conteudo,
              categoria: y.categoria,
              gameId: y.gameId);

          _jogos.firstWhere((jogo) => jogo.id == x.id).tips.add(novaTip);

          if (await DbUtil.findById('jogos', x.id) != null) {
            DbUtil.insert('tips', novaTip.toMapStringObject());
          }
        }
      },
    );
  }

  List<Jogo> getGames() {
    return _jogos;
  }
}
