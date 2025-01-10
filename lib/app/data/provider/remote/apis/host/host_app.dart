part of '../../../providers_impl_app.dart';

class HostApp {
  //se utiliza el onlyUrl para no incluir el segmento
  // api/v1/siipne-movil/




  static getDes() {
    return dotenv.env['HOST_DEV'] ?? 'https://siipne3wv2.policia.gob.ec/';
  }

  static getTest() {
    return dotenv.env['HOST_TEST'] ?? 'https://siipne3wv2.policia.gob.ec/';

  }

  static getProd() {
    return dotenv.env['HOST_PROD'] ?? 'https://siipne3wv2.policia.gob.ec/';
  }

  static gethost({bool onlyUrl = false}) {
    String url = '';
    String path = dotenv.env['PATH_APP'] ?? '';
    switch (AppConfig.AmbienteUrl) {
      case Ambiente.desarrollo:
        url = getDes() + path; //Desarrollo

        break;
      case Ambiente.prueba:
        url = getTest() + path; //Pruebas

        break;
      case Ambiente.produccion:
        url = getProd() + path; //Produccion

        break;
    }
    return url;
  }



  static getAmbiente() {
    String ambiente = '';
    switch (AppConfig.AmbienteUrl) {
      case Ambiente.desarrollo:
        ambiente = "Desc"; //Desarrollo

        break;
      case Ambiente.prueba:

        ambiente="Test";
        break;
      case Ambiente.produccion:
        ambiente = "Prod"; //Produccion

        break;
    }
    return ambiente;
  }


}
