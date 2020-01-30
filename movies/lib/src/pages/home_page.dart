
import 'package:flutter/material.dart';
import 'package:movies/src/providers/peliculas.dart';
import 'package:movies/src/search/search_delegate.dart';
import 'package:movies/src/widgets/card_swiper.dart';
import 'package:movies/src/widgets/row_movies.dart';

class HomePage extends StatelessWidget {

  final peliProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en Cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch()
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      )
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if(snapshot.hasData)
          return CardSwiper(peliculas: snapshot.data);
        else{
          return Center(
          heightFactor: 5.0,
          child: CircularProgressIndicator()
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares',
            style: Theme.of(context).textTheme.subhead)
          ),
          SizedBox(height: 1.0),

          StreamBuilder(
            stream: peliProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              //snapshot.data?.forEach((p) => print(p.title));
              if(snapshot.hasData)
                return RowMovies(
                  peliculas: snapshot.data,
                  nextPage: peliProvider.getPopulares,
                );
              else{
                return Center(
                heightFactor: 10.0,
                child: CircularProgressIndicator()
                );
              }
            },
          ),
        ],
      ),
    );
  }
}