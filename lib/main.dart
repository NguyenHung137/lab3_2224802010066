import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/favorites_screen.dart';
import 'models/movie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A1A2E),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),

      // ✅ NAMED ROUTES
      initialRoute: '/splash',
      routes: {
        '/splash':     (context) => const SplashScreen(),
        '/home':       (context) => const HomeScreen(),
        '/favorites':  (context) => const FavoritesScreen(),
        // Detail dùng onGenerateRoute vì cần truyền data
      },

      // ✅ onGenerateRoute để truyền dữ liệu qua Named Route
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