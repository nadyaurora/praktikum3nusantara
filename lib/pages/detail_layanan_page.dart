import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pengajuan_model.dart';

class DetailLayananPage extends StatefulWidget {
  const DetailLayananPage({
    super.key,
    required this.namaLayanan,
  });

  final String namaLayanan;

  @override
  State<DetailLayananPage> createState() =>
      _DetailLayananPageState();
}

class _DetailLayananPageState
    extends State<DetailLayananPage> {
  bool _sedangMengirim = false;

  Future<void> _ajukanPermohonan() async {
    setState(() {
      _sedangMengirim = true;
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    context
        .read<PengajuanModel>()
        .tambahPengajuan(widget.namaLayanan);

    setState(() {
      _sedangMengirim = false;
    });

    Navigator.pop(
      context,
      widget.namaLayanan,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.namaLayanan),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.namaLayanan,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall,
            ),
            const SizedBox(height: 16),
            const Text(
              'Halaman rincian layanan warga.',
            ),
            const Spacer(),
            FilledButton(
              onPressed: _sedangMengirim
                  ? null
                  : _ajukanPermohonan,
              child: _sedangMengirim
                  ? const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text('Mengirim...'),
                      ],
                    )
                  : const Text(
                      'Ajukan Permohonan',
                    ),
            ),
          ],
        ),
      ),
    );
  }
}