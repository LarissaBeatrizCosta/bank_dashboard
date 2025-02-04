import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


///Classe que cuida do banco de dados
class DataBaseController extends ChangeNotifier {
  ///Instancia do banco
  FirebaseFirestore db = FirebaseFirestore.instance;

  ///Pega token do login
  Future<String> getUid() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return 'Token nulo';
    }
    return user.uid;

  }

  ///Retorna o gerente ligado a este token
  Future<void> getUser() async {
    final userUid = await getUid();
    final users = await db.collection('user').get();
    for (final item in users.docs) {
      if (item.id == userUid) {
        print('ACHOU ${item.id} = $userUid');
      }

    }
    notifyListeners();
  }

  ///Verifica tipo de gerente do token
  Future<void> getUserPosition(String token) async {}
}
