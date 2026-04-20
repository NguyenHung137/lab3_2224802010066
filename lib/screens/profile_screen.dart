import 'package:flutter/material.dart';
import '../widgets/main_scaffold.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notif = true;
  bool _darkMode = true;
  bool _autoPlay = false;
  double _quality = 1080;

  final Map<String, dynamic> _stats = {
    'Đã xem': 24,
    'Yêu thích': 8,
    'Đánh giá': 15,
    'Nhận xét': 6,
  };

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 3,
      title: 'Hồ Sơ',
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_outlined, color: Colors.white),
          onPressed: () => _showEditDialog(context),
        ),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar & Info Card
            _buildProfileCard(),
            const SizedBox(height: 16),

            // Stats Row
            _buildStatsRow(),
            const SizedBox(height: 16),

            // Genres yêu thích
            _buildFavoriteGenres(),
            const SizedBox(height: 16),

            // Settings Card
            _buildSettingsCard(),
            const SizedBox(height: 16),

            // Account Card
            _buildAccountCard(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ---------- Profile Card ----------
  Widget _buildProfileCard() {
    return Card(
      color: const Color(0xFF1A1A2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Avatar
            Stack(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE94560), Color(0xFF0F3460)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE94560).withOpacity(0.4),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('A',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                Positioned(
                  bottom: 0, right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE94560),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const Color(0xFF1A1A2E), width: 2),
                    ),
                    child: const Icon(Icons.camera_alt,
                        color: Colors.white, size: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text('Nguyễn Văn A',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('2224802010066@student.edu.vn',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5), fontSize: 13)),
            const SizedBox(height: 8),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE94560), Color(0xFF0F3460)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('⭐ Thành viên Premium',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Stats ----------
  Widget _buildStatsRow() {
    return Card(
      color: const Color(0xFF1A1A2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _stats.entries.map((e) {
            return Column(
              children: [
                Text(e.value.toString(),
                    style: const TextStyle(
                        color: Color(0xFFE94560),
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(e.key,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  // ---------- Favorite Genres ----------
  Widget _buildFavoriteGenres() {
    final genres = [
      {'name': 'Hành Động', 'icon': Icons.local_fire_department, 'color': const Color(0xFFE94560), 'count': 10},
      {'name': 'Kinh Dị',   'icon': Icons.nights_stay,           'color': const Color(0xFF2C3E50), 'count': 7},
      {'name': 'Hoạt Hình', 'icon': Icons.animation,             'color': const Color(0xFF27AE60), 'count': 5},
      {'name': 'Tình Cảm',  'icon': Icons.favorite,              'color': const Color(0xFF9B59B6), 'count': 2},
    ];

    return Card(
      color: const Color(0xFF1A1A2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Thể Loại Yêu Thích',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...genres.map((g) {
              final color = g['color'] as Color;
              final count = g['count'] as int;
              final total = 10;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Icon(g['icon'] as IconData, color: color, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(g['name'] as String,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 13)),
                              Text('$count phim',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.4),
                                      fontSize: 11)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: count / total,
                              backgroundColor: Colors.white.withOpacity(0.1),
                              valueColor: AlwaysStoppedAnimation(color),
                              minHeight: 6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // ---------- Settings ----------
  Widget _buildSettingsCard() {
    return Card(
      color: const Color(0xFF1A1A2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text('Cài Đặt',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            SwitchListTile(
              title: const Text('Thông báo',
                  style: TextStyle(color: Colors.white)),
              subtitle: Text('Nhận tin tức phim mới',
                  style: TextStyle(color: Colors.white.withOpacity(0.4))),
              value: _notif,
              onChanged: (v) => setState(() => _notif = v),
              activeColor: const Color(0xFFE94560),
              secondary: const Icon(Icons.notifications_outlined,
                  color: Color(0xFFE94560)),
            ),
            SwitchListTile(
              title: const Text('Chế độ tối',
                  style: TextStyle(color: Colors.white)),
              subtitle: Text('Giao diện tối',
                  style: TextStyle(color: Colors.white.withOpacity(0.4))),
              value: _darkMode,
              onChanged: (v) => setState(() => _darkMode = v),
              activeColor: const Color(0xFFE94560),
              secondary: const Icon(Icons.dark_mode_outlined,
                  color: Color(0xFFE94560)),
            ),
            SwitchListTile(
              title: const Text('Tự động phát',
                  style: TextStyle(color: Colors.white)),
              subtitle: Text('Phát tập tiếp theo tự động',
                  style: TextStyle(color: Colors.white.withOpacity(0.4))),
              value: _autoPlay,
              onChanged: (v) => setState(() => _autoPlay = v),
              activeColor: const Color(0xFFE94560),
              secondary: const Icon(Icons.play_circle_outline,
                  color: Color(0xFFE94560)),
            ),
            // Chất lượng video - Slider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.hd_outlined, color: Color(0xFFE94560)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Chất lượng video',
                                style: TextStyle(color: Colors.white)),
                            Text('${_quality.toInt()}p',
                                style: const TextStyle(
                                    color: Color(0xFFE94560),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Slider(
                          value: _quality,
                          min: 360,
                          max: 1080,
                          divisions: 3,
                          label: '${_quality.toInt()}p',
                          activeColor: const Color(0xFFE94560),
                          inactiveColor: Colors.white12,
                          onChanged: (v) => setState(() => _quality = v),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Account ----------
  Widget _buildAccountCard(BuildContext context) {
    return Card(
      color: const Color(0xFF1A1A2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          _tile(Icons.lock_outline, 'Đổi mật khẩu', () {}),
          _tile(Icons.language_outlined, 'Ngôn ngữ', () {}),
          _tile(Icons.privacy_tip_outlined, 'Chính sách bảo mật', () {}),
          _tile(
            Icons.logout_rounded,
            'Đăng xuất',
                () => _showLogoutDialog(context),
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }

  Widget _tile(IconData icon, String label, VoidCallback onTap,
      {Color color = const Color(0xFFE94560)}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label,
          style: TextStyle(
              color: label == 'Đăng xuất' ? Colors.redAccent : Colors.white)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24),
      onTap: onTap,
    );
  }

  // ---------- Dialogs ----------
  void _showEditDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Chỉnh sửa hồ sơ',
                style: TextStyle(color: Colors.white,
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Tên hiển thị',
                labelStyle: const TextStyle(color: Colors.white54),
                filled: true, fillColor: const Color(0xFF0F0F1B),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE94560),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Lưu thay đổi',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Đăng xuất',
            style: TextStyle(color: Colors.white)),
        content: const Text('Bạn có chắc muốn đăng xuất?',
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy', style: TextStyle(color: Colors.white38)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushReplacementNamed(context, '/splash');
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent),
            child: const Text('Đăng xuất',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}