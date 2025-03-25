part of 'models_user.dart';



DataUser dataUserFromJson(String str) => DataUser.fromJson(json.decode(str));

String dataUserToJson(DataUser data) => json.encode(data.toJson());

class DataUser {
  final int statusCode;
  final String message;
  final UserModel user;

  DataUser({
    required this.statusCode,
    required this.message,
    required this.user,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
    statusCode: json["status_code"],
    message: json["message"],
    user: UserModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": user.toJson(),

  };
}

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int idGenUsuario;
  final int idGenPersona;
  final String nombreUsuario;
  final int idDgpGrado;
  final String documento;
  final String apenom;
  final String sexoPerson;
  final String gradoSiglas;
  final String unidad;
  final String funcion;
  final String grado;
  final String foto;

  UserModel({
    required this.idGenUsuario,
    required this.idGenPersona,
    required this.nombreUsuario,
    required this.idDgpGrado,
    required this.documento,
    required this.apenom,
    required this.sexoPerson,
    required this.gradoSiglas,
    required this.unidad,
    required this.funcion,
    required this.grado,
    required this.foto,
  });

  factory UserModel.empty() => UserModel(
    idGenUsuario: 0,
    idGenPersona: 0,
    nombreUsuario: "",
    idDgpGrado: 0,
    documento: "",
    apenom: "",
    sexoPerson: "",
    gradoSiglas: "",
    unidad: "",
    funcion: "",
    grado: "",
    foto: "",
  );
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    idGenUsuario: ParseModel.parseToInt(json["idGenUsuario"]),
    idGenPersona: ParseModel.parseToInt(json["idGenPersona"]),
    nombreUsuario: ParseModel.parseToString(json["nombreUsuario"]),
    idDgpGrado: ParseModel.parseToInt(json["idDgpGrado"]),
    documento: ParseModel.parseToString(json["documento"]),
    apenom: ParseModel.parseToString(json["apenom"]),
    sexoPerson: ParseModel.parseToString(json["sexoPerson"]),
    gradoSiglas: ParseModel.parseToString(json["gradoSiglas"]),
    unidad: ParseModel.parseToString(json["unidad"]),
    funcion: ParseModel.parseToString(json["funcion"]),
    grado: ParseModel.parseToString(json["grado"]),
    foto: ParseModel.parseToString(json["foto"]),
  );

  Map<String, dynamic> toJson() => {
    "idGenUsuario": idGenUsuario,
    "idGenPersona": idGenPersona,
    "nombreUsuario": nombreUsuario,
    "idDgpGrado": idDgpGrado,
    "documento": documento,
    "apenom": apenom,
    "sexoPerson": sexoPerson,
    "gradoSiglas": gradoSiglas,
    "unidad": unidad,
    "funcion": funcion,
    "grado": grado,
    "foto": foto,
  };
}
