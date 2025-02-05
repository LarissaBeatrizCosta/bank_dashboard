import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/bar_model.dart';
import '../models/cooperative_model.dart';
import '../models/rates_model.dart';
import '../models/user_model.dart';
import '../views/utils/colors.dart';

///Classe que cuida do banco de dados
class DataBaseController {
  ///Instancia do banco
  FirebaseFirestore db = FirebaseFirestore.instance;

  ///Gerente
  late UserModel user;

  ///Tipo do gerente
  late final positionUser = user.position;

  ///Lista de cooperativas
  final cooperativesList = <CooperativeModel>[];

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
  }

  ///Busca o gerente vinculado com este id no banco
  Future<void> getUserPosition(String id) async {
    final userId = await db.collection('user').doc(id).get();

    if (userId.exists && userId.data() != null) {
      user = UserModel.fromMap(userId.data() as Map<String, dynamic>);
    }
  }

  ///Calcula  média
  Future<List<BarModel>> calculateAverage(
    List<RatesModel> ratesList,
  ) async {
    var listLocationValue = <double>[];
    var listCollaboratorValue = <double>[];
    var listTimeValue = <double>[];
    var mainList = <BarModel>[];

    for (final item in ratesList) {
      listLocationValue.add(item.locationValue);
      listCollaboratorValue.add(item.collaboratorValue);
      listTimeValue.add(item.timeValue);
    }

    final locationAvarege = calculateMedia(listLocationValue);
    final collaboratorValueAvarege = calculateMedia(listCollaboratorValue);
    final timeValueAvarege = calculateMedia(listTimeValue);

    mainList.addAll(
      [
        BarModel(
          type: RateType.locationValue,
          value: locationAvarege,
        ),
        BarModel(
          type: RateType.collaboratorValue,
          value: collaboratorValueAvarege,
        ),
        BarModel(
          type: RateType.timeValue,
          value: timeValueAvarege,
        ),
      ],
    );

    return mainList;
  }

  ///Calcula media
  double calculateMedia(List<double> rates) {
    if (rates.isEmpty) {
      return 0.0;
    }
    return rates.reduce((a, b) => a + b) / rates.length;
  }

  ///Retorna os campos de cada cooperativa
  Future<List<CooperativeModel>> getCooperatives() async {
    final cooperativesCollection = await db.collection('cooperatives').get();

    final list = cooperativesCollection.docs;

    for (final (index, item) in list.indexed) {
      switch (user.position) {
        case 1:
          await _getMainManagerCompanies(
            index,
            item,
          );
      }
    }

    return cooperativesList;
  }

  Future<void> _getMainManagerCompanies(
    int index,
    QueryDocumentSnapshot<Map<String, dynamic>> item,
  ) async {
    final cooperative = item;

    final ratesCollection = await cooperative.reference
        .collection(
          'rates',
        )
        .get();

    final ratesList = <RatesModel>[];

    for (final rate in ratesCollection.docs) {
      final rateModel = RatesModel.fromMap(rate.data());
      ratesList.add(rateModel);
    }

    final rates = await calculateAverage(ratesList);

    final company = CooperativeModel(
      name: item['name'],
      idCity: item['idCity'],
      rates: rates,
      color: ColorsHome().colorBar[index] ?? Colors.grey,
    );


    cooperativesList.add(company);

  }
}
