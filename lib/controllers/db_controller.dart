import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dashboard_rates.dart';
import '../views/utils/constants.dart';

///Classe que cuida do banco de dados
class DataBaseController extends ChangeNotifier {
  ///Instancia do banco
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Future<void> gui() async {
  //   final request =
  //       requestGetCompanis; // requisição para pegar todas as empresas
  //
  //   final companies = <Company>[]; // Lista de companies que podem ser mostradas
  //   final city = <int>[]; // Lista de companies que podem ser mostradas
  //
  //   for (final item in request) {
  //     city.add(item['idCity']);
  //   }
  //
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString(Constants.userKey);
  //
  //   final users = getAllUsers(); // Requisçãop
  //
  //   final user = users[token];
  //   final position = user['position'] as int;
  //
  //   if (position == 2) {}
  //
  //   final list = <DashboardRate>[];
  //
  //     list.add(
  //       DashboardRate(
  //         value: 5,
  //         type: RateType.waitingTime,
  //       ),
  //     );
  // }
}
