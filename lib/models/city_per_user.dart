///Classe dos usuarios por cidade
class CityUserModel {
  ///Construtor
  CityUserModel({
    required this.idCity,
    required this.idUser,
  });

  ///Nota sobre colaboradores
  final int idCity;

  ///Comentário
  final String idUser;

  ///Map em model
  factory CityUserModel.fromMap(Map<String, dynamic> map) {
    return CityUserModel(
      idCity: map['idCity'],
      idUser: map['idUser'],
    );
  }

  /// Model em map
  Map<String, dynamic> toMap() {
    return {
      'idCity': idCity,
      'idUser': idUser,
    };
  }
}
