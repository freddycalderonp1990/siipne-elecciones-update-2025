part of '../../pages.dart';

class ValidateMesaPage extends GetView<ValidateMesaController> {
  const ValidateMesaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DesingMapa(
        ubicacion: controller.ubicacion.value,
        mapController: controller.mapController,
        tapComplete: (value){
          controller.ubicacion.value=value;
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
