import 'package:flutter/material.dart';

import '../../../../../app/core/utils/responsiveUtil.dart';
import '../../../../../app/core/values/app_colors.dart';
import '../../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../../data/models/models_censo.dart';
import '';

class DesingDatosCenso extends StatelessWidget {
  final List<DataProceso> dataProcesos;
  final VoidCallback? onPressed;

  const DesingDatosCenso({
    super.key,
    required this.dataProcesos,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    Widget wg = ListView.builder(
      itemCount: dataProcesos.length,
      itemBuilder: (context, index) {
        DataProceso data = dataProcesos[index];
        return wgDatosCenso(data,context);
      },
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),

      height: responsive.altoP(35),

      child: Column(
        children: [
          TextSombrasWidget(
            title: "INFORMACIÓN DEL CENSO",
            colorTexto: AppColors.colorAzul,
          ),
          TextSombrasWidget(
            colorTexto: AppColors.colorPlomo,
            title:
                "Por favor, verifique los datos y continúe con el censo.",
          ),

          Flexible(child: wg),
        ],
      ),
    );
  }

  Widget wgDatosCenso( DataProceso  data,BuildContext context) {
    final responsive = ResponsiveUtil();
    bool censado=data.estadoCenso.toUpperCase()=="FINALIZADO";
   // censado=true;

    Widget wg = Column(
      children: [
        TituloDetalleTextWidget(
          title: "Proceso: ",
          detalle: data.descProceso,
        ),
        TituloDetalleTextWidget(
          title: "Recinto: ",
          detalle: data.descRecinto,
        ),
        TituloDetalleTextWidget(title: "Mesa: ", detalle: data.descMesa),

        TituloDetalleTextWidget(
          title: "Censado: ",
          detalle: censado?"SI":"NO",
        ),

        BtnIconWidget(
          icon: Icons.navigate_next_outlined,
          titulo: censado?"ACEPTAR":"CONTINUAR",
          onPressed: censado
              ? () => Navigator.pop(context)
              : onPressed, // onPressed puede ser null
        ),
        SizedBox(height: responsive.altoP(2)),
      ],
    );

    return wg;
  }
}
