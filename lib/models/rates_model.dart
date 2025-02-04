///Classe das avaliações
class RatesModel {
  ///Nota sobre colaboradores
  int collaboratorValue;

  ///Comentário
  String commentValue;

  ///CPF
  String cpfValue;

  ///Nota sobre ambiente
  int locationValue;

  ///Nota de indicação
  int numberRate;

  ///Data
  String time;

  ///Nota sobre tempo de espera
  int timeValue;

  ///Construtor
  RatesModel({
    required this.collaboratorValue,
    required this.commentValue,
    required this.cpfValue,
    required this.locationValue,
    required this.numberRate,
    required this.timeValue,
    required this.time,
  });

  ///Map em model
  factory RatesModel.fromMap(Map<String, dynamic> map) {
    return RatesModel(
      collaboratorValue: map['collaboratorValue'],
      commentValue: map['commentValue'],
      cpfValue: map['cpfValue'],
      locationValue: map['locationValue'],
      numberRate: map['numberRate'],
      timeValue: map['timeValue'],
      time: map['time'],
    );
  }

  /// Model em map
  Map<String, dynamic> toMap() {
    return {
      'collaboratorValue': collaboratorValue,
      'commentValue': commentValue,
      'cpfValue': cpfValue,
      'locationValue': locationValue,
      'numberRate': numberRate,
      'timeValue': timeValue,
      'time': time,
    };
  }
}
