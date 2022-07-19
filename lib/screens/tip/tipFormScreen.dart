import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygametips/models/jogo.dart';
import 'package:mygametips/models/jogo_state.dart';
import 'package:mygametips/models/tip.dart';
import 'package:mygametips/services/notification_service.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class TipFormScreen extends StatefulWidget {
  const TipFormScreen({Key? key});

  @override
  State<TipFormScreen> createState() => _TipFormScreenState();
}

class _TipFormScreenState extends State<TipFormScreen> {
  String dropDownValue = 'Dica';
  final _tituloControler = TextEditingController();
  final _conteudoControler = TextEditingController();
  File? image;

  _submit(JogoState lista, Jogo jogo, Tip? tip, BuildContext context) {
    if (tip == null) {
      if (image != null) {
        final name = basename(image!.path);
        final ref = FirebaseStorage.instance.ref('files/$name');
        ref.putFile(image!).then((p0) async {
          final downloadLink = await p0.ref.getDownloadURL();
          final x = Tip(
            gameId: jogo.id,
            id: '12',
            titulo: _tituloControler.text,
            conteudo: _conteudoControler.text,
            categoria: dropDownValue,
            image: downloadLink,
          );
          lista.addTip(jogo, x);
        });
      } else {
        final x = Tip(
          gameId: jogo.id,
          id: '12',
          titulo: _tituloControler.text,
          conteudo: _conteudoControler.text,
          categoria: dropDownValue,
        );
        lista.addTip(jogo, x);
      }
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
    Provider.of<NotificationService>(context, listen: false).showLocalNotification(
        CustomNotification(id: 12, title: 'Nova Tip Castrada', body: 'Uma nova tip foi cadastrada no Jogo ${jogo.titulo}'));
    Navigator.pop(context);
  }

  Future _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() {
      this.image = imageTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    if (arg['tip'] != null &&
        _tituloControler.text.isEmpty &&
        _conteudoControler.text.isEmpty) {
      setState(() {
        _tituloControler.text = arg['tip'].titulo;
        _conteudoControler.text = arg['tip'].conteudo;
        dropDownValue = arg['tip'].categoria;
      });
    }

    return Scaffold(
      appBar: AppBar(
          title: arg['jogo'] != null
              ? Text("Adicone uma Dica ${arg['jogo'].titulo}")
              : const Text("Editando Dica")),
      body: Center(
        child: SingleChildScrollView(
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
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Selecione uma imagem',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.photo_camera),
                    ),
                  ),
                  if (image != null)
                    Image.file(
                      image!,
                      width: 100,
                      height: 100,
                    )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    value: dropDownValue,
                    items: <String>['Dica', 'Tutorial']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dropDownValue = value!;
                      });
                    },
                  ),
                  Consumer<JogoState>(
                    builder: (context, lista, child) {
                      return ElevatedButton(
                        onPressed: () =>
                            _submit(lista, arg['jogo'], arg['tip'], context),
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
      ),
    );
  }
}
