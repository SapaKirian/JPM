import 'package:flutter/material.dart';
import 'package:jpmapp/screens/login_page.dart';
import 'dart:async';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  late YoutubePlayerController _youtubeController;

  final List<String> banners = [
    'assets/images/ASETJPM/heroimage.jpg',
    'assets/images/ASETJPM/heroimage2.jpg',
    'assets/images/ASETJPM/heroimage5.jpg',
  ];

  final List<String> layanan = [
    'assets/images/ASETJPM/bengkel 2.jpeg',
    'assets/images/ASETJPM/DEALER.jpg',
    'assets/images/ASETJPM/Sparepart.webp',
    'assets/images/ASETJPM/MotorTerbaru.webp',
  ];

  final List<String> judulLayanan = [
    "Bengkel",
    "Dealer / Tentang Kami",
    "Sparepart",
    "Motor Terbaru",
  ];

  final List<Map<String, String>> promoData = [
    {
      'image': 'assets/images/ASETJPM/promo 4.webp',
      'title': 'Promo Spesial NMAX Turbo',
      'desc': 'Bawa pulang NMAX Turbo impian dengan DP mulai 2,8 Jutaan saja!',
    },
    {
      'image': 'assets/images/ASETJPM/promo2.webp',
      'title': 'Cukup Bayar 700rb-an',
      'desc': 'Miliki Fazzio Neo Hybrid dengan cicilan ringan dan pilihan warna baru.',
    },
  ];

  final Map<int, Map<String, String>> jadwalOperasional = {
    1: {'hari': 'Senin', 'jam': '08.00 - 16.30'},
    2: {'hari': 'Selasa', 'jam': '08.00 - 16.30'},
    3: {'hari': 'Rabu', 'jam': '08.00 - 16.30'},
    4: {'hari': 'Kamis', 'jam': '08.00 - 16.30'},
    5: {'hari': 'Jumat', 'jam': '08.00 - 16.30'},
    6: {'hari': 'Sabtu', 'jam': '08.00 - 16.30'},
    7: {'hari': 'Minggu', 'jam': '08.00 - 16.30'},
  };

  @override
  void initState() {
    super.initState();
    
    // Inisialisasi Youtube dengan flags yang lebih stabil
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'DiitRJH2_dHDf7pQ',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false, // Ubah ke true jika masih loading terus di awal
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _buildSidebar(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Image.asset('assets/images/ASETJPM/LogoYamaha.png', height: 25),
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, color: Colors.black),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== 1. BANNER SLIDER =====
            _buildBannerSlider(),

            /// ===== 2. LAYANAN KAMI =====
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text("Layanan Kami", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            _buildServiceGrid(),

            const SizedBox(height: 30),

            /// ===== 3. MOTOR TERBARU (YOUTUBE) =====
            const Center(
              child: Text("Motor Terbaru", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            _buildYoutubePlayer(),

            /// ===== 4. JADWAL BENGKEL DINAMIS =====
            _buildJadwalSection(),

            /// ===== 5. PROMO TERBARU =====
            const SizedBox(height: 20),
            const Center(
              child: Text("Promo Terbaru", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff1B2A6B))),
            ),
            _buildPromoSection(),

            const SizedBox(height: 20),

            /// ===== FOOTER =====
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // --- WIDGET COMPONENTS ---

  Widget _buildBannerSlider() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 200,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: banners.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(banners[index], fit: BoxFit.cover, width: double.infinity),
              );
            },
          ),
          Positioned(bottom: 10, left: 0, right: 0,
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(banners.length, (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 12 : 8, height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? const Color(0xff1B2A6B) : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: layanan.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          bool showButton = judulLayanan[index] != "Sparepart";
          return _buildServiceCard(judulLayanan[index], layanan[index], showButton: showButton);
        },
      ),
    );
  }

  Widget _buildYoutubePlayer() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: YoutubePlayer(
            controller: _youtubeController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: const Color(0xff1B2A6B),
            onReady: () {
              debugPrint('Youtube Player is Ready');
            },
          ),
        ),
      ),
    );
  }

  Widget _buildJadwalSection() {
    int dayIndex = DateTime.now().weekday;
    String hariIni = jadwalOperasional[dayIndex]!['hari']!;
    String jamOperasional = jadwalOperasional[dayIndex]!['jam']!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          const Center(child: Text("Jadwal Bengkel", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff1B2A6B)))),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(hariIni, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(4)),
                            child: const Text("HARI INI", style: TextStyle(color: Colors.white, fontSize: 8)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(jamOperasional, style: TextStyle(color: Colors.grey.shade700)),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset('assets/images/ASETJPM/bengkel.jpg', width: 110, height: 80, fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildPromoImage(promoData[0])),
          const SizedBox(width: 12),
          Expanded(child: _buildPromoImage(promoData[1])),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xff1B2A6B),
      width: double.infinity,
      child: const Text(
        "© 2025 Jaya Perkasa Motor. All Rights Reserved.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 11),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xff1B2A6B),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 80, left: 25, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Selamat Datang!", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("Silahkan login untuk akses penuh", style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            _buildMenuItem(Icons.login, "Login / Sign In", () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            }),
            _buildMenuItem(Icons.info_outline, "Tentang Dealer", () {}),
            _buildMenuItem(Icons.help_outline, "Bantuan", () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  Widget _buildServiceCard(String title, String imagePath, {bool showButton = true}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          if (showButton)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1B2A6B),
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  minimumSize: const Size(0, 28),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                ),
                child: const Text("Selengkapnya", style: TextStyle(fontSize: 10)),
              ),
            )
          else
            const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildPromoImage(Map<String, String> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(data['image']!, width: double.infinity, fit: BoxFit.contain),
        ),
        const SizedBox(height: 8),
        Text(data['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 2),
        Text(data['desc']!, style: TextStyle(color: Colors.grey[600], fontSize: 11), maxLines: 2, overflow: TextOverflow.ellipsis),
      ],
    );
  }
}