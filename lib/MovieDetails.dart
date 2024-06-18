import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakeflix/Models/Movie.dart';
import 'package:fakeflix/MovieService.dart';
import 'package:fakeflix/api_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Moviedetails extends StatefulWidget {
  const Moviedetails({super.key, required this.id});

  final int id;

  @override
  State<Moviedetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<Moviedetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  onPressed: () => context.go('/'),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 40,
                  ));
            },
          ),
          title: const Text(
            'Fakeflix',
            style: TextStyle(
              color: Color.fromRGBO(178, 7, 16, 1),
              fontFamily: 'BebasNeue',
              fontSize: 40,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<Movie>(
            future: MovieService.getMovieById(widget.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return const Text("No data available");
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text("No movies found");
              } else {
                final movie = snapshot.data!;
                return BuildMovie(movie);
              }
            },
          ),
        ));
  }

  Widget BuildMovie(Movie movie) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: '${ApiConfig.imageBaseUrl}${movie.posterPath}',
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: double.infinity,
            height: 550,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text(
            movie.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(text: "Original Title : ${movie.originalTitle}"),
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Overview',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.overview,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Movie rate',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 5.0,
                percent: (movie.voteAverage / 10),
                center: Text("${movie.voteAverage}/10"),
                progressColor: Colors.green,
              ),
            ]),
          ),
          const SizedBox(height: 16),
          Row(children: [
            const Text(
              'Vote count : ',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text.rich(
              TextSpan(text: movie.voteCount.toString()),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            )
          ]),
          Row(children: [
            const Text(
              'Release Date : ',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text.rich(
              TextSpan(text: movie.releaseDate),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ]),
          Row(children: [
            const Text(
              'Original language : ',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text.rich(
              TextSpan(text: movie.originalLanguage),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ])
        ],
      ),
    ));
  }
}
