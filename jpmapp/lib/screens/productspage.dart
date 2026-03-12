import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detailproductspage.dart';
import 'homepage.dart';

// --- MODEL DATA ---
class Motor {
  final int id;
  final String name;
  final String category;
  final String? imagePath;

  Motor({
    required this.id,
    required this.name,
    required this.category,
    this.imagePath,
  });

  factory Motor.fromJson(Map<String, dynamic> json) {
    return Motor(
      id: json['id'],
      name: json['nama_motor'],
      category: json['kategori'] ?? 'Lainnya',
      imagePath: json['gambar'],
    );
  }
}

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final Color yamahaBlue = const Color(0xff1B2A6B);
  final Color yamahaAccent = const Color(0xff2541A8);

  List<String> categories = [];
  List<Motor> allMotors = [];
  String selectedCategory = "";
  bool isLoading = true;

  String _searchQuery = '';
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  final String baseUrl = 'http://localhost:8000/api';

  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _categoryKeys = {};

  @override
  void initState() {
    super.initState();
    fetchMotors();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchMotors() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/motors'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final cats = List<String>.from(data['kategoris']);

        for (final cat in cats) {
          _categoryKeys[cat] = GlobalKey();
        }

        setState(() {
          categories = cats;
          allMotors = (data['motors'] as List)
              .map((m) => Motor.fromJson(m))
              .toList();
          selectedCategory = cats.isNotEmpty ? cats.first : '';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint('Error: $e');
    }
  }

  void _scrollToCategory(String category) {
    setState(() => selectedCategory = category);

    final key = _categoryKeys[category];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    }
  }

  // ✅ Fungsi navigate ke detail
  void _navigateToDetail(Motor motor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailProductPage(
          motorId: motor.id,
          motorName: motor.name,
          motorImage: motor.imagePath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // ===== APP BAR =====
          SliverAppBar(
            expandedHeight: 130,
            floating: false,
            pinned: true,
            backgroundColor: yamahaBlue,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: const Text(
                'Katalog Motor',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [yamahaBlue, yamahaAccent],
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Opacity(
                      opacity: 0.15,
                      child: Icon(
                        Icons.motorcycle,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ===== KATEGORI TAB (STICKY) =====
          SliverPersistentHeader(
            pinned: true,
            delegate: _CategoryHeaderDelegate(
              categories: categories,
              selectedCategory: selectedCategory,
              yamahaBlue: yamahaBlue,
              onCategoryTap: _scrollToCategory,
            ),
          ),

          // ===== KONTEN =====
          isLoading
              ? SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(color: yamahaBlue),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final cat = categories[index];
                    final filtered = allMotors
                        .where((m) => m.category == cat)
                        .toList();
                    if (filtered.isEmpty) return const SizedBox();

                    return Container(
                      key: _categoryKeys[cat],
                      margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader(cat),
                          const SizedBox(height: 12),
                          _buildProductGrid(filtered),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  }, childCount: categories.length),
                ),

          const SliverPadding(padding: EdgeInsets.only(bottom: 30)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 22,
              decoration: BoxDecoration(
                color: yamahaBlue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff1A1A2E),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Lihat Semua',
            style: TextStyle(
              color: yamahaBlue,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductGrid(List<Motor> motors) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: motors.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 240,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) => _buildProductCard(motors[index]),
    );
  }

  Widget _buildProductCard(Motor motor) {
    return GestureDetector(
      onTap: () => _navigateToDetail(motor),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Motor - tinggi fixed
            SizedBox(
              height: 150, // ✅ fixed height
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF0F3FF),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: _buildMotorImage(motor),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: yamahaBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          motor.category,
                          style: TextStyle(
                            color: yamahaBlue,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Info Motor - sisa tinggi
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      motor.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xff1A1A2E),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _navigateToDetail(motor),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: yamahaBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Detail',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMotorImage(Motor motor) {
    if (motor.imagePath == null) {
      return const Icon(Icons.motorcycle, size: 60, color: Color(0xffB0B8D1));
    }

    try {
      final bytes = base64Decode(motor.imagePath!.split(',').last);
      return Image.memory(
        bytes,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.motorcycle, size: 60, color: Color(0xffB0B8D1)),
      );
    } catch (e) {
      return const Icon(Icons.motorcycle, size: 60, color: Color(0xffB0B8D1));
    }
  }
}

// ===== STICKY CATEGORY HEADER =====
class _CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<String> categories;
  final String selectedCategory;
  final Color yamahaBlue;
  final Function(String) onCategoryTap;

  _CategoryHeaderDelegate({
    required this.categories,
    required this.selectedCategory,
    required this.yamahaBlue,
    required this.onCategoryTap,
  });

  @override
  double get minExtent => 60;

  @override
  double get maxExtent => 60;

  @override
  bool shouldRebuild(_CategoryHeaderDelegate oldDelegate) =>
      oldDelegate.selectedCategory != selectedCategory ||
      oldDelegate.categories != categories;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = selectedCategory == cat;

          return GestureDetector(
            onTap: () => onCategoryTap(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? yamahaBlue : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? yamahaBlue : Colors.grey.shade300,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: yamahaBlue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                cat,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade600,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
