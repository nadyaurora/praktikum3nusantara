import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_model.dart';
import '../navigation/app_routes.dart';

class LayananPage extends StatelessWidget {
  const LayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    final layanan = {
      'Perizinan': [
        'Izin Usaha',
        'Izin Mendirikan Bangunan',
      ],
      'Kesehatan': [
        'Pendaftaran Puskesmas',
        'Layanan Ambulans',
      ],
      'Transportasi': [
        'Kartu Transportasi',
        'Pengaduan Transportasi',
      ],
    };

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Perizinan'),
              Tab(text: 'Kesehatan'),
              Tab(text: 'Transportasi'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: layanan.values.map((daftarLayanan) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: daftarLayanan.length,
                  itemBuilder: (context, index) {
                    final nama = daftarLayanan[index];

                    return ListTile(
                      title: Text(nama),
                      subtitle: const Text(
                        'Lihat rincian layanan',
                      ),
                      trailing: Consumer<FavoritModel>(
                        builder: (context, favorit, child) {
                          final isFavorit =
                              favorit.isFavorit(nama);

                          return IconButton(
                            onPressed: () {
                              if (isFavorit) {
                                context
                                    .read<FavoritModel>()
                                    .batalTandai(nama);
                              } else {
                                context
                                    .read<FavoritModel>()
                                    .tandai(nama);
                              }
                            },
                            icon: Icon(
                              isFavorit
                                  ? Icons.star
                                  : Icons.star_border,
                            ),
                          );
                        },
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.detailLayanan,
                          arguments: nama,
                        );
                      },
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}