import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../models/cooperative_model.dart';
import '../views/utils/constants.dart';
import '../views/utils/constants.dart';
import 'db_controller.dart';

///Controller do grafico de barras
class DashboardState extends ChangeNotifier {
  ///Construtor
  DashboardState({
    required DataBaseController dbController,
  }) : _dbController = dbController {
    _init();
  }

  var _isLoading = true;
  final _companies = <CooperativeModel>[];
  final _mainsCompanies = <CooperativeModel>[];

  ///Data inicial do calendario
  DateTime? initial;

  ///Data final do calendario
  DateTime? last;

  ///Lista de filiais
  List<CooperativeModel> get companies => _companies;

  /// List all companies
  List<CooperativeModel> get mainsCompanies => _mainsCompanies;

  /// Carregamento da página
  bool get isLoading => _isLoading;

  ///Data selecionada
  String? get initialDate =>
      tryFormatDate(
        'dd/MM/yyyy',
        initial,
      );

  ///Data selecionada
  String? get lastDate =>
      tryFormatDate(
        'dd/MM/yyyy',
        last,
      );

  ///Inicialização do banco
  final DataBaseController _dbController;

  CooperativeModel? _selectedCompany;

  ///Cooperativas selecionadas
  CooperativeModel? get selectedCompany => _selectedCompany;

  Future<void> _init() async {
    await getCooperativeFilter();
    _mainsCompanies.addAll(_companies);

    _isLoading = false;
    notifyListeners();
  }

  /// Get all companies
  Future<void> getAllCompanies() async {
    final list = await _dbController.getCooperatives();

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
    final list = await _dbController.getByIdCooperative(id);

    _companies.addAll(list);

    if (list.isNotEmpty) {
      _selectedCompany = list.first;
    }

    notifyListeners();
  }

  // DOCUMENTAR
  Future<void> getStartDate(DateTime? date) async {
    if (initial == date) {
      return;
    }

    initial = date;
    getCooperativeFilter();
  }

  // DOCUMENTAR
  Future<void> getEndDate(DateTime? date) async {
    if (initial == date) {
      return;
    }

    final addDate = date?.add(
      Duration(
        days: 1,
      ),
    );

    last = addDate?.subtract(
      Duration(
        microseconds: 1,
      ),
    );

    getCooperativeFilter();
  }

  ///Pega a função do banco de pegar as cooperativas por data
  Future<void> getCooperativeFilter({
    String? id,
  }) async {

    if(id != null){
    if (_selectedCompany?.idCooperative == id) {
      return;
    }
    }

    _companies.clear();

    var list = <CooperativeModel>[];
    list = await _dbController.getCooperativesByDate(
      initial,
      last,
      id,
    );
    _companies.addAll(list);

    if ((id ?? '').isNotEmpty) {
      _selectedCompany = list.first;
    }

    notifyListeners();
  }
}
