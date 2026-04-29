import 'package:flutter_map/flutter_map.dart';

class Openstreetmap {
  static TileLayer getMapa() {
    return new TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: "ecuador.policianacional.dntic.siipnemovil2",
      additionalOptions: {
        'User-Agent':
            'SIIPNE-ELECCIONES/1.0 (+mailto:freddy.calderon@policia.gob.ec)',
      },
      tileProvider: NetworkTileProvider(
        headers: {
          'User-Agent': 'SIIPNE/1.0 (+mailto:freddy.calderon@policia.gob.ec)',
        },
      ),
    );
  }
}
