import 'package:flutter/cupertino.dart';

import '../../../../../../app/core/utils/responsiveUtil.dart';
/*
class DesingTxtHora extends StatelessWidget {

  final List<String> datosHora;

 final  List<String> datosMinuto;

  final GlobalKey<FormState> formKey;
  const DesingTxtHora({super.key, required this.formKey, required this.datosHora, required this.datosMinuto});



  @override
  Widget build(BuildContext context) {




    final responsive=ResponsiveUtil();
    return  wgTxtHora(responsive);
  }

  Widget wgTxtHora(ResponsiveUtil responsive) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: responsive.altoP(1),
          ),
          getComboHora(responsive),
          getComboMinuto(responsive)
        ],
      ),
    );
  }

  Widget getComboHora(ResponsiveUtil responsive) {
    List<String> datos = datosHora;

    return ComboBusqueda(
      selectValue: controller.controllerHora.text,
      title: "Hora",
      searchHint: 'Seleccione la Hora',
      datos: datos,
      complete: (String? dato) {
        if (dato != null) {
          controller.controllerHora.text = dato;
        }
      },
    );
  }

  Widget getComboMinuto(ResponsiveUtil responsive) {
    List<String> datos = controller.datosMinuto;

    return ComboBusqueda(
      selectValue: controller.controllerMinuto.text,
      title: "Minuto",
      searchHint: 'Minuto',
      datos: datos,
      complete: (String? dato) {
        if (dato != null) {
          controller.controllerMinuto.text = dato;
        }
      },
    );
  }


  setDatosHora(){
    List<String> datos = [];

    for (int i = 0; i < 24; i++) {
      if (i < 10) {
        datos.add("0" + i.toString());
      } else {
        datos.add(i.toString());
      }
    }

    datosHora=datos;
  }

  setDatosMinuto(){
    List<String> datos = [];
    for (int i = 0; i < 60; i++) {
      if (i < 10) {
        datos.add("0" + i.toString());
      } else {
        datos.add(i.toString());
      }
    }

    datosMinuto=datos;
  }
}
*/