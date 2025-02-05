import 'package:flutter/material.dart';

///Cores utilizadas na homeView
class ColorsHome {
  ///Cores
  static final Map<int, Color> colorMap = {
    0: Colors.brown[600]!,
    1: Colors.red[900]!,
    2: Colors.redAccent[700]!,
    3: Colors.deepOrange,
    4: Colors.orange,
    5: Colors.amber,
    6: Colors.yellowAccent,
    7: Colors.green[300]!,
    8: Colors.green[400]!,
    9: Colors.green,
    10: Colors.green[700]!,
    11: Colors.white,
    12: Colors.lightBlue[900]!,
    13: Color(0xFF023047),
    14: Colors.grey,
    15: Color(0xFFFFB703),
    16: Color(0xFF5C8001),
    17: Colors.black,
  };

  ///Cores das barras
  final Map<int, Color> colorBar = {
    0: colorMap[15]!,
    1: colorMap[16]!,
    2: colorMap[13]!,
    3: Colors.red[900]!,
    4: Colors.amber,
  };
}
