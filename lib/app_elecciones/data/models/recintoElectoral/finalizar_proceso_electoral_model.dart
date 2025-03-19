part of '../models.dart';


class FinalizarProcesoElectoralModel {
  FinalizarProcesoElectoralModel({
    required  this.finalizarRecintoElectoral,
  });

  final FinalizarRecintoElectoral finalizarRecintoElectoral;

  factory FinalizarProcesoElectoralModel.fromJson(String str) => FinalizarProcesoElectoralModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FinalizarProcesoElectoralModel.fromMap(Map<String, dynamic> json) => FinalizarProcesoElectoralModel(
    finalizarRecintoElectoral: FinalizarRecintoElectoral.fromMap(json["finalizarRecintoElectoral"]),
  );

  Map<String, dynamic> toMap() => {
    "finalizarRecintoElectoral": finalizarRecintoElectoral.toMap(),
  };
}

class FinalizarRecintoElectoral {
  FinalizarRecintoElectoral({
    required  this.codeError,
    required  this.msj,
    required   this.datos,
  });

  final int codeError;
  final String msj;
  final datosFinalizarProceso datos;

  factory FinalizarRecintoElectoral.fromJson(String str) => FinalizarRecintoElectoral.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FinalizarRecintoElectoral.fromMap(Map<String, dynamic> json) => FinalizarRecintoElectoral(
    codeError: json["codeError"],
    msj: json["msj"],
    datos: datosFinalizarProceso.fromMap(json["datos"]),
  );

  Map<String, dynamic> toMap() => {
    "codeError": codeError,
    "msj": msj,
    "datos": datos.toMap(),
  };
}

class datosFinalizarProceso {
  datosFinalizarProceso( {
    required  this.horaServer,
    required   this.horaValidate,
    this.insert = false
  });

  final String horaServer;
  final String horaValidate;
  final bool insert;

  factory datosFinalizarProceso.fromJson(String str) => datosFinalizarProceso.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory datosFinalizarProceso.fromMap(Map<String, dynamic> json) => datosFinalizarProceso(
    horaServer: ParseModel.parseToString(json["horaServer"]),
    horaValidate: ParseModel.parseToString(json["horaValidate"]),
  );

  /// Método `copyWith()` para crear una copia del objeto con valores modificados
  datosFinalizarProceso copyWith({
    String? horaServer,
    String? horaValidate,
    bool? insert,
  }) {
    return datosFinalizarProceso(
      horaServer: horaServer ?? this.horaServer,
      horaValidate: horaValidate ?? this.horaValidate,
      insert: insert ?? this.insert,
    );
  }


  Map<String, dynamic> toMap() => {
    "horaServer": horaServer,
    "horaValidate": horaValidate,
  };
}
