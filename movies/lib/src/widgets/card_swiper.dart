
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({ @required this.peliculas});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Expanded(
          child: Container(
        padding: EdgeInsets.only(top: 5.0),
        child: Swiper(
          itemCount: peliculas.length,
          // pagination: new SwiperPagination(),
          // control: new SwiperControl(),
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          itemBuilder: (BuildContext context,int index){

            peliculas[index].uniqueId = '${peliculas[index].id}-card';

            return Hero(
              child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                child: FadeInImage(
                  image: NetworkImageWithRetry(peliculas[index].getPosterImg()),
                  placeholder: AssetImage('assets/no-image.jpg'),
                  fit: BoxFit.cover,
                  ),
                onTap: () => Navigator.pushNamed(context, 'detalle', arguments: peliculas[index])
                ) 
              ),
            tag: peliculas[index].uniqueId,
            );
          },
        ),
      ),
    );
  }
}