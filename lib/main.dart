import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/search_screen.dart';
import 'screens/profile_screen.dart';
import 'models/movie.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineVault – 2224802010066',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE94560),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash':    (context) => const SplashScreen(),
        '/home':      (context) => const HomeScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/search':    (context) => const SearchScreen(),
        '/profile':   (context) => const ProfileScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final movie = settings.arguments as Movie;
          return MaterialPageRoute(
            builder: (context) => DetailScreen(movie: movie),
          );
        }
        return null;
      },
    );
  }
}