part of '../pages.dart';

class ValidateRecintoPage extends GetView<ValidateRecintoController> {
  const ValidateRecintoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DesingMapaRecinto(

    listRecintosElectorales: controller.listRecintosElectorales,
        onPressedSave: () {
          controller.updateMesaCoordinates();
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

        cargando: controller.peticionServerState.value,
      ),
    );
  }


}
