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

  ///Lista de avaliações
  var ratesList = <RatesModel>[];

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
      await getCooperatives();
    }
  }

  ///Calcula  média
  Future<void> calculateAverage() async {
    var listLocationValue = <int>[];
    var listCollaboratorValue = <int>[];
    var listTimeValue = <int>[];

    for (final item in ratesList) {
      listLocationValue.add(item.locationValue);
      listCollaboratorValue.add(item.collaboratorValue);
      listTimeValue.add(item.timeValue);
    }
    double locationAvarege = calculateMedia(listLocationValue);
    double collaboratorAvarege = calculateMedia(listCollaboratorValue);
    double timeAvarege = calculateMedia(listTimeValue);

    print(' LOCALIZAÇÃO: $locationAvarege');
    // print(collaboratorAvarege);
    // print(timeAvarege);
  }

  ///Calcula media
  double calculateMedia(List<int> rates) {
    if (rates.isEmpty) {
      return 0.0;
    }
    return rates.reduce((a, b) => a + b) / rates.length;
  }

  ///Retorna os campos de cada cooperativa
  Future<void> getCooperatives() async {
    final cooperativesCollection = await db.collection('cooperatives').get();
    for (final cooperative in cooperativesCollection.docs) {
      final ratesCollection =
          await cooperative.reference.collection('rates').get();
      ratesList.clear();
      for (final rate in ratesCollection.docs) {
        final rateModel = RatesModel.fromMap(rate.data());
        ratesList.add(rateModel);
      }
      // cooperativesList.add(CooperativeModel(
      //   idCity: cooperative.data()['idCity'],
      //   rates: ratesList, //Função de média
      //   color: ColorsHome().colorBar['color'] ?? Colors.grey,
      // ));
      await calculateAverage();
    }
  }
}
