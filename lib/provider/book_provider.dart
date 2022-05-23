import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BooksProvider with ChangeNotifier {
  // obtener todos los libros de la base de datos nodejs
  Future<List> getBooks() async {
    final response = await Dio().get('http://192.168.1.3:3000/listarlibros');

    return response.data;
  }

  // obtener todos los autores de la base de datos nodejs
  Future<List> getAutores() async {
    final response = await Dio().get('http://192.168.1.3:3000/listarautores');
    return response.data;
  }

  Future<List> saveAutores(autor) async {
    final response =
        await Dio().post('http://192.168.1.3:3000/guardarautor', data: autor);
    return response.data;
  }

  get autoresList async {
    return await getAutores();
  }

  set putAutores(Map autor) {
    saveAutores(autor);
    notifyListeners();
  }

  List autoresForm = [];

  get getautoresFormList {
    return autoresForm;
  }

  set saveautoresFormList(autor) {
    autoresForm.add(autor);
    notifyListeners();
  }

  set deleteautoresFormList(autor) {
    autoresForm.remove(autor);
    notifyListeners();
  }

  crearJson(Map datos) async {
    Map json = {
      'isbn': datos['isbn'],
      'fecha_publicacion': datos['anopublicacion'],
      'nombre': datos['nombre'],
      'editorial': datos['editorial'],
      'genero': datos['genero'],
      'sinopsis': datos['sinopsis'],
      'precio': datos['precio'],
      'stock': datos['stock'],
      'autores': datos['autores'],
    };

    // guardar libro en la base de datos nodejs
    var a = Dio().post('http://92.168.1.4:3000/guardarlibro', data: json);
    debugPrint("$a");
  }

  int isbn = 0;
  int anopublicacion = 0;
  String nombre = '';
  String editorial = '';
  String genero = '';
  String sinopsis = '';
  double precio = 0.0;
  int stock = 0;
  String portada = '';

  get getportada {
    return portada;
  }

  uploadPortada(Uint8List portada) async {
    // guardar imagen en la base de datos nodejs
    final response = await Dio()
        .post('http://192.168.1.3:3000/upload', data: {"portada": portada});

    return response.data['id'];
  }

  set setportada(String portada) {
    this.portada = portada;
    notifyListeners();
  }

  get getisbn {
    return isbn;
  }

  set setisbn(int isbn) {
    this.isbn = isbn;
    notifyListeners();
  }

  get getanopublicacion {
    return anopublicacion;
  }

  set setanopublicacion(int anopublicacion) {
    this.anopublicacion = anopublicacion;
    notifyListeners();
  }

  get getnombre {
    return nombre;
  }

  set setnombre(String nombre) {
    this.nombre = nombre;
    notifyListeners();
  }

  get geteditorial {
    return editorial;
  }

  set seteditorial(String editorial) {
    this.editorial = editorial;
    notifyListeners();
  }

  get getgenero {
    return genero;
  }

  set setgenero(String genero) {
    this.genero = genero;
    notifyListeners();
  }

  get getsinopsis {
    return sinopsis;
  }

  set setsinopsis(String sinopsis) {
    this.sinopsis = sinopsis;
    notifyListeners();
  }

  get getprecio {
    return precio;
  }

  set setprecio(double precio) {
    this.precio = precio;
    notifyListeners();
  }

  get getstock {
    return stock;
  }

  set setstock(int stock) {
    this.stock = stock;
    notifyListeners();
  }
}
