import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_model.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritModel>(
      builder: (context, favorit, child) {
        final daftarFavorit = favorit.favorit.toList();

        if (daftarFavorit.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada layanan favorit',
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Layanan Favorit',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...daftarFavorit.map(
              (nama) => ListTile(
                leading: const Icon(Icons.star),
                title: Text(nama),
              ),
            ),
          ],
        );
      },
    );
  }
}