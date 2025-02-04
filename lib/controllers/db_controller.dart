
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

///Classe que cuida do banco de dados
class DataBaseController extends ChangeNotifier {
  ///Instancia do banco
  FirebaseFirestore db = FirebaseFirestore.instance;

  ///Gerente
  late UserModel user;

  ///Tipo do gerente
  late final positionUser = user.position;

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
    }
  }
}
