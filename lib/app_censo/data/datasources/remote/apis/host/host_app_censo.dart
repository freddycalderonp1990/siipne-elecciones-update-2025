part of  '../../../censo_datasource_impl.dart';

class HostAppCenso{
  //se utiliza el onlyUrl para no incluir el segmento
  // api/v1/siipne-movil/

  static gethost() {

    String segmento = dotenv.env['SEGMENTO_APP_CENSO'] ?? '';
    String url = HostApp.gethost( segmento: segmento);
    return url;
  }

}
