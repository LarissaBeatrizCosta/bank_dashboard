// import 'package:flutter/material.dart';
//
// import '../models/cooperative_model.dart';
// import 'db_controller.dart';
//
// ///Controller do filtro
// class FilterController extends ChangeNotifier {
//   ///Construtor
//   FilterController() {
//     _init();
//   }
//
//   ///Cooperativa selecionada do drop
//   String? cooperativeSelected;
//
//   ///Lista de cooperativas
//   late List<CooperativeModel> list;
//
//   var _isLoading = true;
//
//   /// Carregamento da página
//   bool get isLoading => _isLoading;
//
//   ///Banco controller
//   DataBaseController dbController = DataBaseController();
//
//   Future<void> _init() async {
//     await dbController.getUser();
//
//     list = await dbController.getCooperatives();
//     _isLoading = false;
//
//     notifyListeners();
//   }
//
//   ///Atualiza cooperativa selecionada
//   void updateCooperativeSelected(String newvalue) async {
//     cooperativeSelected = newvalue;
//     notifyListeners();
//   }
//
//
//   ///Chama no banco para pegar cooperativa
//   Future<void> getCooperativeId(String id) async {
//     await dbController.getByIdCooperative(id);
//
//     notifyListeners();
//   }
// }
