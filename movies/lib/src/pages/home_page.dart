
import 'package:flutter/material.dart';
import 'package:movies/src/providers/peliculas.dart';
import 'package:movies/src/widgets/card_swiper.dart';

class HomePage extends StatelessWidget {

  final peliProvider = new PeliculasProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en Cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperTarjetas()
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
        return Center(
          heightFactor: 10.0,
          child: CircularProgressIndicator()
        );
      },
    );
  }
}