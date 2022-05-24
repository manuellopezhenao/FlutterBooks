import 'package:books/pages/edit_books.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class BooksDetails extends StatelessWidget {
  const BooksDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final libro = (ModalRoute.of(context)?.settings.arguments as Map);
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle del libro ${libro['nombre']}"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditBooks(libro: libro)));
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                // showDialog for charging the dialog
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Eliminar libro"),
                        content:
                            const Text("¿Esta seguro de eliminar el libro?"),
                        actions: [
                          TextButton(
                            child: const Text("Cancelar"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text("Eliminar"),
                            onPressed: () {
                              // mostrar icono de carga
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return const AlertDialog(
                                      title: Text("Eliminando"),
                                      content: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    );
                                  });

                              Dio()
                                  .delete(
                                      'http://192.168.15.98:3000/eliminarlibro/${libro["_id"]}')
                                  .then((value) {
                                // mostrar dialogo de confirmacion
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Libro eliminado"),
                                        content: const Text(
                                            "Libro eliminado con exito"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Phoenix.rebirth(context);
                                            },
                                            child: const Text("Aceptar"),
                                          )
                                        ],
                                      );
                                    });
                              });
                            },
                          ),
                        ],
                      );
                    });

                // delete book of database
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SafeArea(
          child: Column(
            children: [
              _posterTitulo(libro, context),
              _descripcion(libro),
              _crearCasting(libro, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _posterTitulo(libro, context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: libro['_id'],
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: NetworkImage(libro['portada']),
                      fadeInDuration: const Duration(milliseconds: 150),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  libro['nombre'],
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Center(
                child: Text(
                  'Editorial - ${libro['editorial']}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Center(
                child: Text(
                  'Genero - ${libro['genero']}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Precio - ',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Icon(
                    Icons.attach_money,
                    color: Colors.green,
                  ),
                  Text(
                    '${libro['precio']}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              )),
              Center(
                child: Text(
                  'Stock - ${libro['stock']}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const SizedBox(height: 10),
              // Row(
              //   children: [
              //     const Icon(Icons.star_border),
              //     Text(
              //       pelicula.voteAverage.toString(),
              //       style: Theme.of(context).textTheme.headline6,
              //     )
              //   ],
              // ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _descripcion(libro) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Text(
        libro['sinopsis'],
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(autores, context) {
    autores = autores['autor'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Autores',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: autores.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                              placeholder:
                                  const AssetImage('assets/loading.gif'),
                              image: NetworkImage(autores[index]['foto_url']),
                              fadeInDuration: const Duration(milliseconds: 150),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        autores[index]['nombre'],
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${autores[index]['año_nacimiento']} - ${autores[index]['nacionalidad']}",
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Text(
                      //   autores[index]['nombre'],
                      //   style: Theme.of(context).textTheme.subtitle1,
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
