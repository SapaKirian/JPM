import 'package:flutter/material.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  final Color yamahaBlue = const Color(0xff1B2A6B);

  // Dummy data keranjang
  List<Map<String, dynamic>> cartItems = [
    {
      'id': 1,
      'nama': 'XSR-155',
      'harga': 35000000,
      'qty': 1,
      'gambar': null, // ganti dengan base64 atau asset
      'warna': 'Matte Black',
    },
    {
      'id': 2,
      'nama': 'XSR-155',
      'harga': 35000000,
      'qty': 1,
      'gambar': null,
      'warna': 'Racing Blue',
    },
    {
      'id': 3,
      'nama': 'XSR-155',
      'harga': 35000000,
      'qty': 1,
      'gambar': null,
      'warna': 'Predator Grey',
    },
  ];

  String selectedFilter = 'Semua';

  String _formatHarga(int harga) {
    return 'Rp ${harga.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
        )}';
  }

  int get _totalBarang =>
      cartItems.fold(0, (sum, item) => sum + (item['qty'] as int));

  int get _subtotal => cartItems.fold(
      0, (sum, item) => sum + (item['harga'] as int) * (item['qty'] as int));

  void _hapusSemua() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Semua'),
        content:
            const Text('Apakah kamu yakin ingin menghapus semua item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              setState(() => cartItems.clear());
              Navigator.pop(context);
            },
            child:
                const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _hapusItem(int index) {
    setState(() => cartItems.removeAt(index));
  }

  void _updateQty(int index, int delta) {
    setState(() {
      cartItems[index]['qty'] =
          (cartItems[index]['qty'] as int) + delta;
      if (cartItems[index]['qty'] <= 0) {
        cartItems.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Keranjang',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          if (cartItems.isNotEmpty)
            TextButton.icon(
              onPressed: _hapusSemua,
              icon: const Icon(Icons.delete_outline,
                  color: Colors.red, size: 18),
              label: const Text(
                'Hapus',
                style: TextStyle(color: Colors.red, fontSize: 13),
              ),
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                // ===== FILTER TAB =====
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  child: Row(
                    children: ['Semua', 'Motor', 'Sparepart']
                        .map((f) => _buildFilterChip(f))
                        .toList(),
                  ),
                ),

                const SizedBox(height: 8),

                // ===== LIST ITEM =====
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    itemCount: cartItems.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) =>
                        _buildCartItem(index),
                  ),
                ),

                // ===== RINGKASAN & CHECKOUT =====
                _buildBottomSection(),
              ],
            ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = label),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? yamahaBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? yamahaBlue : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontSize: 13,
            fontWeight:
                isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem(int index) {
    final item = cartItems[index];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Gambar Motor
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xffF0F3FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: item['gambar'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(item['gambar'],
                        fit: BoxFit.contain),
                  )
                : Icon(Icons.motorcycle,
                    size: 40, color: Colors.grey.shade300),
          ),

          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['nama'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xff1A1A2E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item['warna'],
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _formatHarga(item['harga']),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: yamahaBlue,
                  ),
                ),
              ],
            ),
          ),

          // Qty Controls + Hapus
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Tombol hapus item
              GestureDetector(
                onTap: () => _hapusItem(index),
                child: Icon(Icons.delete_outline,
                    size: 18, color: Colors.grey.shade400),
              ),
              const SizedBox(height: 10),
              // Qty counter
              Row(
                children: [
                  _buildQtyButton(
                    icon: Icons.remove,
                    onTap: () => _updateQty(index, -1),
                  ),
                  Container(
                    width: 32,
                    alignment: Alignment.center,
                    child: Text(
                      '${item['qty']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  _buildQtyButton(
                    icon: Icons.add,
                    onTap: () => _updateQty(index, 1),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQtyButton(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 14, color: Colors.black87),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Ringkasan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ringkasan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'Barang ($_totalBarang)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
              Text(
                _formatHarga(_subtotal),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const Divider(height: 20),

          // Subtotal + Beli
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Subtotal',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          _formatHarga(_subtotal),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: yamahaBlue,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down,
                            color: yamahaBlue, size: 18),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate ke checkout
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yamahaBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Beli',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined,
              size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'Keranjang masih kosong',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Yuk tambahkan motor favoritmu!',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: yamahaBlue,
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text('Lihat Katalog'),
          ),
        ],
      ),
    );
  }
}