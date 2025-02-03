class DashboardRate {
  DashboardRate({
    required this.value,
    required this.type,
  });

  final double value;
  final RateType type;
}

enum RateType {
  environment,
  employees,
  waitingTime;

  /// get for translate type module
  String get transLate {
    final guigas = RateType.values[0];

    /// switch expression
    return switch (this) {
      environment => 'Ambiente',
      employees => 'Colaboradores',
      waitingTime => 'Tempo de espera',
    };
  }
}
