
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BooksProvider with ChangeNotifier {
  // obtener todos los libros de la base de datos nodejs
  Future<List> getBooks() async {
    final response = await Dio().get('http://192.168.15.98:3000/listarlibros');

    return response.data;
  }


  // obtener todos los autores de la base de datos nodejs
  Future<List> getAutores() async {
    final response = await Dio().get('http://192.168.15.98:3000/listarautores');
    return response.data;
  }

  List autores = [];

  get autoresList {
    return autores;
  }

  set pushAutores(String autor) {
    autores.add(autor);
    notifyListeners();
  }
}
