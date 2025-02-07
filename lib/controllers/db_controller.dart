import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/bar_model.dart';
import '../models/city_per_user.dart';
import '../models/cooperative_model.dart';
import '../models/rates_model.dart';
import '../models/user_model.dart';

///Classe que cuida do banco de dados
class DataBaseController {
  ///Instancia do banco
  FirebaseFirestore db = FirebaseFirestore.instance;

  ///Inicializa o user
  bool initialized = false;

  ///Gerente
  late final UserModel _user;

  ///Nome do gerente
  String get nameUser => _user.name;

  ///Filial do gerente
  String get companyUser => _user.idCompany;

  ///Tipo do gerente
  late final positionUser = _user.position;

  ///Lista de cooperativas
  final cooperativesList = <CooperativeModel>[];

  ///Pega id do login
  Future<String?> getUid() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return null;
    }

    return user.uid;
  }

  ///Retorna o gerente ligado a este id
  Future<void> getUser() async {
    final userUid = await getUid();

    if (userUid == null) {
      return;
    }

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
      _user = UserModel.fromMap(userId.data() as Map<String, dynamic>);
      initialized = true;
    }
  }

  /// Recupera as notas
  Future<List<RatesModel>> ratesList(String id) async {
    final cooperativeId = await db.collection('cooperatives').doc(id).get();

    if (!cooperativeId.exists) {
      return [];
    }

    final ratesCollection =
        await cooperativeId.reference.collection('rates').get();

    final ratesList = <RatesModel>[];

    for (final rate in ratesCollection.docs) {
      final rateModel = RatesModel.fromMap(rate.data());
      ratesList.add(rateModel);
    }

    return ratesList;
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

  Future<void> _getSecondManagerCompaniesFilter({
    required QuerySnapshot<Map<String, dynamic>> item,
    DateTime? initial,
    DateTime? last,
    String? id,
  }) async {
    final cityPerUserCollection = await db.collection('city_per_user').get();
    final cityUserList = <CityUserModel>[];

    for (final cityDoc in cityPerUserCollection.docs) {
      final cityUserModel = CityUserModel.fromMap(cityDoc.data());
      cityUserList.add(cityUserModel);
    }
    final userId = await getUid();
    final list = <CooperativeModel>[];

    for (final it in item.docs) {
      for (final cityUser in cityUserList) {
        if (cityUser.idUser == userId) {
          if (it['idCity'] == cityUser.idCity) {
            final ratesCollection = await it.reference
                .collection('rates')
                .where('time', isGreaterThanOrEqualTo: initial)
                .where('time', isLessThanOrEqualTo: last)
                .get();
            final ratesList = <RatesModel>[];

            for (final rate in ratesCollection.docs) {
              final rateModel = RatesModel.fromMap(rate.data());
              ratesList.add(rateModel);
            }

            final rates = await calculateAverage(ratesList);

            final company = CooperativeModel(
              idCooperative: it.id,
              name: it['name'],
              idCity: it['idCity'],
              rates: rates,
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
            );

            list.add(company);
          }
        }
      }
    }

    cooperativesList.clear();
    cooperativesList.addAll(list);
  }

  Future<void> _getThirdManagerCompaniesFilter(
    DocumentSnapshot<Map<String, dynamic>> cooperativeId,
    DateTime? initial,
    DateTime? last,
  ) async {
    final ratesCollection = await cooperativeId.reference
        .collection('rates')
        .where('time', isGreaterThanOrEqualTo: initial)
        .where('time', isLessThanOrEqualTo: last)
        .get();

    final ratesList = <RatesModel>[];

    for (final rate in ratesCollection.docs) {
      final rateModel = RatesModel.fromMap(rate.data());
      ratesList.add(rateModel);
    }

    final rates = await calculateAverage(ratesList);

    final company = CooperativeModel(
      idCooperative: cooperativeId.id,
      name: cooperativeId['name'],
      idCity: cooperativeId['idCity'],
      rates: rates,
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    );

    cooperativesList.add(company);
  }

  ///Função que pega especificamente uma cooperativa
  Future<List<CooperativeModel>> getByIdCooperative(String id) async {
    final cooperativeId = await db.collection('cooperatives').doc(id).get();
    final ratesCollection =
        await cooperativeId.reference.collection('rates').get();
    final ratesList = <RatesModel>[];

    for (final rate in ratesCollection.docs) {
      final rateModel = RatesModel.fromMap(rate.data());
      ratesList.add(rateModel);
    }
    final rates = await calculateAverage(ratesList);

    final company = CooperativeModel(
      idCooperative: cooperativeId.id,
      name: cooperativeId['name'],
      idCity: cooperativeId['idCity'],
      rates: rates,
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    );

    return [company];
  }

  Future<void> _getFilter({
    required QuerySnapshot<Map<String, dynamic>> item,
    DateTime? initial,
    DateTime? last,
    String? id,
  }) async {
    for (final item in item.docs) {
      await _processCooperative(
        item,
        initial,
        last,
      );
    }
  }

  ///Pega as cooperativas por data
  Future<List<CooperativeModel>> getCooperativesByDate({
    DateTime? initial,
    DateTime? last,
    String? id,
  }) async {
    cooperativesList.clear();

    if (id == null || id.isEmpty) {
      final cooperativesCollection = await db.collection('cooperatives').get();

      await _get(
        cooperativesCollection,
        initial,
        last,
        id,
      );
    } else {
      final cooperativeId = await db.collection('cooperatives').doc(id).get();

      await _getThirdManagerCompaniesFilter(
        cooperativeId,
        initial,
        last,
      );
    }

    return cooperativesList;
  }

  Future<void> _get(
    QuerySnapshot<Map<String, dynamic>> item,
    DateTime? initial,
    DateTime? last,
    String? id,
  ) async {
    switch (_user.position) {
      case 1:
        await _getFilter(
          last: last,
          item: item,
          initial: initial,
          id: id,
        );
        break;
      case 2:
        await _getSecondManagerCompaniesFilter(
          last: last,
          item: item,
          initial: initial,
          id: id,
        );
        break;
      case 3:
        final idCompany = companyUser;

        final cooperativeId =
            await db.collection('cooperatives').doc(idCompany).get();

        await _getThirdManagerCompaniesFilter(
          cooperativeId,
          initial,
          last,
        );
        break;
    }
  }

  Future<void> _processCooperative(
    DocumentSnapshot<Map<String, dynamic>> item,
    DateTime? initial,
    DateTime? last,
  ) async {
    final dbCooperatives = item.reference.collection('rates');

    final ratesCollection = initial == null || last == null
        ? await dbCooperatives.get()
        : await dbCooperatives
            .where('time', isGreaterThanOrEqualTo: initial)
            .where('time', isLessThanOrEqualTo: last)
            .get();

    if (ratesCollection.docs.isNotEmpty) {
      final ratesList = ratesCollection.docs
          .map((rate) => RatesModel.fromMap(rate.data()))
          .toList();

      final rates = await calculateAverage(ratesList);

      cooperativesList.add(
        CooperativeModel(
          idCooperative: item.id,
          name: item['name'],
          idCity: item['idCity'],
          rates: rates,
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        ),
      );
    }
  }
}
