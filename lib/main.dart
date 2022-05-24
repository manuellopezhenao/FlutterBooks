import 'package:books/pages/books_page.dart';
import 'package:books/pages/detalle_page.dart';
import 'package:books/pages/edit_books.dart';
import 'package:books/pages/register_autor.dart';
import 'package:books/pages/register_books.dart';
import 'package:books/provider/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BooksProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => const BooksPage(),
          '/detalle': (BuildContext context) => const BooksDetails(),
          "/register": (BuildContext context) => const RegisterBooks(),
          "/edit": (BuildContext context) => const EditBooks(
                libro: {},
              ),
            "/registerAutor": (BuildContext context) => const RegisterAutor(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
