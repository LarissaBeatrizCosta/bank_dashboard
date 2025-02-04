import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../models/bar_model.dart';
import '../models/cooperative_model.dart';
import '../views/utils/colors.dart';
import 'db_controller.dart';

///Controller do grafico de barras
class DashboardState extends ChangeNotifier {
  ///Construtor
  DashboardState() {
    _init();
  }

  final _companies = <CooperativeModel>[];

  ///Lista de filiais
  List<CooperativeModel> get companies => _companies;

  ///Inicialização do banco
  DataBaseController dbController = DataBaseController();

  void _init() {
    dbController.getUser();
    final list = <BarModel>[];
    final list2 = <BarModel>[];
    final list3 = <BarModel>[];

    final color1 = ColorsHome().colorMap[15]!;
    final color2 = ColorsHome().colorMap[16]!;
    final color3 = ColorsHome().colorMap[13]!;

    for (var i = 0; i < 3; i++) {
      final random = Random();
      final randomNumber = random.nextInt(5);
      final type = random.nextInt(3);

      list.add(
        BarModel(
          value: randomNumber.toDouble(),
          type: RateType.values[type],
        ),
      );
    }
    for (var i = 0; i < 3; i++) {
      final random = Random();
      final randomNumber = random.nextInt(5);
      final type = random.nextInt(3);

      list2.add(
        BarModel(
          value: randomNumber.toDouble(),
          type: RateType.values[type],
        ),
      );
    }

    for (var i = 0; i < 3; i++) {
      final random = Random();
      final randomNumber = random.nextInt(5);
      final type = random.nextInt(3);

      list3.add(
        BarModel(
          value: randomNumber.toDouble(),
          type: RateType.values[type],
        ),
      );
    }

    _companies.addAll(
      [
        CooperativeModel(
          idCity: 1,
          rates: list,
          color: color1,
        ),
        CooperativeModel(
          idCity: 2,
          rates: list2,
          color: color2,
        ),
        CooperativeModel(
          idCity: 3,
          rates: list3,
          color: color3,
        ),
      ],
    );

    notifyListeners();
  }
}
