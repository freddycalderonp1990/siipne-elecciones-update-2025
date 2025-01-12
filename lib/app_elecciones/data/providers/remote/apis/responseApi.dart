//Clase para validar las respuestas del servidor
part of '../../providers_impl.dart';


class ResponseApi{

  static String validateConsultas({required String json,required String titleJson}){


      final MsjServerModel = MsjServerModelFromJson(json, titleJson);

      if (MsjServerModel.item.msj == ApiConstantes.varTrue ||
          MsjServerModel.item.msj == ApiConstantes.varExiste) {
        return ApiConstantes.varTrue;
      }
      else {
        return MsjServerModel.item.msj;
      }


  }



  static String validateConsultasExiste({required String json,required String titleJson}){




      final MsjServerModel = MsjServerModelFromJson(json, titleJson);


      if ( MsjServerModel.item.msj == ApiConstantes.varExiste) {
        return ApiConstantes.varExiste;
      }
      else {
        return MsjServerModel.item.msj;
      }


  }

  static Future<String> validateInsert({required String json,required String titleJson}) async{

    final MsjServerModel = MsjServerModelFromJson(json,titleJson);
    if(MsjServerModel.item.msj==ApiConstantes.varTrue ) {
      return ApiConstantes.varTrue;
    }
    else{
      return MsjServerModel.item.msj;
    }


  }


  static String validateUpdate({required String json, required String titleJson}){

      final MsjServerModel = MsjServerModelFromJson(json,titleJson);
      return MsjServerModel.item.msj;

  }
}