import 'package:flutter/material.dart';
import 'bar_model.dart';

///Classe das filiais
class CooperativeModel {
  ///Construtor
  CooperativeModel({
    required this.idCooperative,
    required this.idCity,
    required this.rates,
    required this.color,
    required this.name,
  });

  ///Id da cooperativa
  final String idCooperative;

  ///nome da filial
  final int idCity;

  ///Nome da filial
  final String name;

  ///Notas da filial
  final List<BarModel> rates;

  ///Cor da barra do gráfico
  final Color color;

  ///Map em model
  factory CooperativeModel.fromMap(Map<String, dynamic> map) {
    return CooperativeModel(
      idCooperative: map['idCooperative'],
      name: map['name'],
      idCity: map['idCity'],
      rates: map['rates'],
      color: map['color'],
    );
  }

  /// Model em map
  Map<String, dynamic> toMap() {
    return {
      'id': idCooperative,
      'name': name,
      'idCity': idCity,
      'rates': rates,
      'color': color,
    };
  }
}
