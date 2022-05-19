import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/book_provider.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
  final _bookProvider = Provider.of<BooksProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: FutureBuilder(
        future: _bookProvider.getBooks(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/detalle',
                        arguments: snapshot.data![index]);
                  },
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    snapshot.data![index]['nombre'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  ...snapshot.data![index]['autor']
                                      .map((autor) {
                                    return Text(
                                      autor["nombre"],
                                      style: const TextStyle(fontSize: 15),
                                    );
                                  }).toList()
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Hero(
                                tag: snapshot.data![index]['_id'],
                                child: FadeInImage(
                                  image: NetworkImage(
                                      snapshot.data![index]['portada']),
                                  placeholder:
                                      const AssetImage('assets/loading.gif'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: LinearProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
