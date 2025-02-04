///Classe dos usuários (gerentes)
class UserModel {
  ///Construtor
  UserModel({
    required this.name,
    required this.idCompany,
    required this.position,
  });


  ///Nome do gerente
  String name;

  ///Filial responsável
  String idCompany;

  ///Tipo de gerente
  int position;

  ///Map em model
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      position: map['position'],
      idCompany: map['idCompany'],
    );
  }

  /// Model em map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'position': position,
      'idCompany': idCompany,
    };
  }
}
