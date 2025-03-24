part of 'models.dart';

DataUser obtenerDataUserDesdeToken(String token) {
  try {
    // Divide el token en sus partes
    List<String> partes = token.split('.');
    if (partes.length != 3) {
      print("Token inválido");
      return DataUser.empty();
    }

    // Decodifica el payload (parte 2)
    String payload = partes[1];
    String payloadNormalizado = base64Url.normalize(payload);
    String payloadDecodificado = utf8.decode(base64Url.decode(payloadNormalizado));

    // Convierte el payload a JSON
    Map<String, dynamic> payloadMap = json.decode(payloadDecodificado);
    // Obtiene y retorna el modelo DataUser de la sección 'data'
    if (payloadMap.containsKey('data')) {
      return DataUser.fromJson(payloadMap['data']);
    } else {
      print("La sección 'data' no existe en el token.");
      return DataUser.empty();
    }
  } catch (e) {
    print("Error al decodificar el token: $e");
    return DataUser.empty();
  }
}

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int status_code;
  final String message;
  final DataUser dataUser;

  UserModel({
    required this.status_code,
    required this.message,
    required this.dataUser,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status_code: ParseModel.parseToInt( json["status_code"]),
    message: ParseModel.parseToString( json["message"]),
    dataUser: DataUser.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": status_code,
    "message": message,
    "data": dataUser.toJson(),
  };
}


String userModelToJsonLocalDB(DataUser data) => json.encode(data.toJson());
DataUser userModelFromJsonLocalDB(String str) => DataUser.fromJson(json.decode(str));


class DataUser {
  final int idGenUsuario;
  final int idGenPersona;
  final int idGrado;
  final String nombres;
  final String documento;
  final String userName;
  final String sexo;
  final String foto;
  final String token;



  DataUser( {
    required this.idGenUsuario,
    required this.idGenPersona,
    required this.userName,
    required this.nombres,
    required this.documento,
    required this.sexo,
    required this.foto,
   required this.token,
    required this.idGrado
  });




  factory DataUser.empty() => DataUser(
    idGrado: 0,
    token: "",
      idGenUsuario: 0,
      idGenPersona: 0,
      userName: '',
      nombres:  '',
      documento: '',
      sexo: '',
      foto: '');


  // Método copyWith para actualizar solo los campos deseados
  DataUser copyWith({
    String? token,
    int? idGenUsuario,
    int? idGenPersona,
    String? userName,
    String? nombres,
    String? documento,
    String? sexo,
    String? foto,
    int? idGrado,
  }) {
    return DataUser(
      idGrado:  idGrado ?? this.idGrado,
      token: token ?? this.token,
      idGenUsuario: idGenUsuario ?? this.idGenUsuario,
      idGenPersona: idGenPersona ?? this.idGenPersona,
      userName: userName ?? this.userName,
      nombres: nombres ?? this.nombres,
      documento: documento ?? this.documento,
      sexo: sexo ?? this.sexo,
      foto: foto ?? this.foto,
    );
  }

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
    idGenUsuario: ParseModel.parseToInt(json["idGenUsuario"]),
    idGenPersona: ParseModel.parseToInt(json["idGenPersona"]),
    idGrado: ParseModel.parseToInt(json["idGrado"]),
    userName: ParseModel.parseToString(json["userName"]),
    nombres: ParseModel.parseToString(json["nombres"]),
    documento: ParseModel.parseToString(json["documento"]),
    sexo: ParseModel.parseToString(json["sexo"]),
    foto: ParseModel.parseToString(json["foto"]),
    token: ParseModel.parseToString(json["token"]),
  );

  Map<String, dynamic> toJson() => {
    "idGenUsuario": idGenUsuario,
    "idGrado": idGrado,
    "idGenPersona": idGenPersona,
    "userName": userName,
    "nombres": nombres,
    "documento": documento,
    "sexo": sexo,
    "foto": foto,
    "token": token,
  };
}








