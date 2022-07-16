import 'dart:convert';

import 'package:mygametips/models/tip.dart';

class Jogo {
  String id;
  String titulo;
  String capaUrl;

  List<Tip> tips;

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

  Map<String, Object> toMapStringObject() {
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
