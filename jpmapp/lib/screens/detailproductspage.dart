import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailProductPage extends StatefulWidget {
  final int motorId;
  final String motorName;
  final String? motorImage;

  const DetailProductPage({
    super.key,
    required this.motorId,
    required this.motorName,
    this.motorImage,
  });

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  final Color yamahaBlue = const Color(0xff1B2A6B);
  final Color yamahaAccent = const Color(0xff2541A8);

  final String baseUrl = 'http://localhost:8000/api';

  Map<String, dynamic>? motorDetail;
  bool isLoading = true;

  String? selectedVarian;
  String? selectedWarna;
  String? selectedGambar;

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/motors/${widget.motorId}'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          motorDetail = data;
          isLoading = false;

          final varianWarnas = data['detail']?['varian_warnas'] as List?;
          if (varianWarnas != null && varianWarnas.isNotEmpty) {
            selectedVarian = varianWarnas.first['nama_varian'];
            selectedWarna = varianWarnas.first['nama_warna'];
            selectedGambar = varianWarnas.first['gambar'];
          }
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint('Error: $e');
    }
  }

  List<Map<String, dynamic>> _getWarnasByVarian(String varian) {
    final varianWarnas =
        (motorDetail?['detail']?['varian_warnas'] as List?) ?? [];
    return varianWarnas
        .where((v) => v['nama_varian'] == varian)
        .map((v) => Map<String, dynamic>.from(v))
        .toList();
  }

  List<String> _getUniqueVarians() {
    final varianWarnas =
        (motorDetail?['detail']?['varian_warnas'] as List?) ?? [];
    return varianWarnas
        .map((v) => v['nama_varian'] as String)
        .toSet()
        .toList();
  }

  String _getHargaByVarian(String varian) {
    final daftarVarian =
        motorDetail?['detail']?['daftar_varian']?.toString() ?? '';
    final daftarHarga =
        motorDetail?['detail']?['daftar_harga']?.toString() ?? '';

    final varians = daftarVarian.split('\n').map((v) => v.trim()).toList();
    final hargas = daftarHarga.split('\n').map((h) => h.trim()).toList();

    final idx = varians.indexOf(varian);
    if (idx >= 0 && idx < hargas.length) {
      return 'Rp ${hargas[idx]}';
    }
    return '-';
  }

  Widget _buildImage(String? base64Image, {double height = 200}) {
    if (base64Image == null) {
      return Icon(Icons.motorcycle, size: 80, color: Colors.grey.shade300);
    }
    try {
      final bytes = base64Decode(base64Image.split(',').last);
      return Image.memory(bytes, height: height, fit: BoxFit.contain);
    } catch (e) {
      return Icon(Icons.motorcycle, size: 80, color: Colors.grey.shade300);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.motorName,
          style: TextStyle(
            color: yamahaBlue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: yamahaBlue))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== GAMBAR MOTOR (berubah sesuai warna) =====
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [yamahaBlue, yamahaAccent],
                      ),
                    ),
                    child: Center(
                      child: _buildImage(
                        selectedGambar ?? motorDetail?['gambar'],
                        height: 200,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ===== NAMA & KATEGORI =====
                        Text(
                          widget.motorName,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1A1A2E),
                          ),
                        ),
                        Text(
                          motorDetail?['kategori'] ?? '',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ===== PILIH VARIAN =====
                        if (_getUniqueVarians().isNotEmpty) ...[
                          const Text(
                            'Varian & Price',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _getUniqueVarians().map((varian) {
                              final isSelected = selectedVarian == varian;
                              return GestureDetector(
                                onTap: () {
                                  final warnas = _getWarnasByVarian(varian);
                                  setState(() {
                                    selectedVarian = varian;
                                    selectedWarna = warnas.isNotEmpty
                                        ? warnas.first['nama_warna']
                                        : null;
                                    selectedGambar = warnas.isNotEmpty
                                        ? warnas.first['gambar']
                                        : null;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? yamahaBlue
                                        : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    varian,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 10),

                          // Harga berdasarkan varian dipilih
                          if (selectedVarian != null)
                            Text(
                              _getHargaByVarian(selectedVarian!),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: yamahaBlue,
                              ),
                            ),

                          const SizedBox(height: 20),
                        ],

                        // ===== PILIH WARNA =====
                        if (selectedVarian != null &&
                            _getWarnasByVarian(selectedVarian!).isNotEmpty) ...[
                          const Text(
                            'Pilih Warna',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                _getWarnasByVarian(selectedVarian!).map((w) {
                              final isSelected =
                                  selectedWarna == w['nama_warna'];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedWarna = w['nama_warna'];
                                    selectedGambar = w['gambar'];
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? yamahaBlue.withOpacity(0.1)
                                        : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: isSelected
                                          ? yamahaBlue
                                          : Colors.transparent,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Text(
                                    w['nama_warna'] ?? '',
                                    style: TextStyle(
                                      color: isSelected
                                          ? yamahaBlue
                                          : Colors.black,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          if (selectedWarna != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              selectedWarna!,
                              style:
                                  TextStyle(color: Colors.grey.shade700),
                            ),
                          ],

                          const SizedBox(height: 20),
                        ],

                        // ===== DESKRIPSI =====
                        if (motorDetail?['deskripsi'] != null) ...[
                          Text(
                            widget.motorName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            motorDetail!['deskripsi'],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],

                        // ===== SPESIFIKASI =====
                        if (motorDetail?['detail'] != null) ...[
                          Text(
                            'Spesifikasi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: yamahaBlue,
                            ),
                          ),
                          const Divider(),
                          if (motorDetail!['detail']['mesin'] != null)
                            _buildSpecTile(
                              Icons.settings,
                              'Mesin',
                              motorDetail!['detail']['mesin'],
                            ),
                          if (motorDetail!['detail']['rangka'] != null)
                            _buildSpecTile(
                              Icons.motorcycle,
                              'Rangka',
                              motorDetail!['detail']['rangka'],
                            ),
                          if (motorDetail!['detail']['dimensi'] != null)
                            _buildSpecTile(
                              Icons.straighten,
                              'Dimensi',
                              motorDetail!['detail']['dimensi'],
                            ),
                          if (motorDetail!['detail']['kelistrikan'] != null)
                            _buildSpecTile(
                              Icons.flash_on,
                              'Kelistrikan',
                              motorDetail!['detail']['kelistrikan'],
                            ),
                          const SizedBox(height: 20),
                        ],

                        // ===== VIDEO =====
                        if (motorDetail?['detail']?['video_url'] != null) ...[
                          Text(
                            'Video',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: yamahaBlue,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.play_circle_fill,
                                color: Color(0xff1B2A6B),
                                size: 60,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],

                        // ===== TOMBOL HUBUNGI DEALER =====
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: yamahaBlue,
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Hubungi Dealer',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSpecTile(IconData icon, String title, String detail) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.black, size: 20),
      title: Text(
        title,
        style:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              detail,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}