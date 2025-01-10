part of '../../../providers_impl.dart';

class HostSiipneMovil {
  //se utiliza el onlyUrl para no incluir el segmento
  // api/v1/siipne-movil/

  static gethost({bool onlyUrl = false}) {
    String url = HostApp.gethost(onlyUrl: onlyUrl);


    url=_setSegmento(url,onlyUrl);
    return url;
  }

  static  _setSegmento(String url, onlyUrl) {
    if (onlyUrl) {
      return url;
    }

    String segmento = '';

    return url + segmento;
  }
}
