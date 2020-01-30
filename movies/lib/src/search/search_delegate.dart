
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/peliculas.dart';

class DataSearch extends SearchDelegate{

  String selection = '';
  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Fury',
    'Inglorious Bastards',
    'Hacksaw Ridge',
    'The Godfather',
    'Scarface',
    'The Pianist',
    'Pearl Harbor',
    'The Irishman',
    'Taxi Driver'
  ];

  final peliculasRecientes = [
    'The Irishman',
    'Taxi Driver'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {

    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.indigoAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query.isEmpty)
      return Container();
    
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {

        if(snapshot.hasData){
          
          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((pelicula){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImageWithRetry(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList()
          );
        }
          
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // final listSug = (query.isEmpty)
    //               ? peliculasRecientes : peliculas.where((p) => p.toLowerCase().
    //               startsWith(query.toLowerCase())).toList();

    // return ListView.builder(
    //   itemCount: listSug.length,
    //   itemBuilder: (context, i) {
    //     return ListTile(
    //       leading: Icon(Icons.movie),
    //       title: Text(listSug[i]),
    //       onTap: (){
    //         selection = listSug[i];
    //         showResults(context);
    //       },
    //     );
    //   },
    // );
  }

}