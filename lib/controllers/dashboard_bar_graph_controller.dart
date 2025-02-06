import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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

  ///Cooperativas selecionadas
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

  ///Data selecionada
  String initialDate = '';

  ///Data selecionada
  String lastDate = '';

  DateTime? inial;

  DateTime? last = DateTime(23, 59, 59);

  ///Recupera a data selecionada
  Future<void> getDate(int num, DateTime? date) async {
    var formattedDate = DateFormat('dd/MM/yyyy').format(
      date ?? DateTime.now(),
    );
    switch (num) {
      case 1:
        inial = date;
        initialDate = formattedDate;
      case 2:
        if (date != null) {
          last = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
        }
        lastDate = formattedDate;
      default:
        '';
    }

    notifyListeners();
  }

  ///Pega a função do banco de pegar as cooperativas por data
  Future<void> getCooperativeDate() async {
    if (inial != null && last != null) {
      var cooperatives = await dbController.getCooperativesByDate(
          inial as DateTime, last as DateTime);
    }

    notifyListeners();
  }
}
