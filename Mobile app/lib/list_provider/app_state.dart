import 'dart:core';
import 'dart:core';

import 'package:flutter/foundation.dart';

class AppStateNTU extends ChangeNotifier{
  List<String> _dssp = [
    "Chuối" , "Lê", "Bom", "Lựu Đạn", "Me",
    "Xoài" , "Cóc", "Ổi", "Buỏi", "Cam", "Chanh",
    "Mít", "Sầu Riêng" , "Mãng Cụt",
  ];
  List<int> _gioHang = [];
  List<String> get dssp => _dssp;
  List<int> get gioHang => _gioHang;
  int get sLMH_GioHang => _gioHang.length;

  void them(int index){
    if(mhCotrongGioHang(index)==false) {
      _gioHang.add(index);
      notifyListeners();
    }
  }

  bool mhCotrongGioHang(int index){
    for(int i in _gioHang)
      if(i == index)
        return true;
      return false;
  }
  void xoaMH_trong_GH(int index){
      _gioHang.removeAt(index);
      notifyListeners();
  }
}

