// To parse this JSON data, do
//
//     final abrirRecintoElectoralModel = abrirRecintoElectoralModelFromJson(jsonString);

part of '../models.dart';

AbrirRecintoElectoralModel abrirRecintoElectoralModelFromJson(String str) =>
    AbrirRecintoElectoralModel.fromJson(json.decode(str));

String abrirRecintoElectoralModelToJson(AbrirRecintoElectoralModel data) =>
    json.encode(data.toJson());

class AbrirRecintoElectoralModel {
  AbrirRecintoElectoralModel({
    required this.abrirRecintoElectoral,
  });

  AbrirRecintoElectoral abrirRecintoElectoral;

  factory AbrirRecintoElectoralModel.fromJson(Map<String, dynamic> json) =>
      AbrirRecintoElectoralModel(
        abrirRecintoElectoral: json["datos"] == null
            ? AbrirRecintoElectoral.empty()
            : AbrirRecintoElectoral.fromJson(json["datos"]),
      );

  Map<String, dynamic> toJson() => {
        "AbrirRecintoElectoral": abrirRecintoElectoral == null
            ? null
            : abrirRecintoElectoral.toJson(),
      };
}

class AbrirRecintoElectoral {
  AbrirRecintoElectoral(
      {required this.idDgoCreaOpReci,
      required this.idDgoReciElect,
      required this.idGenPersona,
      this.estado = "Sin Estado",
      required this.fechaIni,
      required this.fechaFin,
      required this.usuario,
      required this.fecha,
      required this.ip,
      required this.apenom,
      required this.sexoPerson,
      required this.telefono,
      this.crearCodigo = false});

  int idDgoCreaOpReci;
  int idDgoReciElect;
  int idGenPersona;
  String estado;
  String fechaIni;
  String fechaFin;
  int usuario;
  String fecha;
  String ip;
  String apenom;
  String sexoPerson;
  bool crearCodigo;
  String telefono;

  factory AbrirRecintoElectoral.empty() => AbrirRecintoElectoral(
      idDgoCreaOpReci: 0,
      idDgoReciElect: 0,
      idGenPersona: 0,
      fechaIni: "",
      fechaFin: "",
      usuario: 0,
      fecha: "",
      ip: "",
      apenom: "",
      sexoPerson: "",
      telefono: "");
  factory AbrirRecintoElectoral.fromJson(Map<String, dynamic> json) =>
      AbrirRecintoElectoral(
        idDgoCreaOpReci: ParseModel.parseToInt(json["idDgoCreaOpReci"]),
        idDgoReciElect: ParseModel.parseToInt(json["idDgoReciElect"]),
        idGenPersona: ParseModel.parseToInt(json["idGenPersona"]),
        estado: ParseModel.parseToString(json["estado"]),
        fechaIni: ParseModel.parseToString(json["fechaIni"]),
        fechaFin: ParseModel.parseToString(json["fechaFin"]),
        usuario: ParseModel.parseToInt(json["usuario"]),
        fecha: ParseModel.parseToString(json["fecha"]),
        ip: ParseModel.parseToString(json["ip"]),
        apenom: ParseModel.parseToString(json["apenom"]),
        sexoPerson: ParseModel.parseToString(json["sexoPerson"]),
        telefono: ParseModel.parseToString(json["telefono"]),
        crearCodigo: ParseModel.parseToBool(json["crearCodigo"]),
      );

  Map<String, dynamic> toJson() => {
        "idDgoCreaOpReci": idDgoCreaOpReci == null ? null : idDgoCreaOpReci,
        "idDgoReciElect": idDgoReciElect == null ? null : idDgoReciElect,
        "estado": estado == null ? null : estado,
        "fechaIni": fechaIni == null ? null : fechaIni,
        "fechaFin": fechaFin == null ? null : fechaFin,
        "usuario": usuario == null ? null : usuario,
        "fecha": fecha == null ? null : fecha,
        "ip": ip == null ? null : ip,
        "apenom": apenom == null ? null : apenom,
        "sexoPerson": sexoPerson == null ? null : sexoPerson,
      };
}
