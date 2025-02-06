import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/utils/constants.dart';
import 'db_controller.dart';

///Controller da HomeView
class HomeController extends ChangeNotifier {
  ///Construtor
  HomeController() {
    _init();
  }

  ///Banco controller
  DataBaseController dbController = DataBaseController();

  ///Name user
  late final String _userName;

  ///Name user
  String get userName => _userName;
  var _isLoading = true;

  ///Carregamento
  bool get isLoading => _isLoading;

  Future<void> _init() async {
    await getUser();
    _isLoading = false;
    notifyListeners();
  }

  ///Pega o usuário
  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    await dbController.getUser();
    _userName = dbController.nameUser;

    prefs.setString(Constants.userName, _userName);
  }
}
