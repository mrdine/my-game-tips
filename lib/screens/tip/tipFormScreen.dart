import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mygametips/models/jogo.dart';
import 'package:mygametips/models/jogo_state.dart';
import 'package:mygametips/models/tip.dart';
import 'package:provider/provider.dart';

class TipFormScreen extends StatefulWidget {
  TipFormScreen();

  @override
  State<TipFormScreen> createState() => _TipFormScreenState();
}

class _TipFormScreenState extends State<TipFormScreen> {
  String dropDownValue = 'Dica';
  var tituloControler = TextEditingController();
  var conteudoControler = TextEditingController();

  _submit(JogoState lista, Jogo jogo) {
    final x = Tip(
      gameId: jogo.id,
      id: '12',
      titulo: tituloControler.text,
      conteudo: conteudoControler.text,
      categoria: dropDownValue,
    );
    lista.addTip(jogo, x);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final jogo = ModalRoute.of(context)!.settings.arguments as Jogo;
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicone uma Dica ${jogo.titulo}"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tituloControler,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Titulo',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: conteudoControler,
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
                      onPressed: () => _submit(lista, jogo),
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
