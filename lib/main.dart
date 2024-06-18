import 'package:fakeflix/LikedMovie.dart';
import 'package:fakeflix/Models/Movie.dart';
import 'package:fakeflix/Models/liked_item_provider_model.dart';
import 'package:fakeflix/MovieDetails.dart';
import 'package:fakeflix/SignIn.dart';
import 'package:fakeflix/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:fakeflix/MyHomePage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
        create: (context) => LikedItemsProvider(), child: const MainApp()),
  );
}

final _router = GoRouter(
  initialLocation: '/SignIn',
  routes: [
    GoRoute(
        name: 'SignIn',
        path: '/SignIn',
        builder: (context, state) {
          return const SignInPage();
        }),
    GoRoute(
        name: 'home',
        path: '/',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              child: const MyHomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              });
        }),
    GoRoute(
      path: '/movieDetails/:id',
      builder: (context, state) {
        final movie = state.extra as Movie;
        return Moviedetails(id: movie.id);
      },
    ),
    GoRoute(
        path: '/liked',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              child: const LikedMovie(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              });
        }),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FakeFlix',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
    );
  }
}
