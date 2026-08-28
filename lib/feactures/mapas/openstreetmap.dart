import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';

enum TipoMapa {
  claro,
  oscuro,
  voyager,
  openStreetMap,
}

class Openstreetmap {
  static const String _packageName='ecuador.policianacional.dntic.siipnemovil2';
  static const String _userAgent='SIIPNE-ELECCIONES/1.0';

  static TileLayer getMapa({
    TipoMapa tipoMapa=TipoMapa.voyager,
    bool retina=true,
    bool mostrarErrores=true,
  }) {
    final _ConfiguracionMapa configuracion=_getConfiguracion(tipoMapa);

    return TileLayer(
      urlTemplate:configuracion.urlTemplate,
      userAgentPackageName:_packageName,
      subdomains:configuracion.subdomains,
      minNativeZoom:0,
      maxNativeZoom:configuracion.maxNativeZoom,
      minZoom:0,
      maxZoom:22,
      retinaMode:retina,
      panBuffer:1,
      keepBuffer:2,
      tileProvider:NetworkTileProvider(
        headers:{
          'User-Agent':_userAgent,
        },
      ),
      errorTileCallback:mostrarErrores
          ?(tile,error,stackTrace){
        if(kDebugMode){
          print('ERROR MAPA [$tipoMapa]');
          print('Tile: $tile');
          print('Error: $error');
        }
      }
          :null,
    );
  }

  static _ConfiguracionMapa _getConfiguracion(TipoMapa tipoMapa) {
    switch(tipoMapa){
      case TipoMapa.oscuro:
        return const _ConfiguracionMapa(
          urlTemplate:'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
          subdomains:['a','b','c','d'],
          maxNativeZoom:20,
        );

      case TipoMapa.voyager:
        return const _ConfiguracionMapa(
          urlTemplate:'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
          subdomains:['a','b','c','d'],
          maxNativeZoom:20,
        );

      case TipoMapa.openStreetMap:
        return const _ConfiguracionMapa(
          urlTemplate:'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains:[],
          maxNativeZoom:19,
        );

      case TipoMapa.claro:
        return const _ConfiguracionMapa(
          urlTemplate:'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
          subdomains:['a','b','c','d'],
          maxNativeZoom:20,
        );
    }
  }
}

class _ConfiguracionMapa {
  final String urlTemplate;
  final List<String> subdomains;
  final int maxNativeZoom;

  const _ConfiguracionMapa({
    required this.urlTemplate,
    required this.subdomains,
    required this.maxNativeZoom,
  });
}