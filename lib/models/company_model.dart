import 'dart:ui';

import 'dashboard_rates.dart';

///Classe das filiais
class Company {
  ///Construtor
  Company({
    this.name,
    required this.rates,
    required this.color,
  });

  ///nome da filial
  final String? name;
  ///Notas da filial
  final List<DashboardRate> rates;
  ///Cor da barra do gráfico
  final Color color;
}
