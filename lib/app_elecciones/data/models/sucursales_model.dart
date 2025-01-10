part of 'models.dart';

SucursalesModel sucursalesModelFromJson(String str) => SucursalesModel.fromJson(json.decode(str));

String sucursalesModelToJson(SucursalesModel data) => json.encode(data.toJson());

class SucursalesModel {
  final int statusCode;
  final String message;
  final List<DataSucursale> dataSucursales;

  SucursalesModel({
    required this.statusCode,
    required this.message,
    required this.dataSucursales,
  });

  factory SucursalesModel.fromJson(Map<String, dynamic> json) => SucursalesModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataSucursales: List<DataSucursale>.from(json["data"].map((x) => DataSucursale.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": List<dynamic>.from(dataSucursales.map((x) => x.toJson())),
  };
}

class DataSucursale {
  final int idDbsSucursalEmpresa;
  final String nombreSucursal;
  final String direccion;
  final double latitud;
  final double longitud;
  final String horarioAtencion;
  final String documento;
  final String contacto;
  final String nombreContacto;
  final String provincia;
  final double distancia;

  DataSucursale({
    required this.idDbsSucursalEmpresa,
    required this.nombreSucursal,
    required this.direccion,
    required this.latitud,
    required this.longitud,
    required this.horarioAtencion,
    required this.documento,
    required this.contacto,
    required this.nombreContacto,
    required this.provincia,
    required this.distancia
  });

  factory DataSucursale.fromJson(Map<String, dynamic> json) => DataSucursale(
    idDbsSucursalEmpresa:ParseModel.parseToInt( json["idDbsSucursalEmpresa"]),
    nombreSucursal:ParseModel.parseToString( json["nombreSucursal"]),
    direccion: ParseModel.parseToString(json["direccion"]),
    latitud: ParseModel.parseToDouble(json["latitud"],decimales: 8),
    longitud:ParseModel.parseToDouble( json["longitud"],decimales: 8),
    horarioAtencion: ParseModel.parseToString(json["horarioAtencion"]),
    documento:ParseModel.parseToString( json["documento"]),
    contacto:ParseModel.parseToString( json["contacto"]),
    nombreContacto:ParseModel.parseToString( json["nombreContacto"]),
    provincia: ParseModel.parseToString( json["provincia"]),
    distancia: ParseModel.parseToDouble(json["distancia"])
  );

  Map<String, dynamic> toJson() => {
    "idDbsSucursalEmpresa": idDbsSucursalEmpresa,
    "nombreSucursal": nombreSucursal,
    "direccion": direccion,
    "latitud": latitud,
    "longitud": longitud,
    "horarioAtencion": horarioAtencion,
    "documento": documento,
    "contacto": contacto,
    "nombreContacto": nombreContacto,
  };
}
