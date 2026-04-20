import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  final int currentIndex;
  final Widget body;
  final String title;
  final List<Widget>? actions;

  const MainScaffold({
    super.key,
    required this.currentIndex,
    required this.body,
    required this.title,
    this.actions,
  });

  void _onTabTapped(BuildContext context, int index) {
    if (index == currentIndex) return;
    const routes = ['/home', '/search', '/favorites', '/profile'];
    Navigator.pushReplacementNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1B),

      // ===================== DRAWER =====================
      drawer: Drawer(
        backgroundColor: const Color(0xFF1A1A2E),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE94560), Color(0xFF0F3460)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              accountName: const Text(
                'Nguyễn Văn A',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              accountEmail: const Text('2224802010066@student.edu.vn'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'A',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFE94560),
                  ),
                ),
              ),
              otherAccountsPictures: [
                CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),

            // Menu items
            _drawerItem(context, Icons.home_rounded, 'Trang Chủ', '/home'),
            _drawerItem(context, Icons.search_rounded, 'Tìm Kiếm', '/search'),
            _drawerItem(context, Icons.favorite_rounded, 'Yêu Thích', '/favorites'),
            _drawerItem(context, Icons.person_rounded, 'Hồ Sơ', '/profile'),

            const Divider(color: Colors.white12, indent: 16, endIndent: 16),

            _drawerItem(context, Icons.category_rounded, 'Thể Loại', '/home',
                subtitle: 'Hành động, Tình cảm...'),
            _drawerItem(context, Icons.trending_up_rounded, 'Đang Thịnh Hành', '/home'),
            _drawerItem(context, Icons.new_releases_rounded, 'Mới Nhất', '/home'),

            const Divider(color: Colors.white12, indent: 16, endIndent: 16),

            _drawerItem(context, Icons.settings_rounded, 'Cài Đặt', '/profile'),
            _drawerItem(context, Icons.help_outline_rounded, 'Trợ Giúp', '/home'),

            const SizedBox(height: 20),

            // Version
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'CineVault v2.0\nMSSV: 2224802010066',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),

      // ===================== APP BAR =====================
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F1B),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            if (currentIndex == 0) ...[
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
            ],
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: actions,
        elevation: 0,
      ),

      // ===================== BODY =====================
      body: body,

      // ===================== BOTTOM NAVIGATION BAR =====================
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          indicatorColor: const Color(0xFFE94560).withOpacity(0.2),
          selectedIndex: currentIndex,
          onDestinationSelected: (index) => _onTabTapped(context, index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Colors.white54),
              selectedIcon: Icon(Icons.home_rounded, color: Color(0xFFE94560)),
              label: 'Trang Chủ',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_outlined, color: Colors.white54),
              selectedIcon: Icon(Icons.search_rounded, color: Color(0xFFE94560)),
              label: 'Tìm Kiếm',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline, color: Colors.white54),
              selectedIcon: Icon(Icons.favorite_rounded, color: Color(0xFFE94560)),
              label: 'Yêu Thích',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline, color: Colors.white54),
              selectedIcon: Icon(Icons.person_rounded, color: Color(0xFFE94560)),
              label: 'Hồ Sơ',
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
      BuildContext context,
      IconData icon,
      String label,
      String route, {
        String? subtitle,
      }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFE94560)),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      subtitle: subtitle != null
          ? Text(subtitle,
          style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11))
          : null,
      onTap: () {
        Navigator.pop(context); // đóng drawer
        Navigator.pushReplacementNamed(context, route);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    );
  }
}