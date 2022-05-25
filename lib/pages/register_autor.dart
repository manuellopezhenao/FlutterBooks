import 'package:books/provider/book_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterAutor extends StatelessWidget {
  const RegisterAutor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bookProvider = Provider.of<BooksProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          // mostrar alerta de carga
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const SizedBox(
                width: 100,
                height: 100,
                child: AlertDialog(
                  title: Text('Cargando'),
                  content: CircularProgressIndicator(),
                ),
              );
            },
          );

          await Dio().post('http://192.168.15.98:3000/guardarautor', data: {
            "nombre": _bookProvider.getnombreAutor,
            "nacionalidad": _bookProvider.getnacionalidadAutor,
            "foto_url": _bookProvider.getfotoUrl,
            "año_nacimiento": _bookProvider.getanoNacimientoAutor,
          }).then((value) {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        },
      ),
      appBar: AppBar(
        title: const Text('Registro de autores'),
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
                      initialValue: _bookProvider.getnombreAutor != ''
                          ? _bookProvider.getnombreAutor
                          : '',
                      onChanged: (value) =>
                          _bookProvider.setnombreAutor = value,
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
                      initialValue: _bookProvider.getnacionalidadAutor != ''
                          ? _bookProvider.getnacionalidadAutor
                          : '',
                      onChanged: (value) =>
                          _bookProvider.setnacionalidadAutor = value,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nacionalidad',
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
                            const Text("Foto"),
                            _bookProvider.getfotoUrl != ""
                                ? SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: FadeInImage(
                                      image: NetworkImage(
                                          _bookProvider.getfotoUrl),
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
                                          _bookProvider.setfotoUrl =
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
                      initialValue: _bookProvider.getanoNacimientoAutor != ''
                          ? _bookProvider.getanoNacimientoAutor.toString()
                          : '',
                      onChanged: (value) => _bookProvider
                          .setanoNacimientoAutor = value == "" ? 0 : int.parse(value),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'año nacimiento',
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
