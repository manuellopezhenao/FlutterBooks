import 'package:books/widgetsEdit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/book_provider.dart';

class EditBooks extends StatefulWidget {
  const EditBooks({Key? key, required this.libro}) : super(key: key);
  final libro;

  @override
  State<EditBooks> createState() => _EditBooksState();
}

class _EditBooksState extends State<EditBooks> {
  @override
  Widget build(BuildContext context) {

    // Object?  libro = ModalRoute.of(context)?.settings.arguments;
    final _bookProvider = Provider.of<BooksProvider>(context);
    _bookProvider.autoresFormListEdit = widget.libro['autor'];

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


          List autores = [];

          for (var i = 0; i < _bookProvider.getautoresFormListEdit.length; i++) {
            autores.add(_bookProvider.getautoresFormListEdit[i]['_id']);
          }

          debugPrint(autores.toString());

          await Dio().put(
              'http://192.168.15.98:3000/actualizarlibro/${widget.libro["_id"]}',
              data: {
                // "_id": libro['_id'],
                "isbn": widget.libro['isbn'],
                "año_publicacion": widget.libro['año_publicacion'],
                "nombre": widget.libro['nombre'],
                "editorial": widget.libro['editorial'],
                "genero": widget.libro['genero'],
                "sinopsis": widget.libro['sinopsis'],
                "portada": widget.libro['portada'],
                "precio": widget.libro['precio'],
                "stock": widget.libro['stock'],
                "autor": autores,
              }).then((value) {
            Phoenix.rebirth(context);
          });
        },
      ),
      appBar: AppBar(
        title: const Text('Actualizacion de libro'),
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
                      initialValue:
                          widget.libro['isbn'] != 0 ? widget.libro['isbn'].toString() : '',
                      onChanged: (value) => widget.libro['isbn'] = int.parse(value),
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
                      initialValue: widget.libro['año_publicacion'] != 0
                          ? "${widget.libro['año_publicacion']}"
                          : '',
                      onChanged: (value) =>
                          widget.libro['año_publicacion'] = int.parse(value),
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
                      initialValue:
                          widget.libro['nombre'] != '' ? widget.libro['nombre'] : '',
                      onChanged: (value) => widget.libro["nombre"] = value,
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
                      initialValue:
                          widget.libro["editorial"] != '' ? widget.libro["editorial"] : '',
                      onChanged: (value) => widget.libro["editorial"] = value,
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
                      initialValue:
                          widget.libro["genero"] != '' ? widget.libro["genero"] : '',
                      onChanged: (value) => widget.libro["genero"] = value,
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
                      initialValue:
                          widget.libro["sinopsis"] != '' ? widget.libro["sinopsis"] : '',
                      onChanged: (value) => widget.libro["sinopsis"] = value,
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
                            widget.libro["portada"] != ""
                                ? GestureDetector(
                                  onTap: () async{
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
                                          widget.libro["portada"] = portada.toString();
                                          setState(() {
                                            
                                          });
                                          Navigator.pop(context);
                                        });
                                      }).catchError((error) {});
                                  },
                                  child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: FadeInImage(
                                        image: NetworkImage(widget.libro["portada"]),
                                        placeholder: const AssetImage(
                                            'assets/loading.gif'),
                                        fit: BoxFit.cover,
                                      ),
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
                                          widget.libro["portada"] = portada.toString();
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
                      onChanged: (value) => widget.libro["precio"] = value == "" ? 0 : double.parse(value),
                      initialValue: widget.libro["precio"] != ''
                          ? widget.libro["precio"].toString()
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
                      onChanged: (value) => widget.libro["stock"] = value == "" ? 0 : int.parse(value),
                      initialValue:
                          widget.libro["stock"] != '' ? widget.libro["stock"].toString() : '',
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
                  ..._bookProvider.getautoresFormListEdit.map((autor) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
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
                                    _bookProvider.removeautoresFormList = autor;
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
          return crearAlerta2(context, snapshot);
        } else {
          return const CircularProgressIndicator();
        }
      });
}


// crear StatelessWidget que recibe datos

