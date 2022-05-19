import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BooksProvider {
  // obtener todos los libros de la base de datos nodejs
  Future<List> getBooks() async {
    final response = await Dio().get('http://172.22.40.99:3000/listarlibros');
    debugPrint(response.data.toString());
    return response.data;
  }
}
