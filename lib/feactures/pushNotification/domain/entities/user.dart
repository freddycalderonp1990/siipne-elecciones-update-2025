
import 'dart:convert';

UserEntities userEntitiesFromJson(String str) =>
    UserEntities.fromJson(json.decode(str));

String userEntitiesToJson(UserEntities data) =>
    json.encode(data.toJson());

class UserEntities {
  final int idGenUsuario;
  final int idGenPersona;
  final String nombreUsuario;
  final int idDgpGrado;
  final String documento;
  final String nombres;
  final String sexo;
  final String gradoSiglas;
  final String unidad;
  final String funcion;
  final String grado;
  final String foto;
  final String token;

  UserEntities({
    required this.idGenUsuario,
    required this.idGenPersona,
    required this.nombreUsuario,
    required this.idDgpGrado,
    required this.documento,
    required this.nombres,
    required this.sexo,
    required this.gradoSiglas,
    required this.unidad,
    required this.funcion,
    required this.grado,
    required this.foto,
    required this.token,
  });

  UserEntities copyWith({
    int? idGenUsuario,
    int? idGenPersona,
    String? nombreUsuario,
    int? idDgpGrado,
    String? documento,
    String? nombres,
    String? sexo,
    String? gradoSiglas,
    String? unidad,
    String? funcion,
    String? grado,
    String? foto,
    String? token,
  }) {
    return UserEntities(
      idGenUsuario: idGenUsuario ?? this.idGenUsuario,
      idGenPersona: idGenPersona ?? this.idGenPersona,
      nombreUsuario: nombreUsuario ?? this.nombreUsuario,
      idDgpGrado: idDgpGrado ?? this.idDgpGrado,
      documento: documento ?? this.documento,
      nombres: nombres ?? this.nombres,
      sexo: sexo ?? this.sexo,
      gradoSiglas: gradoSiglas ?? this.gradoSiglas,
      unidad: unidad ?? this.unidad,
      funcion: funcion ?? this.funcion,
      grado: grado ?? this.grado,
      foto:foto ?? this.foto,
      token: token ?? this.token,
    );
  }

  factory UserEntities.empty() => UserEntities(
    idGenUsuario: 0,
    idGenPersona: 0,
    nombreUsuario: "",
    idDgpGrado: 0,
    documento: "",
    nombres: "",
    sexo: "",
    gradoSiglas: "",
    unidad: "",
    funcion: "",
    grado: "",
    foto: "",
    token: "",
  );


  factory UserEntities.fromJson(Map<String, dynamic> json) {


    return UserEntities(
      idGenUsuario: json['idGenUsuario'] ?? 0,
      idGenPersona: json['idGenPersona'] ?? 0,
      nombreUsuario: json['nombreUsuario'] ?? '',
      idDgpGrado: json['idDgpGrado'] ?? 0,
      documento: json['documento'] ?? '',
      nombres: json['nombres'] ?? '',
      sexo: json['sexo'] ?? '',
      gradoSiglas: json['gradoSiglas'] ?? '',
      unidad: json['unidad'] ?? '',
      funcion: json['funcion'] ?? '',
      grado: json['grado'] ?? '',
      foto: json['foto'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idGenUsuario': idGenUsuario,
      'idGenPersona': idGenPersona,
      'nombreUsuario': nombreUsuario,
      'idDgpGrado': idDgpGrado,
      'documento': documento,
      'nombres': nombres,
      'sexo': sexo,
      'gradoSiglas': gradoSiglas,
      'unidad': unidad,
      'funcion': funcion,
      'grado': grado,
      'foto': foto,
      'token': token,
    };
  }
}
