// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mygametips/models/jogo.dart';
import 'package:provider/provider.dart';
import '../../utils/app_routes.dart';
import '../../models/jogo_state.dart';

class AddJogoFormScreen extends StatefulWidget {
  void Function(String titulo, String capaUrl) onSubmit;
  Jogo? jogo;
  AddJogoFormScreen(this.onSubmit, this.jogo);

  @override
  _AddJogoFormScreenState createState() => _AddJogoFormScreenState();
}

class _AddJogoFormScreenState extends State<AddJogoFormScreen> {
  final _tituloController = TextEditingController();
  final _capaUrlController = TextEditingController();

  bool _isLoading = false;

  _submitForm() {
    if (_tituloController.text.isEmpty || _capaUrlController.text.isEmpty) {
      return;
    }
    if (widget.jogo != null) {
      print('vim de editar');
    }
    widget.onSubmit(_tituloController.text, _capaUrlController.text);
  }

  @override
  Widget build(BuildContext context) {
    _tituloController.text = widget.jogo?.titulo ?? '';
    _capaUrlController.text = widget.jogo?.capaUrl ?? '';
    return Scaffold(
      appBar: widget.jogo != null
          ? AppBar(
              title: Text('Edite seu jogo'),
            )
          : null,
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
        Consumer<JogoState>(builder: (context, games, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  maximumSize: Size.fromHeight(50),
                  minimumSize: Size.fromHeight(50)),
              child: _isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : widget.jogo == null
                      ? Text("Adicionar")
                      : Text("Editar"),
              onPressed: () {
                if (_isLoading) return;
                setState(
                  () {
                    _isLoading = true;
                  },
                );
                if (widget.jogo == null) {
                  games
                      .addJogo(Jogo(
                        titulo: _tituloController.text,
                        capaUrl: _capaUrlController.text,
                        tips: [],
                      ))
                      .then(
                        (value) => Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.GAMES,
                        ),
                      );
                } else
                  _submitForm();
              },
            ),
          );
        }),
      ]),
    );
  }
}
