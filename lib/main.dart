import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/favorit_model.dart';
import 'models/pengajuan_model.dart';
import 'navigation/app_routes.dart';
import 'pages/beranda_page.dart';
import 'pages/detail_layanan_page.dart';
import 'pages/layanan_page.dart';
import 'pages/warga_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FavoritModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => PengajuanModel(),
        ),
      ],
      child: const NusantaraCerdasApp(),
    ),
  );
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nusantara Cerdas Mobile',
      initialRoute: AppRoutes.beranda,
      routes: {
        AppRoutes.beranda: (_) =>
            const KerangkaUtama(),
        AppRoutes.detailLayanan: (context) {
          final namaLayanan =
              ModalRoute.of(context)!.settings.arguments
                  as String;

          return DetailLayananPage(
            namaLayanan: namaLayanan,
          );
        },
      },
    );
  }
}

class KerangkaUtama extends StatefulWidget {
  const KerangkaUtama({super.key});

  @override
  State<KerangkaUtama> createState() =>
      _KerangkaUtamaState();
}

class _KerangkaUtamaState
    extends State<KerangkaUtama> {
  int _indeks = 0;

  final List<Widget> _halaman = const [
    BerandaPage(),
    LayananPage(),
    WargaPage(),
  ];

  final List<String> _judul = const [
    'Beranda',
    'Layanan',
    'Warga',
  ];

  void _ubahHalaman(int indeks) {
    setState(() {
      _indeks = indeks;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final layarLebar =
            constraints.maxWidth >= 600;

        return Scaffold(
          appBar: AppBar(
            title: Text(_judul[_indeks]),
          ),

          drawer: layarLebar
              ? null
              : NavigationDrawer(
                  selectedIndex: _indeks,
                  onDestinationSelected:
                      _ubahHalaman,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Nusantara Cerdas',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                    NavigationDrawerDestination(
                      icon: Icon(
                        Icons.home_outlined,
                      ),
                      selectedIcon: Icon(
                        Icons.home,
                      ),
                      label: Text('Beranda'),
                    ),
                    NavigationDrawerDestination(
                      icon: Icon(
                        Icons.miscellaneous_services_outlined,
                      ),
                      selectedIcon: Icon(
                        Icons.miscellaneous_services,
                      ),
                      label: Text('Layanan'),
                    ),
                    NavigationDrawerDestination(
                      icon: Icon(
                        Icons.person_outline,
                      ),
                      selectedIcon: Icon(
                        Icons.person,
                      ),
                      label: Text('Warga'),
                    ),
                  ],
                ),

          body: Row(
            children: [
              if (layarLebar)
                NavigationRail(
                  selectedIndex: _indeks,
                  onDestinationSelected:
                      _ubahHalaman,
                  labelType:
                      NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.home_outlined,
                      ),
                      selectedIcon: Icon(
                        Icons.home,
                      ),
                      label: Text('Beranda'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.miscellaneous_services_outlined,
                      ),
                      selectedIcon: Icon(
                        Icons.miscellaneous_services,
                      ),
                      label: Text('Layanan'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.person_outline,
                      ),
                      selectedIcon: Icon(
                        Icons.person,
                      ),
                      label: Text('Warga'),
                    ),
                  ],
                ),

              Expanded(
                child: IndexedStack(
                  index: _indeks,
                  children: _halaman,
                ),
              ),
            ],
          ),

          bottomNavigationBar: layarLebar
              ? null
              : NavigationBar(
                  selectedIndex: _indeks,
                  onDestinationSelected:
                      (nilai) {
                    setState(() {
                      _indeks = nilai;
                    });
                  },
                  destinations: [
                    const NavigationDestination(
                      icon: Icon(
                        Icons.home_outlined,
                      ),
                      selectedIcon: Icon(
                        Icons.home,
                      ),
                      label: 'Beranda',
                    ),
                    const NavigationDestination(
                      icon: Icon(
                        Icons.miscellaneous_services_outlined,
                      ),
                      selectedIcon: Icon(
                        Icons.miscellaneous_services,
                      ),
                      label: 'Layanan',
                    ),
                    NavigationDestination(
                      icon: _BadgeWarga(
                        child: const Icon(
                          Icons.person_outline,
                        ),
                      ),
                      selectedIcon: _BadgeWarga(
                        child: const Icon(
                          Icons.person,
                        ),
                      ),
                      label: 'Warga',
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _BadgeWarga extends StatelessWidget {
  const _BadgeWarga({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final total = context.select<PengajuanModel, int>(
      (model) => model.totalPengajuan,
    );

    if (total == 0) {
      return child;
    }

    return Badge(
      label: Text('$total'),
      child: child,
    );
  }
}