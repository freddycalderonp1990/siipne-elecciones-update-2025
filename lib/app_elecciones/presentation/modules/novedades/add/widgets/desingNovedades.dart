import 'package:flutter/cupertino.dart';

import '../../../../../../app/core/utils/responsiveUtil.dart';
/*
class DesingNovedades extends StatelessWidget {
  final ValueChanged<bool> completeValidarForm;
  final ValueChanged<bool> completeRegistrarDatosPersona;
  const DesingNovedades({super.key,required this.CompleteValidarForm});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }




  Widget wgCajasTextoNovedades(
      int idDgoNovedadesElect, ResponsiveUtil responsive) {
    Widget wg = Container();

   bool validarForm = false;
   bool mostrarFoto = false;
   bool registrarDatosPersona = false;
   
    switch (idDgoNovedadesElect) {
      case 17:
      //1. RECINTOS ELECTORALES INSTALADOS
        wg = Container();
        break;

      case 18:
      //2. RECINTOS ELECTORALES NO INSTALADOS
        wg = Container();
        break;

      case 19:
      //3. RECINTO ELECTORAL INSTALADO CON RETARDO POR DIFERENTES CAUSAS

        wg = wgTxtHora(responsive);
        validarForm = true;
        break;

      case 20:
      //4. RECINTOS ELECTORALES SUSPENDIDO POR DIFERENTES CAUSAS
        wg = wgTxtMotivo(responsive);
        validarForm = true;
        mostrarFoto = true;
        break;

      case 21:
      //5. AGRESIONES A SERVIDORES POLICIALES
        wg = wgTxtCedula(responsive: responsive, title: SiipneStrings.cedulaSP);
        validarForm = true;
        mostrarFoto = true;
        break;

      case 22:
      //6. PRESENCIA DE MANIFESTANTES / CONCENTRACIONES / MARCHAS
        wg = Column(
          children: [
            wgTxtNumeroManifestantes(responsive),
            SizedBox(
              height: responsive.altoP(1),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.green.withOpacity(0.8),
                      title: "1-50"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.yellow.withOpacity(0.8),
                      title: "51-200"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.orange.withOpacity(0.8),
                      title: "201-500"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.red.withOpacity(0.8),
                      title: "501-Más"),
                ],
              ),
            )
          ],
        );
        validarForm = true;
        mostrarFoto = true;
        break;

      case 23:
      //7. QUEMA DE URNAS / PAPELETAS
        validarForm = true;
        mostrarFoto = true;
        wg = Column(
          children: [
            wgTxtNumeroQuemaUrnas(responsive),
            SizedBox(
              height: responsive.altoP(1),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.green.withOpacity(0.8),
                      title: "1-50"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.yellow.withOpacity(0.8),
                      title: "51-200"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.orange.withOpacity(0.8),
                      title: "201-500"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.red.withOpacity(0.8),
                      title: "501-Más"),
                ],
              ),
            )
          ],
        );
        break;

      case 28:
      //8. TOMA DE RECINTOS / DELEGACIONES / BODEGAS / INSTALACIONES DEL CNE
        validarForm = true;
        mostrarFoto = true;
        wg = Column(
          children: [
            wgTxtNumeroTomaRecintos(responsive),
            SizedBox(
              height: responsive.altoP(1),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.green.withOpacity(0.8),
                      title: "1-50"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.yellow.withOpacity(0.8),
                      title: "51-200"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.orange.withOpacity(0.8),
                      title: "201-500"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.red.withOpacity(0.8),
                      title: "501-Más"),
                ],
              ),
            )
          ],
        );
        break;

      case 29:
      //9. PRESENCIA DE VENTAS AMBULANTES
        wg = Container();
        mostrarFoto = true;
        break;

      case 30:
      //10. ATENCIÓN MÉDICA POR DIFERENTES CAUSAS
        validarForm = true;
        mostrarFoto = true;
        wg = wgTxtCedulaTelefono(responsive: responsive);
        break;

      case 31:
      //11. SERVIDORES POLICIALES INFECTADOS (SOSPECHA/POSITIVO)

        validarForm = true;
        wg = wgTxtCedulaTelefono(
            responsive: responsive, title: SiipneStrings.cedulaSP);
        break;

      case 32:
      //NUMÉRICO DE ACÉMILAS
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

    /*********************** UMO ***************************************/
      case 33:
      //1. NUMERICO DE PERSONAL
        wg = wgTxtNumericoPersonal(responsive);
        validarForm = true;
        validarForm = true;
        break;

      case 34:
      //2. PLANTONES
        wg = wgorganizacionDirigenteCantidad(responsive);
        validarForm = true;
        validarForm = true;
        break;

      case 35:
      //3. MARCHAS
        wg = wgorganizacionDirigenteCantidad(responsive);
        validarForm = true;
        validarForm = true;
        break;

      case 36:
      //4. CIERRE DE VIAS
        wg = wgorganizacionDirigenteCantidad(responsive);
        validarForm = true;
        validarForm = true;
        break;

      case 37:
      //5. TOMA DE ENTIDADES
        wg = wgorganizacionDirigenteCantidad(responsive);
        validarForm = true;
        validarForm = true;
        break;

    /************************AEREOPOLCIAL*************************************/
      case 45:
      //1. DESPLAZAMIENTO DE AUTORIDADES
        wg = wgTxtDesplazamientosAutoridades(responsive);
        validarForm = true;
        break;

      case 46:
      //2. DESPLAZAMIENTO DE SERVIDORES PÚBLICOS
        wg = wgTxtDesplazamientosAutoridades(responsive);
        validarForm = true;
        break;

      case 47:
      //3. APOYO AÉREO A MEDIOS DE COMUNICACIÓN
        wg = wgTxtApoyoMediosComunicacion(responsive);
        validarForm = true;
        break;
    /************************GOE - GIR*************************************/
      case 41:
      //1. SEGURIDAD DE PERSONAS IMPORTANTES
        wg = wgTxtSeguridadPersonasImportantes(responsive);
        validarForm = true;
        break;

      case 42:
      //2. SEGURIDAD DE INSTALACIONES
        wg = wgTxtSeguridadInstalaciones(responsive);
        validarForm = true;
        mostrarFoto = true;
        break;

      case 43:
      //3. REGISTRO DE EXPLOSIVOS
        wg = wgTxtExplosivos(responsive);
        validarForm = true;
        mostrarFoto = true;
        break;

      case 44:
      //4. APOYO A UNIDADES POLICIALES
        wg = wgTxtApoyoUnidadesPoliciales(responsive);
        validarForm = true;
        break;

    /************************CARCK - UMO - UER*************************************/
      case 49:
      //AGLOMERACIONES
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      case 50:
      //NUMÉRICO DE ACÉMILAS
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      case 51:
      //NUMÉRICO DE CANES
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      case 52:
      //PERSONAL ESTÁTICO
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      case 53:
      //PERSONAL MÓVIL
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      case 54:
      //INICIA SERVICIO
        wg = wgTxtHora(responsive);
        validarForm = true;
        break;

      case 55:
      //FINALIZA SERVICIO
        wg = wgTxtHora(responsive);
        validarForm = true;
        break;

      default:
        print('idDgoNovedadesElect');
        validarForm = false;
        mostrarFoto = false;
        wg = Container();
    }


 

      completeValidarForm(validarForm);
      completeRegistrarDatosPersona(registrarDatosPersona);

    

    return wg;
  }







}

 */
