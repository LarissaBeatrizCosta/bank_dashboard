///Classe responsavel pelas notas
class DashboardRate {
  ///Construtor
  DashboardRate({
    required this.value,
    required this.type,
  });

  ///Valor do grafico
  final double value;
  ///Tipo da avaliação
  final RateType type;
}

///Tipos de avaliaçoes
enum RateType {
  ///Ambiente
  environment,
  ///Colaboradores
  employees,
  ///Tempo de espera
  waitingTime;

  /// get for translate type module
  String get transLate {
    /// switch expression
    return switch (this) {
      environment => 'Ambiente',
      employees => 'Colaboradores',
      waitingTime => 'Tempo de espera',
    };
  }
}
