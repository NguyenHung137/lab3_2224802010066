import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedGenre = 'Tất cả';

  final List<String> _genres = [
    'Tất cả', 'Hành Động', 'Tình Cảm', 'Kinh Dị', 'Hoạt Hình'
  ];

  // Danh sách phim mẫu
  final List<Movie> _movies = [
    Movie(
      id: 1,
      title: 'Avengers: Endgame',
      genre: 'Hành Động',
      rating: 8.4,
      year: 2019,
      description:
      'Sau những sự kiện tàn khốc của Avengers: Infinity War, vũ trụ đang trong đống đổ nát. Với sự giúp đỡ của các đồng minh còn lại, các Avengers tập hợp một lần nữa để đảo ngược hành động của Thanos và khôi phục lại trật tự của vũ trụ.',
      imageUrl: 'https://via.placeholder.com/300x450/E94560/FFFFFF?text=Avengers',
    ),
    Movie(
      id: 2,
      title: 'Titanic',
      genre: 'Tình Cảm',
      rating: 7.9,
      year: 1997,
      description:
      'Một thiếu nữ귀족 và một chàng trai nghèo yêu nhau trên con tàu định mệnh Titanic. Bộ phim tình cảm lãng mạn gắn liền với bi kịch lịch sử nổi tiếng nhất thế giới.',
      imageUrl: 'https://via.placeholder.com/300x450/0F3460/FFFFFF?text=Titanic',
    ),
    Movie(
      id: 3,
      title: 'The Conjuring',
      genre: 'Kinh Dị',
      rating: 7.5,
      year: 2013,
      description:
      'Dựa trên câu chuyện có thật về các nhà thám tử hoang đường Ed và Lorraine Warren, những người điều tra một gia đình bị ám bởi một thế lực tối tăm.',
      imageUrl: 'https://via.placeholder.com/300x450/1A1A2E/FFFFFF?text=Conjuring',
    ),
    Movie(
      id: 4,
      title: 'Spider-Man: No Way Home',
      genre: 'Hành Động',
      rating: 8.2,
      year: 2021,
      description:
      'Với danh tính của Spider-Man bị tiết lộ, Peter Parker nhờ Doctor Strange giúp đỡ. Khi một phép thuật sai lầm mở ra đa vũ trụ, những kẻ thù nguy hiểm xuất hiện.',
      imageUrl: 'https://via.placeholder.com/300x450/E94560/FFFFFF?text=SpiderMan',
    ),
    Movie(
      id: 5,
      title: 'Your Name',
      genre: 'Hoạt Hình',
      rating: 8.4,
      year: 2016,
      description:
      'Một cậu thiếu niên ở Tokyo và một cô gái ở vùng quê hẻo lánh hoán đổi cơ thể cho nhau một cách kỳ diệu. Câu chuyện tình yêu xuyên không gian và thời gian.',
      imageUrl: 'https://via.placeholder.com/300x450/16213E/FFFFFF?text=YourName',
    ),
    Movie(
      id: 6,
      title: 'Parasite',
      genre: 'Kinh Dị',
      rating: 8.5,
      year: 2019,
      description:
      'Cả gia đình nhà Ki-taek đều thất nghiệp và đang phải sống chen chúc trong một căn hộ tầng hầm ẩm thấp. Mọi thứ thay đổi khi con trai cả Ki-woo được giới thiệu làm gia sư.',
      imageUrl: 'https://via.placeholder.com/300x450/0F3460/FFFFFF?text=Parasite',
    ),
  ];

  List<Movie> get _filteredMovies {
    if (_selectedGenre == 'Tất cả') return _movies;
    return _movies.where((m) => m.genre == _selectedGenre).toList();
  }

  // Phim nổi bật (rating cao nhất)
  Movie get _featuredMovie =>
      _movies.reduce((a, b) => a.rating > b.rating ? a : b);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1B),

      // Bottom Navigation
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF1A1A2E),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
          if (index == 1) {
            // ✅ Named Route điều hướng sang Favorites
            Navigator.pushNamed(context, '/favorites');
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Yêu thích',
          ),
        ],
      ),

      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 60,
            backgroundColor: const Color(0xFF0F0F1B),
            pinned: true,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE94560), Color(0xFF0F3460)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.movie_filter_rounded,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  'CineVault',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured Movie Banner
                  _buildFeaturedBanner(),
                  const SizedBox(height: 24),

                  // Genre Filter
                  _buildGenreFilter(),
                  const SizedBox(height: 16),

                  // Section title
                  const Text(
                    'Phim Nổi Bật',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Movie Grid
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
                    (context, index) => MovieCard(
                  movie: _filteredMovies[index],
                  onTap: () {
                    // ✅ MaterialPageRoute - truyền data
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: _filteredMovies[index],
                    );
                  },
                ),
                childCount: _filteredMovies.length,
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
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: _featuredMovie);
      },
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE94560), Color(0xFF0F3460)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE94560).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                Icons.local_fire_department_rounded,
                size: 180,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '🔥 Đánh giá cao nhất',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _featuredMovie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${_featuredMovie.rating} • ${_featuredMovie.genre} • ${_featuredMovie.year}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(
                          context, '/detail',
                          arguments: _featuredMovie,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFFE94560),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                        ),
                        icon: const Icon(Icons.play_arrow, size: 18),
                        label: const Text('Xem ngay',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreFilter() {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _genres.length,
        itemBuilder: (context, index) {
          final isSelected = _genres[index] == _selectedGenre;
          return GestureDetector(
            onTap: () => setState(() => _selectedGenre = _genres[index]),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                    colors: [Color(0xFFE94560), Color(0xFF0F3460)])
                    : null,
                color: isSelected ? null : const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.2),
                ),
              ),
              child: Text(
                _genres[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white60,
                  fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.normal,
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