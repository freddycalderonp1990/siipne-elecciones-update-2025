part of '../pages.dart';

class ValidateRecintoPage extends GetView<ValidateRecintoController> {
  const ValidateRecintoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget wg= Obx(
      () => DesingMapaRecinto(
        showNoEncuentyroMiRecinto: controller.selectProcesosOperativo.permitirAgregarRecintos,

    listRecintosElectorales: controller.listRecintosElectorales,
        onPressedSave: () {
          DialogosDesingWidget.getDialogoX(
              contenido:

                  Column(children: [

                    WgTxtTelefono(
                      controllerTelefono: controller.controllerTelefono,
                      formKey: controller.formKey,
                    ),

                    BtnIconWidget(
                      icon: Icons.save,
                      titulo: "GUARDAR",
                      onPressed: () {
                        Get.back();
                        controller.updateRecintoCoordinates();

                      },
                    )
                  ],)



          );




        },
        ubicacion: controller.ubicacion.value,
        mapController: controller.mapController,
        tapComplete: (value) {
          controller.ubicacion.value = value;
          controller.mapController.move(value, 18);
        },
        ontapMyUbicacion: () async {
          await controller.getUbicacionActual();
        },

        onRecintoSeleccionado: (recinto) {
          print("Seleccionado: ${recinto.nomRecintoElecOnly}");

            controller.selectRecintosElectoral.value = recinto;



        },

        cargando: controller.peticionServerState.value,
      ),
    );

    return      GpsAccessScreen(
      useSafeArea: true,
      contenido: wg,
      namApps: NamApps.Elecciones,
    );
  }


}
