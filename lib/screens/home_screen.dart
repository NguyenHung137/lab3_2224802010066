import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import '../widgets/main_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedGenre = 'Tất cả';

  final List<String> _genres = [
    'Tất cả', 'Hành Động', 'Tình Cảm', 'Kinh Dị', 'Hoạt Hình'
  ];

  final List<Movie> _movies = [
    Movie(id: 1, title: 'Avengers: Endgame', genre: 'Hành Động',
        rating: 8.4, year: 2019,
        description: 'Sau những sự kiện tàn khốc của Infinity War, các Avengers tập hợp một lần nữa để đảo ngược hành động của Thanos và khôi phục lại trật tự của vũ trụ.',
        imageUrl: ''),
    Movie(id: 2, title: 'Titanic', genre: 'Tình Cảm',
        rating: 7.9, year: 1997,
        description: 'Một thiếu nữ quý tộc và một chàng trai nghèo yêu nhau trên con tàu định mệnh Titanic. Bi kịch lịch sử lãng mạn nổi tiếng nhất thế giới.',
        imageUrl: ''),
    Movie(id: 3, title: 'The Conjuring', genre: 'Kinh Dị',
        rating: 7.5, year: 2013,
        description: 'Dựa trên câu chuyện có thật về các nhà thám tử Ed và Lorraine Warren điều tra gia đình bị ám bởi thế lực tối tăm.',
        imageUrl: ''),
    Movie(id: 4, title: 'Spider-Man: No Way Home', genre: 'Hành Động',
        rating: 8.2, year: 2021,
        description: 'Với danh tính bị tiết lộ, Peter Parker nhờ Doctor Strange giúp đỡ. Phép thuật sai lầm mở ra đa vũ trụ nguy hiểm.',
        imageUrl: ''),
    Movie(id: 5, title: 'Your Name', genre: 'Hoạt Hình',
        rating: 8.4, year: 2016,
        description: 'Một cậu thiếu niên Tokyo và cô gái vùng quê hoán đổi cơ thể. Câu chuyện tình yêu xuyên không gian và thời gian.',
        imageUrl: ''),
    Movie(id: 6, title: 'Parasite', genre: 'Kinh Dị',
        rating: 8.5, year: 2019,
        description: 'Gia đình Ki-taek thất nghiệp sống trong căn hộ tầng hầm. Mọi thứ thay đổi khi con trai được giới thiệu làm gia sư nhà giàu.',
        imageUrl: ''),
  ];

  List<Movie> get _filtered => _selectedGenre == 'Tất cả'
      ? _movies
      : _movies.where((m) => m.genre == _selectedGenre).toList();

  Movie get _featured =>
      _movies.reduce((a, b) => a.rating > b.rating ? a : b);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 0,
      title: 'CineVault',
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/search'),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {},
        ),
      ],
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeaturedBanner(),
                  const SizedBox(height: 20),
                  // Category chips
                  const Text('Danh Mục',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _buildCategoryRow(),
                  const SizedBox(height: 16),
                  const Text('Tất Cả Phim',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, i) => MovieCard(
                  movie: _filtered[i],
                  onTap: () => Navigator.pushNamed(context, '/detail',
                      arguments: _filtered[i]),
                ),
                childCount: _filtered.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildFeaturedBanner() {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/detail', arguments: _featured),
      child: Container(
        height: 190,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE94560), Color(0xFF0F3460)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -10, top: -10,
              child: Icon(Icons.local_fire_department_rounded,
                  size: 160, color: Colors.white.withOpacity(0.07)),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('🔥 Đánh giá cao nhất',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  const SizedBox(height: 8),
                  Text(_featured.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${_featured.rating} • ${_featured.genre} • ${_featured.year}',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 12),
                    ),
                  ]),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/detail',
                        arguments: _featured),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFE94560),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                    ),
                    icon: const Icon(Icons.play_arrow, size: 16),
                    label: const Text('Xem ngay',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow() {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _genres.length,
        itemBuilder: (context, index) {
          final sel = _genres[index] == _selectedGenre;
          return GestureDetector(
            onTap: () => setState(() => _selectedGenre = _genres[index]),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: sel
                    ? const LinearGradient(
                    colors: [Color(0xFFE94560), Color(0xFF0F3460)])
                    : null,
                color: sel ? null : const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: sel ? Colors.transparent : Colors.white24,
                ),
              ),
              child: Text(
                _genres[index],
                style: TextStyle(
                  color: sel ? Colors.white : Colors.white54,
                  fontWeight: sel ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}