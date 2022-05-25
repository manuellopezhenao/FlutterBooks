import 'package:books/provider/book_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  final _providerBooks = BooksProvider();
  @override
  List<Widget> buildActions(BuildContext context) {
    // la acciones del appbar
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
    //throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: _providerBooks.buscarLibroNombre(query),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!
                .map((pelicula) => ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          placeholder: const AssetImage('assets/loading.gif'),
                          image: NetworkImage(pelicula["portada"]),
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                      title: Text(pelicula["nombre"]),
                      onTap: () {
                        close(context, null);
                        Navigator.pushNamed(context, '/detalle',
                            arguments: pelicula);
                      },
                    ))
                .toList(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
