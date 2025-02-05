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
  final _mainsCompanies = <CooperativeModel>[];

  ///Lista de filiais
  List<CooperativeModel> get companies => _companies;

  /// List all companies
  List<CooperativeModel> get mainsCompanies => _mainsCompanies;

  /// Carregamento da página
  bool get isLoading => _isLoading;

  ///Inicialização do banco
  DataBaseController dbController = DataBaseController();

  CooperativeModel? _selectedCompany;

  CooperativeModel? get selectedCompany => _selectedCompany;

  Future<void> _init() async {
    await dbController.getUser();
    await getAllCompanies();
    _mainsCompanies.addAll(_companies);

    _isLoading = false;
    notifyListeners();
  }

  /// Get all companies
  Future<void> getAllCompanies() async {
    final list = await dbController.getCooperatives();

    _companies.clear();
    _companies.addAll(list);

    notifyListeners();
  }

  ///Chama no banco para pegar cooperativa
  Future<void> getCooperativeId(String? id) async {
    if ((_selectedCompany?.idCooperative ?? '') == (id ?? '')) {
      return;
    }

    _companies.clear();
    if (id == null || (id).isEmpty) {
      _selectedCompany = null;
      await getAllCompanies();
      return;
    }
    final list = await dbController.getByIdCooperative(id);

    _companies.addAll(list);

    if (list.isNotEmpty) {
      _selectedCompany = list.first;
    }

    notifyListeners();
  }
}
