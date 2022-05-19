import 'package:flutter/material.dart';

class BooksDetails extends StatelessWidget {
  const BooksDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final libro = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del libro"),
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

  Widget _crearAppbar(libro) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          '${libro['nombre']}',
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('lib/assets/img/loading.gif'),
          image: NetworkImage(libro['portada']),
          fadeInDuration: const Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(libro, context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: libro['_id'],
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: NetworkImage(
                  libro['portada'],
                ),
                height: 150,
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
