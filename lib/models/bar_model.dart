///Classe responsavel pelas notas
class BarModel {
  ///Construtor
  BarModel({
    required this.value,
    required this.type,
  });

  ///Valor do grafico
  final double value;

  ///Tipo da avaliação
  final RateType type;

  ///Map em model
  factory BarModel.fromMap(Map<String, dynamic> map) {
    return BarModel(
      value: map['value'],
      type: getType(map['type']),
    );
  }

  ///Converte a string recebida em enum
  static RateType getType(String type) {
    switch (type) {
      case 'locationValue':
        return RateType.locationValue;
      case 'collaboratorValue':
        return RateType.collaboratorValue;
      case 'timeValue':
        return RateType.timeValue;
      default:
        return RateType.locationValue;
    }
  }
}

///Tipos de avaliaçoes
enum RateType {
  ///Ambiente
  locationValue,

  ///Colaboradores
  collaboratorValue,

  ///Tempo de espera
  timeValue;

  /// get for translate type module
  String get transLate {
    /// switch expression
    return switch (this) {
      locationValue => 'Ambiente',
      collaboratorValue => 'Colaboradores',
      timeValue => 'Tempo de espera',
    };
  }
}
