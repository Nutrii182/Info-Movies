
import 'package:flutter/material.dart';
import 'package:movies/src/providers/peliculas.dart';
import 'package:movies/src/widgets/card_swiper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en Cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search ),
            onPressed: () {

            },
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

    final peliProvider = new PeliculasProvider();
    peliProvider.getEnCines();

    return CardSwiper(
      peliculas: [1,2,3,4,5],
    );

  }
}