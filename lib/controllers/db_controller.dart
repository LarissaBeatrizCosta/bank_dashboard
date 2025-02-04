import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/cooperative_model.dart';
import '../models/rates_model.dart';
import '../models/user_model.dart';
import '../views/utils/colors.dart';

///Classe que cuida do banco de dados
class DataBaseController extends ChangeNotifier {
  ///Instancia do banco
  FirebaseFirestore db = FirebaseFirestore.instance;

  ///Gerente
  late UserModel user;

  ///Tipo do gerente
  late final positionUser = user.position;

  ///Lista de cooperativas
  var cooperativesList = <CooperativeModel>[];

  ///Pega id do login
  Future<String> getUid() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return 'Usuário sem id válido';
    }
    return user.uid;
  }

  ///Retorna o gerente ligado a este id
  Future<void> getUser() async {
    final userUid = await getUid();
    final users = await db.collection('user').get();
    for (final item in users.docs) {
      if (item.id == userUid) {
        if (userUid.isNotEmpty) {
          await getUserPosition(userUid);
        }
      }
    }
    notifyListeners();
  }

  ///Busca o gerente vinculado com este id no banco
  Future<void> getUserPosition(String id) async {
    final userId = await db.collection('user').doc(id).get();

    if (userId.exists && userId.data() != null) {
      user = UserModel.fromMap(userId.data() as Map<String, dynamic>);
      getCooperatives();
    }
  }

  ///Busca a coleção de cooperativas do banco, para cada coleção busca as avaliações,
  ///atribui as avaliações em um model para finalizar criando um model para cada cooperativa e
  ///add na lista de cooperativas
  Future<void> getCooperatives() async {
    var ratesList = <RatesModel>[];
    final cooperatives = await db.collection('cooperatives').get();
    int idCity;

    for (final item in cooperatives.docs) {
      idCity = item.data()['idCity'];
      final rates = await item.reference.collection('rates').get();
      for (final item in rates.docs) {
        final rate = RatesModel.fromMap(item.data());
        ratesList.add(rate);
      }
      final filial = CooperativeModel(
          idCity: idCity, rates: ratesList, color: getColor(idCity));
      cooperativesList.add(filial);
    }
  }
}

//todo: tirar do db
///Cores das barras
Color getColor(int idCity) {
  return ColorsHome().colorBar[idCity] ?? Colors.green;
}
