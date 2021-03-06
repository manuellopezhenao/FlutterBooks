import 'dart:typed_data';

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

  Future<List> saveAutores(autor) async {
    final response =
        await Dio().post('http://192.168.15.98:3000/guardarautor', data: autor);
    return response.data;
  }

  Future<List> buscarLibroNombre(nombre) async {
    final response =
        await Dio().get('http://192.168.15.98:3000/buscarLibroNombre/$nombre');
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
  List autoresFormEdit = [];

  String newPortada = '';

  get getnewPortadaUrl {
    return newPortada;
  }

  set setnewPortadaUrl(String newPortada) {
    newPortada = newPortada;
    notifyListeners();
  }

  get getautoresFormList {
    return autoresForm;
  }

  set saveautoresFormList(autor) {
    autoresForm.add(autor);
    notifyListeners();
  }

  set removeautoresFormList(autor) {
    autoresFormEdit.remove(autor);
    notifyListeners();
  }

  get getautoresFormListEdit {
    return autoresFormEdit;
  }

  set autoresFormListEdit(autor) {
    autoresFormEdit = autor;
    // notifyListeners();
  }

  set saveautoresFormListEdit(autor) {
    autoresFormEdit.add(autor);
    notifyListeners();
  }

  set deleteautoresFormList(autor) {
    autoresForm.remove(autor);
    notifyListeners();
  }

  set deleteautoresFormListEdit(autor) {
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
  String nombreAutor = '';
  String nacionalidadAutor = '';
  String fotoUrl = '';
  int anoNacimientoAutor = 0;

  get getportada {
    return portada;
  }

  uploadPortada(Uint8List portada) async {
    final response = await Dio()
        .post('http://192.168.15.98:3000/upload', data: {"portada": portada});
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

  get getnombreAutor {
    return nombreAutor;
  }

  set setnombreAutor(String nombreAutor) {
    this.nombreAutor = nombreAutor;
    notifyListeners();
  }

  get getnacionalidadAutor {
    return nacionalidadAutor;
  }

  set setnacionalidadAutor(String nacionalidadAutor) {
    this.nacionalidadAutor = nacionalidadAutor;
    notifyListeners();
  }

  get getanoNacimientoAutor {
    return anoNacimientoAutor;
  }

  set setanoNacimientoAutor(int anoNacimientoAutor) {
    this.anoNacimientoAutor = anoNacimientoAutor;
    notifyListeners();
  }

  get getfotoUrl {
    return fotoUrl;
  }

  set setfotoUrl(String fotoUrl) {
    this.fotoUrl = fotoUrl;
    notifyListeners();
  }
}
