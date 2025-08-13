
import 'dart:convert';

MenuAppModel menuAppModelFromJson(String str) => MenuAppModel.fromJson(json.decode(str));

String menuAppModelToJson(MenuAppModel data) => json.encode(data.toJson());

class MenuAppModel {
  final int statusCode;
  final String message;
  final DataMenu dataMenu;

  MenuAppModel({
    required this.statusCode,
    required this.message,
    required this.dataMenu,
  });

  factory MenuAppModel.fromJson(Map<String, dynamic> json) => MenuAppModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataMenu: DataMenu.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": dataMenu.toJson(),
  };
}

class DataMenu {
  final bool siipneElecciones;
  final bool siipneCenso;

  DataMenu({
    required this.siipneElecciones,
    required this.siipneCenso,
  });

  factory DataMenu.empty()=>DataMenu(siipneElecciones: true, siipneCenso: false);

  factory DataMenu.fromJson(Map<String, dynamic> json) => DataMenu(
    siipneElecciones: json["siipneElecciones"],
    siipneCenso: json["siipneCenso"],
  );

  Map<String, dynamic> toJson() => {
    "siipneElecciones": siipneElecciones,
    "siipneCenso": siipneCenso,
  };
}
