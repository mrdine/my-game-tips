// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_routes.dart';
import '../../models/jogo.dart';

class AddJogoFormScreen extends StatefulWidget {
  void Function(String titulo, String capaUrl) onSubmit;

  AddJogoFormScreen(this.onSubmit);

  @override
  _AddJogoFormScreenState createState() => _AddJogoFormScreenState();
}

class _AddJogoFormScreenState extends State<AddJogoFormScreen> {
  final _tituloController = TextEditingController();
  final _capaUrlController = TextEditingController();

  _submitForm() {
    if (_tituloController.text.isEmpty || _capaUrlController.text.isEmpty) {
      print('valores invalidos');
      return;
    }
    widget.onSubmit(_tituloController.text, _capaUrlController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _tituloController,
            decoration: InputDecoration(
              labelText: 'Título',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _capaUrlController,
            decoration: InputDecoration(
              labelText: 'Capa URL',
            ),
          ),
        ),
        Consumer<ListJogoState>(builder: (context, games, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                child: Text("Adicionar"),
                onPressed: () {
                  games.addJogo(
                    Jogo(
                        id: games.getNextId(),
                        titulo: _tituloController.text,
                        capaUrl: _capaUrlController.text,
                        tips: []),
                  );
                  Navigator.pushReplacementNamed(context, AppRoutes.GAMES);
                }),
          );
        }),
      ]),
    );
  }
}
