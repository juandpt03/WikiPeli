import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:peliculas/models/models.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({super.key, required this.movies});
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: ((BuildContext context, index) {
          final movie = movies[index];
          movie.heroId = 'Swiper-${movie.id}';

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/loading/loading.gif'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
