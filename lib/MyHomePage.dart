import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakeflix/Models/liked_item_provider_model.dart';
import 'package:fakeflix/MovieService.dart';
import 'package:fakeflix/api_config.dart';
import 'package:fakeflix/Models/Movie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomePage> {
  Future<List<Movie>> movies = MovieService.readMovies();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> _addIdToUser(int newId) async {
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    DocumentReference userDoc = _firestore.collection('users').doc(uid);
    await userDoc.update({
      'ids': FieldValue.arrayUnion([newId])
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
        child: FutureBuilder<List<Movie>>(
          future: movies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return const Text("No data available");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("No movies found");
            } else {
              final movies = snapshot.data!;
              return buildMovies(movies);
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                color: const Color.fromRGBO(178, 7, 16, 1),
                hoverColor: const Color.fromARGB(255, 192, 22, 10),
                icon: const Icon(Icons.home),
                onPressed: () => context.go('/'),
              ),
              IconButton(
                color: const Color.fromRGBO(178, 7, 16, 1),
                hoverColor: const Color.fromARGB(255, 192, 22, 10),
                icon: const Icon(Icons.favorite_border_outlined),
                onPressed: () => context.go('/liked'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMovies(List<Movie> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Container(
          color: const Color.fromARGB(255, 65, 65, 65),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 130,
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CachedNetworkImage(
                  imageUrl: '${ApiConfig.imageBaseUrl}${movie.posterPath}',
                  width: 60,
                  height: 120,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: Text.rich(
                  TextSpan(text: movie.title),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Consumer<LikedItemsProvider>(
                      builder: (context, likedItemsProvider, child) {
                        final isLiked =
                            likedItemsProvider.likedItems.containsKey(movie.id);
                        return IconButton(
                          onPressed: () {
                            if (isLiked) {
                              likedItemsProvider.removeItem(movie.id);
                            } else {
                              likedItemsProvider.addItem(movie.id, movie);
                              _addIdToUser(movie.id);
                            }
                          },
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.white,
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromRGBO(178, 7, 16, 1),
                        ),
                      ),
                      child: const Text.rich(
                        TextSpan(
                          text: 'Go',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        context.go(
                          '/movieDetails/${movie.id}',
                          extra: movie,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
