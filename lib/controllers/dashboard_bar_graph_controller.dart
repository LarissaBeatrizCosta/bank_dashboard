
import 'package:flutter/cupertino.dart';

import '../models/cooperative_model.dart';
import 'db_controller.dart';

///Controller do grafico de barras
class DashboardState extends ChangeNotifier {
  ///Construtor
  DashboardState() {
    _init();
  }

  var _isLoading = true;
  final _companies = <CooperativeModel>[];

  ///Lista de filiais
  List<CooperativeModel> get companies => _companies;



  // PRECISA DOCUMENTAR
  bool get isLoading => _isLoading;

  ///Inicialização do banco
  DataBaseController dbController = DataBaseController();

  Future<void> _init() async {
    await dbController.getUser();

    final list = await dbController.getCooperatives();

    _companies.addAll(list);

    _isLoading = false;
    notifyListeners();
  }
}
