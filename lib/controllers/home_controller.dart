import 'package:flutter/cupertino.dart';

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
  late final String name;

  Future<void> _init() async {
    await dbController.getUser();
    name = dbController.nameUser;
    notifyListeners();
  }
}
