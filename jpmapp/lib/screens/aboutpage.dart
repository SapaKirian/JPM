import 'package:flutter/material.dart';

class AboutDealerPage extends StatelessWidget {
  const AboutDealerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi Warna Tema Yamaha
    const Color yamahaBlue = Color(0xff1B2A6B);
    const Color yamahaRed = Color(0xffED1C24);

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA), // Background sedikit abu agar card terlihat menonjol
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: yamahaBlue, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('assets/images/ASETJPM/LogoYamaha.png', height: 25),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HERO SECTION ---
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/ASETJPM/DEALER.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.2),
                        yamahaBlue.withOpacity(0.8),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: yamahaRed,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text("Dealer Resmi Yamaha", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Jaya Perkasa Motor\nSituraja",
                        style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, height: 1.1),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // --- ABOUT TEXT ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    "Melayani dengan Hati, Membangun Kepercayaan",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: yamahaBlue, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Jaya Perkasa Motor Situraja hadir sebagai solusi otomotif roda dua terlengkap di Sumedang. Kami bukan sekadar tempat jual beli, tapi partner perjalanan Anda dengan standar layanan global Yamaha.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.6),
                  ),
                ],
              ),
            ),

            // --- VISI MISI CARD ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: Row(
                children: [
                  _buildVisiMisi("VISI", "Menjadi barometer layanan dealer Yamaha terbaik & terpercaya.", Icons.auto_awesome),
                  Container(width: 1, height: 80, color: Colors.grey.shade200),
                  _buildVisiMisi("MISI", "Menyediakan produk berkualitas & servis presisi tinggi.", Icons.speed),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // --- KEUNGGULAN SECTION (EXPLORE) ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Mengapa Memilih Kami?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: yamahaBlue)),
            ),
            const SizedBox(height: 20),
            
            // List Keunggulan Detail
            _buildDetailedKeunggulan(
              "Bengkel Berstandar Yamaha",
              "Dilengkapi dengan tools modern dan komputerisasi untuk diagnosa motor injeksi (YDT) agar performa tetap maksimal.",
              'assets/images/ASETJPM/bengkel.jpg',
              Icons.settings_suggest,
            ),
            _buildDetailedKeunggulan(
              "Sparepart 100% Genuine",
              "Kami hanya menggunakan Yamaha Genuine Parts & Yamalube untuk memastikan keamanan dan keawetan mesin motor Anda.",
              'assets/images/ASETJPM/Sparepart.webp',
              Icons.verified,
            ),
            _buildDetailedKeunggulan(
              "Ruang Tunggu Nyaman",
              "Nikmati fasilitas ruang tunggu ber-AC, free Wi-Fi, dan kopi gratis selama motor Anda dalam penanganan teknisi kami.",
              'assets/images/ASETJPM/ruangtunggu.jpg',
              Icons.weekend,
            ),

            const SizedBox(height: 40),

            // --- LAYANAN TAMBAHAN ---
            Container(
              width: double.infinity,
              color: yamahaBlue,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  const Text("Layanan Cepat & Mudah", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildQuickIcon(Icons.local_shipping, "Home Delivery"),
                      _buildQuickIcon(Icons.home_repair_service, "Service Kunjung"),
                      _buildQuickIcon(Icons.payments, "Kredit Mudah"),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER ---

  Widget _buildVisiMisi(String title, String desc, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: const Color(0xffED1C24), size: 30),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xff1B2A6B))),
          const SizedBox(height: 5),
          Text(desc, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildDetailedKeunggulan(String title, String desc, String imagePath, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(imagePath, height: 150, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: const Color(0xff1B2A6B), size: 20),
                    const SizedBox(width: 8),
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(desc, style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.5)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuickIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.2),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
      ],
    );
  }
}