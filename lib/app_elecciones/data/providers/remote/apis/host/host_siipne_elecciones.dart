part of '../../../providers_impl.dart';

class HostSiipneElecciones {
  //se utiliza el onlyUrl para no incluir el segmento
  // api/v1/siipne-movil/

  static gethost() {

    String segmento = dotenv.env['SEGMENTO_APP_ELECCIONES'] ?? '';
    String url = HostApp.gethost( segmento: segmento);
    return url;
  }

}
