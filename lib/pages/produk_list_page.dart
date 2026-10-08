import 'package:flutter/material.dart';
import '../models/produk.dart';
import '../../widget_basic/product_card.dart';
import 'produk_detail_page.dart';

class ProdukListPage extends StatelessWidget {
  final List<Produk> produk;
  final VoidCallback onTambahKeranjang;
  final void Function(int index) onHapus;

  const ProdukListPage({
    super.key,
    required this.produk,
    required this.onTambahKeranjang,
    required this.onHapus,
  });

  Future<void> _konfirmasiHapus(BuildContext context, int index) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Produk?'),
        content: Text('${produk[index].nama} akan dihapus dari daftar.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (yakin == true) {
      onHapus(index);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produk telah dihapus')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (produk.isEmpty) {
      return const Center(child: Text('Belum ada produk'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: produk.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = produk[index];
        return ProductCard(
          nama: item.nama,
          harga: item.harga,
          onTap: () async {
            final hasil = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProdukDetailPage(
                  namaProduk: item.nama,
                  harga: item.harga,
                ),
              ),
            );

            if (hasil == true) {
              onTambahKeranjang();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item.nama} masuk keranjang')),
                );
              }
            }
          },
          onHapus: () => _konfirmasiHapus(context, index),
        );
      },
    );
  }
}