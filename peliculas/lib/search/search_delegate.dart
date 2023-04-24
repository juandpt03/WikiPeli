import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peliculas/providers/movies_provider.dart';

import '../models/models.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('No se encontró resultados para $query');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return const Center(
        child: Icon(Icons.movie, size: 100, color: Colors.black38),
      );
    }
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);
    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return const Icon(Icons.movie, size: 100, color: Colors.black38);
        }
        final movies = snapshot.data!;
        return ListView.builder(
          itemBuilder: (context, index) => _MovieItem(movie: movies[index]),
          itemCount: movies.length,
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/images/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    );
  }
}
