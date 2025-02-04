import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../models/company_model.dart';
import '../models/dashboard_rates.dart';
import '../views/utils/colors.dart';
import 'db_controller.dart';

///Controller do grafico de barras
class DashboardState extends ChangeNotifier {
  ///Construtor
  DashboardState() {
    _init();
  }

//TESTANDO BANCO
  DataBaseController dbController = DataBaseController();

  final _companies = <Company>[];

  ///Lista de filiais
  List<Company> get companies => _companies;

  void _init() async {
    await dbController.getUser(); //TESTANDO BANCO
    final list = <DashboardRate>[];
    final list2 = <DashboardRate>[];
    final list3 = <DashboardRate>[];

    final color1 = ColorsHome().colorMap[15]!;
    final color2 = ColorsHome().colorMap[16]!;
    final color3 = ColorsHome().colorMap[13]!;

    for (var i = 0; i < 3; i++) {
      final random = Random();
      final randomNumber = random.nextInt(5);
      final type = random.nextInt(3);

      list.add(
        DashboardRate(
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
        DashboardRate(
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
        DashboardRate(
          value: randomNumber.toDouble(),
          type: RateType.values[type],
        ),
      );
    }

    _companies.addAll(
      [
        Company(
          name: 'Brusque',
          rates: list,
          color: color1,
        ),
        Company(
          name: 'Gaspar',
          rates: list2,
          color: color2,
        ),
        Company(
          name: 'Blumenau',
          rates: list3,
          color: color3,
        ),
      ],
    );

    notifyListeners();
  }
}
