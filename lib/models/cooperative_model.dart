import 'package:flutter/material.dart';
import 'rates_model.dart';

///Classe das filiais
class CooperativeModel {
  ///Construtor
  CooperativeModel({
    required this.idCity,
    required this.rates,
    required this.color,
  });

  ///nome da filial
  final int idCity;

  ///Notas da filial
  final List<RatesModel> rates;

  ///Cor da barra do gráfico
  final Color color;

  ///Map em model
  factory CooperativeModel.fromMap(Map<String, dynamic> map) {
    return CooperativeModel(
      idCity: map['idCity'],
      rates: map['rates'],
      color: map['color'],
    );
  }

  /// Model em map
  Map<String, dynamic> toMap() {
    return {
      'idCity': idCity,
      'rates': rates,
      'color': color,
    };
  }


}


