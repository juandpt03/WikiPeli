import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(movie: movie),
                _OverView(movie: movie),
                CastingCards(
                  movieId: movie.id,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  final Movie movie;
  const _OverView({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;
  const _PosterAndTitle({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Hero(
          tag: movie.heroId!,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/images/no-image.jpg'),
              image: NetworkImage(movie.fullPosterImg),
              height: 150,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: size.width - 190),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                movie.originalTitle,
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_outline,
                    size: 15,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    movie.voteAverage.toString(),
                    style: textTheme.caption,
                  )
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomAppBar({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: Colors.black12,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Text(
            textAlign: TextAlign.center,
            movie.title,
            style: const TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading/loading.gif'),
          image: NetworkImage(movie.fullBackDropPathImg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
