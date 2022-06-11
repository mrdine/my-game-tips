import 'package:mygametips/models/jogo.dart';

import '../models/jogo_state.dart';
import '../models/tip.dart';

final dummyJogos = [
  Jogo(
      id: '0',
      titulo: 'Skyrim',
      capaUrl:
          'https://upload.wikimedia.org/wikipedia/pt/a/aa/The_Elder_Scrolls_5_Skyrim_capa.png',
      tips: [
        const Tip(
            gameId: '0',
            id: '1',
            titulo: 'Como aprender fireball',
            conteudo: 'Aprendendo',
            categoria: 'Tutorial'),
        const Tip(
            gameId: '0',
            id: '2',
            titulo: 'Como derrotar Alduin',
            conteudo: 'Apelando',
            categoria: 'Dica'),
      ]),
  Jogo(
      id: '1',
      titulo: 'The Witcher 3',
      capaUrl:
          'https://upload.wikimedia.org/wikipedia/pt/0/06/TW3_Wild_Hunt.png',
      tips: []),
];
