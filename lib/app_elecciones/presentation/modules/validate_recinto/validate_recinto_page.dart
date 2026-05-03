part of '../pages.dart';

class ValidateRecintoPage extends GetView<ValidateRecintoController> {
  const ValidateRecintoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DesingMapaRecinto(

    listRecintosElectorales: controller.listRecintosElectorales,
        onPressedSave: () {
          controller.updateRecintoCoordinates();
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
  }


}
