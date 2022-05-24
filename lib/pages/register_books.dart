import 'package:books/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/book_provider.dart';

class RegisterBooks extends StatelessWidget {
  const RegisterBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bookProvider = Provider.of<BooksProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          // show dialog loading
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text('Guardando libro'),
                content: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
          //------
          List autores = [];

          for (var i = 0; i < _bookProvider.autoresForm.length; i++) {
            autores.add(_bookProvider.autoresForm[i]['_id']);
          }

          await Dio().post('http://192.168.15.98:3000/guardarlibro', data: {
            "isbn": _bookProvider.isbn,
            "año_publicacion": _bookProvider.anopublicacion,
            "nombre": _bookProvider.nombre,
            "editorial": _bookProvider.editorial,
            "genero": _bookProvider.genero,
            "sinopsis": _bookProvider.sinopsis,
            "portada": _bookProvider.portada,
            "precio": _bookProvider.getprecio,
            "stock": _bookProvider.getstock,
            "autor": autores,
          }).then((value) {
            Phoenix.rebirth(context);
          });
        },
      ),
      appBar: AppBar(
        title: const Text('Registro de libros'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SafeArea(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: _bookProvider.getisbn != 0
                          ? _bookProvider.getisbn.toString()
                          : '',
                      onChanged: (value) =>
                          _bookProvider.setisbn = int.parse(value),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'isbn',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: _bookProvider.getanopublicacion != 0
                          ? "${_bookProvider.getanopublicacion}"
                          : '',
                      onChanged: (value) =>
                          _bookProvider.setanopublicacion = int.parse(value),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Año de publicación',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: _bookProvider.getnombre != ''
                          ? _bookProvider.getnombre
                          : '',
                      onChanged: (value) => _bookProvider.setnombre = value,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nombre',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: _bookProvider.geteditorial != ''
                          ? _bookProvider.geteditorial
                          : '',
                      onChanged: (value) => _bookProvider.seteditorial = value,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Editorial',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: _bookProvider.getgenero != ''
                          ? _bookProvider.getgenero
                          : '',
                      onChanged: (value) => _bookProvider.setgenero = value,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Genero',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: _bookProvider.getsinopsis != ''
                          ? _bookProvider.getsinopsis
                          : '',
                      onChanged: (value) => _bookProvider.setsinopsis = value,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Sinopsis',
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // add border
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: const Color.fromARGB(255, 150, 144, 144),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Portada"),
                            _bookProvider.getportada != ""
                                ? SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: FadeInImage(
                                      image: NetworkImage(
                                          _bookProvider.getportada),
                                      placeholder: const AssetImage(
                                          'assets/loading.gif'),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () async {
                                      // show dialog progress
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const Dialog(
                                              child: SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                            );
                                          });

                                      final ImagePicker _picker = ImagePicker();
                                      await _picker
                                          .pickImage(
                                              source: ImageSource.gallery)
                                          .then((value) {
                                        value
                                            ?.readAsBytes()
                                            .then((value) async {
                                          var portada = await _bookProvider
                                              .uploadPortada(value);
                                          _bookProvider.setportada =
                                              portada.toString();
                                          Navigator.pop(context);
                                        });
                                      }).catchError((error) {});
                                    },
                                    icon:
                                        const Icon(Icons.photo_library_rounded))
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) => _bookProvider.setprecio =
                          value == "" ? 0 : double.parse(value),
                      initialValue: _bookProvider.getprecio != ''
                          ? _bookProvider.getprecio.toString()
                          : '',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Precio',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) => _bookProvider.setstock =
                          value == "" ? 0 : int.parse(value),
                      initialValue: _bookProvider.getstock != ''
                          ? _bookProvider.getstock.toString()
                          : '',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Stock',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Autores', style: TextStyle(fontSize: 20)),
                  ),
                  ..._bookProvider.autoresForm.map((autor) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // add border
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color.fromARGB(255, 150, 144, 144),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("${autor['nombre']}"),
                              IconButton(
                                  onPressed: () {
                                    _bookProvider.deleteautoresFormList = autor;
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        ));
                  }).toList(),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                cargando(_bookProvider.getAutores()));
                      },
                      child: const Icon(Icons.add))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget cargando(carga) {
  return FutureBuilder(
      future: carga,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return crearAlerta(context, snapshot);
        } else {
          return const CircularProgressIndicator();
        }
      });
}
