import 'dart:ui';

import 'dashboard_rates.dart';

class Company {
  Company({
    this.name,
    required this.rates,
    required this.color,
  });

  final String? name;
  final List<DashboardRate> rates;
  final Color color;
}
