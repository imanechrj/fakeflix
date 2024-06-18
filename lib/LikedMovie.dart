import 'package:fakeflix/Models/liked_item_provider_model.dart';
import 'package:fakeflix/api_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LikedMovie extends StatelessWidget {
  const LikedMovie({super.key});

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
      body: Consumer<LikedItemsProvider>(
        builder: (context, likedItemsProvider, child) {
          final likedMovies = likedItemsProvider.likedItems.values.toList();
          return ListView.builder(
            itemCount: likedMovies.length,
            itemBuilder: (context, index) {
              final movie = likedMovies[index];
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
                        imageUrl:
                            '${ApiConfig.imageBaseUrl}${movie.posterPath}',
                        width: 60,
                        height: 120,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
                  ],
                ),
              );
            },
          );
        },
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
                icon: const Icon(Icons.home_outlined),
                onPressed: () => context.go('/'),
              ),
              IconButton(
                color: const Color.fromRGBO(178, 7, 16, 1),
                hoverColor: const Color.fromARGB(255, 192, 22, 10),
                icon: const Icon(Icons.favorite),
                onPressed: () => context.go('/liked'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
