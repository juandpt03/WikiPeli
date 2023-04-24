import 'package:flutter/cupertino.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CastingCards extends StatelessWidget {
  final int movieId;
  const CastingCards({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getMoviesCast(movieId),
      builder: (context, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
              constraints: const BoxConstraints(maxWidth: 150),
              height: 180,
              child: const CupertinoActivityIndicator());
        }
        final cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
              itemBuilder: (context, index) => _CastCard(
                    actor: cast[index],
                  ),
              itemCount: cast.length,
              scrollDirection: Axis.horizontal),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({
    Key? key,
    required this.actor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage(
                'assets/images/no-image.jpg',
              ),
              image: NetworkImage(actor.fullProfilePathImg),
              fit: BoxFit.cover,
              height: 140,
              width: 100,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
