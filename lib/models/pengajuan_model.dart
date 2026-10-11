import 'package:flutter/foundation.dart';

class PengajuanModel extends ChangeNotifier {
  final List<String> _pengajuan = [];

  List<String> get pengajuan => List.unmodifiable(_pengajuan);

  int get totalPengajuan => _pengajuan.length;

  void tambahPengajuan(String namaLayanan) {
    _pengajuan.add(namaLayanan);
    notifyListeners();
  }
}