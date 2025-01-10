part of 'models.dart';

PdfConveniosModel pdfConveniosModelFromJson(String str) => PdfConveniosModel.fromJson(json.decode(str));

String pdfConveniosModelToJson(PdfConveniosModel data) => json.encode(data.toJson());

class PdfConveniosModel {
  final int statusCode;
  final String message;
  final DataPdf dataPdf;

  PdfConveniosModel({
    required this.statusCode,
    required this.message,
    required this.dataPdf,
  });

  factory PdfConveniosModel.fromJson(Map<String, dynamic> json) => PdfConveniosModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataPdf: DataPdf.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": dataPdf.toJson(),
  };
}

class DataPdf {

  final String documento;
  final String pdfBase64;

  DataPdf({

    required this.documento,
    required this.pdfBase64,
  });

  factory DataPdf.fromJson(Map<String, dynamic> json) => DataPdf(

    documento: json["documento"],
    pdfBase64:ParseModel.parseToString( json["pdfBase64"]),
  );

  Map<String, dynamic> toJson() => {

    "documento": documento,
    "pdfBase64": pdfBase64,
  };
}
