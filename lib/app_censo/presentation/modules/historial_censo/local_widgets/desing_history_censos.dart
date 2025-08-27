import 'package:flutter/material.dart';

import '../../../../../app/core/values/app_colors.dart';
import '../../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../../data/models/models_censo.dart';
import '../../../../domain/request/request_censo.dart';
import '../../controllers.dart';

class DesingHistoryCensos extends StatelessWidget {
  final DataHistoryCenso data;
  final int index;

  final VoidCallback onPressed;


  const DesingHistoryCensos({super.key, required this.data, required this.index, required this.onPressed, });

  @override
  Widget build(BuildContext context) {

    return _getDesingHistorialCenso(data: data,i: index);

  }

  _getDesingHistorialCenso({required DataHistoryCenso data, required int i}) {
    bool censado = data.estadoCenso.toUpperCase() == "FINALIZADO";

    Widget wg = Column(
      children: [
        TextSombrasWidget(title: "${i}"),
        TituloDetalleTextWidget(title: "Proceso: ", detalle: data.proceso),
        TituloDetalleTextWidget(title: "Recinto del Censo: ", detalle: data.recintoCenso),
        TituloDetalleTextWidget(title: "Mesa del Censo: ", detalle: data.mesaCensado),

        censado
            ? Column(children: [
          TituloDetalleTextWidget(
            title: "Censado Por: ",
            detalle: data.nameCensista,
          ),
             TituloDetalleTextWidget(
            title: "Fecha Censo: ",
            detalle: data.fechaRegistroCenso,
          )
        ],)
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

                    onPressed: onPressed, // onPressed puede ser null
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
