import 'package:cloud_firestore/cloud_firestore.dart';

///Classe das avaliações
class RatesModel {
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

  ///Nota sobre colaboradores
  final double collaboratorValue;

  ///Comentário
  final String commentValue;

  ///CPF
  final String cpfValue;

  ///Nota sobre ambiente
  final double locationValue;

  ///Nota de indicação
  final double numberRate;

  ///Data
  final Timestamp time;

  ///Nota sobre tempo de espera
  final double timeValue;

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
