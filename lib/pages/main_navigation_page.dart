import 'package:flutter/material.dart';
import '../models/produk.dart';
import 'produk_list_page.dart';
import 'profil_page.dart';
import 'tambah_produk_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _tabTerpilih = 0;
  int _jumlahKeranjang = 0;

  final List<Produk> _produk = [
    Produk(nama: 'Kursi Minimalis', harga: 350000),
    Produk(nama: 'Meja Kerja Kayu', harga: 750000),
    Produk(nama: 'Lampu Meja LED', harga: 120000),
    Produk(nama: 'Rak Buku', harga: 450000),
    Produk(nama: 'Sofa Kecil', harga: 1500000),
  ];

  Future<void> _bukaFormTambah() async {
    final baru = await Navigator.push<Produk>(
      context,
      MaterialPageRoute(builder: (_) => const TambahProdukPage()),
    );

    if (baru != null) {
      setState(() {
        _produk.add(baru);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produk berhasil ditambahkan')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final halaman = [
      ProdukListPage(
        produk: _produk,
        onTambahKeranjang: () {
          setState(() {
            _jumlahKeranjang++;
          });
        },
        onHapus: (index) {
          setState(() {
            _produk.removeAt(index);
          });
        },
      ),
      const ProfilPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_tabTerpilih == 0 ? 'Katalog Produk' : 'Profil'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Isi keranjang: $_jumlahKeranjang item'),
                    ),
                  );
                },
              ),
              if (_jumlahKeranjang > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$_jumlahKeranjang',
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: halaman[_tabTerpilih],
      floatingActionButton: _tabTerpilih == 0
          ? FloatingActionButton(
              onPressed: _bukaFormTambah,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabTerpilih,
        onTap: (index) {
          setState(() {
            _tabTerpilih = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}