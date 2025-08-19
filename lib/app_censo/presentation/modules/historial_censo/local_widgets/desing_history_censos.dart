import 'package:flutter/material.dart';

import '../../../../../app/core/values/app_colors.dart';
import '../../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../../data/models/models_censo.dart';

class DesingHistoryCensos extends StatelessWidget {
  final List<DataHistoryCenso> listHistoryCenso;

  const DesingHistoryCensos({super.key, required this.listHistoryCenso});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listHistoryCenso.length,
      itemBuilder: (context, index) {
        DataHistoryCenso data = listHistoryCenso[index];
        return _getDesingHistorialCenso(data: data, i: index + 1);
      },
    );
  }

  _getDesingHistorialCenso({required DataHistoryCenso data, required int i}) {
    bool censado = data.estadoCenso.toUpperCase() == "FINALIZADO";

    Widget wg = Column(
      children: [
        TextSombrasWidget(title: "${i}"),
        TituloDetalleTextWidget(title: "Proceso: ", detalle: data.descProceso),
        TituloDetalleTextWidget(title: "Recinto: ", detalle: data.descRecinto),
        TituloDetalleTextWidget(title: "Mesa: ", detalle: data.descMesa),

        censado
            ? TituloDetalleTextWidget(
              title: "Fecha Censo: ",
              detalle: data.fechaRegistroCenso,
            )
            : SizedBox.shrink(),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TituloDetalleTextWidget(
                title: "Censado: ",
                detalle: censado ? "SI" : "NO",
              ),
            ),
            censado
                ? Expanded(
                  flex: 1,
                  child: BtnIconWidget(
                    colorBtn: Colors.transparent,
                    colorIcon: AppColors.colorRojo,
                    icon: Icons.picture_as_pdf,

                    onPressed: () {}, // onPressed puede ser null
                  ),
                )
                : SizedBox.shrink(),
          ],
        ),
      ],
    );

    wg = ContenedorDesingWidget(
      child: wg,
      margin: EdgeInsets.only(bottom: 5),
      paddin: EdgeInsets.all(5),
    );
    return wg;
  }
}
