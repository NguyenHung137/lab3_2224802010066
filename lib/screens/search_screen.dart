import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/main_scaffold.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';
  String _selectedGenre = 'Tất cả';

  final List<String> _genres = [
    'Tất cả', 'Hành Động', 'Tình Cảm', 'Kinh Dị', 'Hoạt Hình'
  ];

  // Dữ liệu phim đầy đủ
  final List<Movie> _allMovies = [
    Movie(id: 1, title: 'Avengers: Endgame', genre: 'Hành Động',
        rating: 8.4, year: 2019,
        description: 'Các Avengers tập hợp lần cuối để đánh bại Thanos.',
        imageUrl: ''),
    Movie(id: 2, title: 'Titanic', genre: 'Tình Cảm',
        rating: 7.9, year: 1997,
        description: 'Tình yêu trên con tàu định mệnh.',
        imageUrl: ''),
    Movie(id: 3, title: 'The Conjuring', genre: 'Kinh Dị',
        rating: 7.5, year: 2013,
        description: 'Điều tra căn nhà bị ám.', imageUrl: ''),
    Movie(id: 4, title: 'Spider-Man: No Way Home', genre: 'Hành Động',
        rating: 8.2, year: 2021,
        description: 'Peter Parker mở đa vũ trụ.', imageUrl: ''),
    Movie(id: 5, title: 'Your Name', genre: 'Hoạt Hình',
        rating: 8.4, year: 2016,
        description: 'Tình yêu xuyên không gian thời gian.', imageUrl: ''),
    Movie(id: 6, title: 'Parasite', genre: 'Kinh Dị',
        rating: 8.5, year: 2019,
        description: 'Ký sinh trùng xã hội.', imageUrl: ''),
    Movie(id: 7, title: 'Black Panther', genre: 'Hành Động',
        rating: 7.3, year: 2018,
        description: 'Vua của vương quốc Wakanda.', imageUrl: ''),
    Movie(id: 8, title: 'La La Land', genre: 'Tình Cảm',
        rating: 8.0, year: 2016,
        description: 'Tình yêu giữa nhạc sĩ và diễn viên.', imageUrl: ''),
  ];

  List<Movie> get _results {
    return _allMovies.where((m) {
      final matchGenre =
          _selectedGenre == 'Tất cả' || m.genre == _selectedGenre;
      final matchQuery =
          _query.isEmpty || m.title.toLowerCase().contains(_query.toLowerCase());
      return matchGenre && matchQuery;
    }).toList();
  }

  Color _genreColor(String g) {
    switch (g) {
      case 'Hành Động': return const Color(0xFFE94560);
      case 'Tình Cảm': return const Color(0xFF9B59B6);
      case 'Kinh Dị': return const Color(0xFF2C3E50);
      case 'Hoạt Hình': return const Color(0xFF27AE60);
      default: return const Color(0xFF0F3460);
    }
  }

  IconData _genreIcon(String g) {
    switch (g) {
      case 'Hành Động': return Icons.local_fire_department;
      case 'Tình Cảm': return Icons.favorite;
      case 'Kinh Dị': return Icons.nights_stay;
      case 'Hoạt Hình': return Icons.animation;
      default: return Icons.movie;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 1,
      title: 'Tìm Kiếm',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              controller: _controller,
              onChanged: (v) => setState(() => _query = v),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Tìm kiếm phim...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFE94560)),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white54),
                  onPressed: () {
                    _controller.clear();
                    setState(() => _query = '');
                  },
                )
                    : null,
                filled: true,
                fillColor: const Color(0xFF1A1A2E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE94560), width: 1.5),
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Genre filter chips (Material Design Chip)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _genres.length,
                itemBuilder: (context, i) {
                  final sel = _genres[i] == _selectedGenre;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(_genres[i]),
                      selected: sel,
                      onSelected: (_) =>
                          setState(() => _selectedGenre = _genres[i]),
                      backgroundColor: const Color(0xFF1A1A2E),
                      selectedColor: const Color(0xFFE94560).withOpacity(0.3),
                      checkmarkColor: const Color(0xFFE94560),
                      labelStyle: TextStyle(
                        color: sel ? const Color(0xFFE94560) : Colors.white54,
                        fontWeight:
                        sel ? FontWeight.bold : FontWeight.normal,
                        fontSize: 12,
                      ),
                      side: BorderSide(
                        color: sel
                            ? const Color(0xFFE94560)
                            : Colors.white12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Result count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Tìm thấy ${_results.length} phim',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.4), fontSize: 13),
            ),
          ),

          const SizedBox(height: 8),

          // Results list
          Expanded(
            child: _results.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off,
                      size: 70,
                      color: Colors.white.withOpacity(0.15)),
                  const SizedBox(height: 16),
                  Text(
                    'Không tìm thấy phim',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 16),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _results.length,
              itemBuilder: (context, i) {
                final movie = _results[i];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/detail',
                      arguments: movie),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A2E),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        // Poster thumbnail
                        Container(
                          width: 80,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                _genreColor(movie.genre),
                                _genreColor(movie.genre).withOpacity(0.4),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(16)),
                          ),
                          child: Icon(
                            _genreIcon(movie.genre),
                            color: Colors.white.withOpacity(0.5),
                            size: 36,
                          ),
                        ),
                        // Info
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(movie.title,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                const SizedBox(height: 4),
                                Row(children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _genreColor(movie.genre)
                                          .withOpacity(0.2),
                                      borderRadius:
                                      BorderRadius.circular(6),
                                    ),
                                    child: Text(movie.genre,
                                        style: TextStyle(
                                            color: _genreColor(movie.genre),
                                            fontSize: 11)),
                                  ),
                                  const SizedBox(width: 6),
                                  Text('${movie.year}',
                                      style: TextStyle(
                                          color: Colors.white
                                              .withOpacity(0.4),
                                          fontSize: 12)),
                                ]),
                                const SizedBox(height: 6),
                                Text(
                                  movie.description,
                                  style: TextStyle(
                                      color:
                                      Colors.white.withOpacity(0.5),
                                      fontSize: 12),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Rating
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Column(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 16),
                              Text(
                                movie.rating.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}