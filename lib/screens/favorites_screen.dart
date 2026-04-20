import 'package:flutter/material.dart';
import '../widgets/main_scaffold.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 2,
      title: 'Yêu Thích',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border,
                size: 80, color: Colors.white.withOpacity(0.2)),
            const SizedBox(height: 20),
            Text('Chưa có phim yêu thích',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5), fontSize: 18)),
            const SizedBox(height: 10),
            Text('Thêm phim từ màn hình chi tiết!',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.3), fontSize: 14)),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE94560),
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.movie, color: Colors.white),
              label: const Text('Khám phá phim',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}