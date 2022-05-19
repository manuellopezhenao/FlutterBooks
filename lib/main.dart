import 'package:books/pages/books_page.dart';
import 'package:books/pages/detalle_page.dart';
import 'package:books/pages/register_books.dart';
import 'package:books/provider/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
            create: (_) => BooksProvider(),

      child: MaterialApp(
        initialRoute: '/register',
        routes: {
          '/': (BuildContext context) => const BooksPage(),
          '/detalle': (BuildContext context) => const BooksDetails(),
          "/register": (BuildContext context) => const RegisterBooks(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
