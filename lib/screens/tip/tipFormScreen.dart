import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mygametips/models/jogo.dart';
import 'package:mygametips/models/jogo_state.dart';
import 'package:mygametips/models/tip.dart';
import 'package:provider/provider.dart';

class TipFormScreen extends StatefulWidget {
  Tip? tip;

  TipFormScreen();

  @override
  State<TipFormScreen> createState() => _TipFormScreenState();
}

class _TipFormScreenState extends State<TipFormScreen> {
  String dropDownValue = 'Dica';
  final _tituloControler = TextEditingController();
  final _conteudoControler = TextEditingController();

  _submit(JogoState lista, Jogo jogo, Tip? tip) {
    if (tip == null) {
      final x = Tip(
        gameId: jogo.id,
        id: '12',
        titulo: _tituloControler.text,
        conteudo: _conteudoControler.text,
        categoria: dropDownValue,
      );
      lista.addTip(jogo, x);
    } else {
      Provider.of<JogoState>(context, listen: false).editTip(
          Tip(
            gameId: jogo.id,
            id: tip.id,
            titulo: _tituloControler.text,
            conteudo: _conteudoControler.text,
            categoria: dropDownValue,
          ),
          jogo);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _tituloControler.text = arg['tip']?.titulo ?? '';
    _conteudoControler.text = arg['tip']?.conteudo ?? '';
    dropDownValue = arg['tip']?.categoria ?? 'Dica';
    return Scaffold(
      appBar: AppBar(
          title: arg['jogo'] != null
              ? Text("Adicone uma Dica ${arg['jogo'].titulo}")
              : const Text("Editando Dica")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _tituloControler,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Titulo',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _conteudoControler,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Conteudo',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  value: dropDownValue,
                  items: <String>['Dica', 'Tutorial']
                      .map<DropdownMenuItem<String>>(
                    (value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    },
                  ).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dropDownValue = value!;
                    });
                  },
                ),
                Consumer<JogoState>(
                  builder: (context, lista, child) {
                    return ElevatedButton(
                      onPressed: () => _submit(lista, arg['jogo'], arg['tip']),
                      child: const Text(
                        'Adicionar',
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
