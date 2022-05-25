// create alert dialog for select autor

import 'package:books/provider/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget crearAlerta2(
  BuildContext context,
  autores,
) {
  final _bookProvider = Provider.of<BooksProvider>(context);

  return AlertDialog(
    title: const Text('Seleccione un autor'),
    content: SingleChildScrollView(
      child: ListBody(
        children: [
          ...autores.data.map((autor) {
            return Row(
              children: [
                Expanded(child: Text(autor['nombre'])),
                IconButton(
                    onPressed: () {
                      _bookProvider.saveautoresFormListEdit = autor;
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.add)),
              ],
            );
          }).toList(),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/registerAutor');
            },
            child: const Text('Agregar Autor'),
          ),
        ],
      ),
    ),
  );
}
