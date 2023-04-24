import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class MovieSlider extends StatefulWidget {
  const MovieSlider(
      {super.key, required this.movies, this.title, required this.onNextPage});
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = widget.movies[index];
                return _MoviePoster(
                  movie: movie,
                  heroId: '${widget.title}-$index-${widget.movies[index].id}',
                );
              },
              itemCount: widget.movies.length,
            ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroId;
  const _MoviePoster({
    Key? key,
    required this.movie,
    required this.heroId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/loading/loading.gif'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(movie.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}
