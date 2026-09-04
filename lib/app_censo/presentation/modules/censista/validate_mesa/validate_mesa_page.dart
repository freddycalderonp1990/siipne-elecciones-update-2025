part of '../../pages.dart';

class ValidateMesaPage extends GetView<ValidateMesaController> {
  const ValidateMesaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DesingMapa(
        onPressedSave: () {
          String msj =
              "¿Está seguro/a de registrar estas coordenadas?"
              "\n\nVerifique que se encuentre exactamente en el lugar donde se realizará el censo, ya que estas coordenadas serán utilizadas para validar su proximidad."
              "\nEn caso de presentar inconvenientes, comuníquese con el administrador de la DNATH.";
          DialogosAwesome.getWarningSiNo(
            title: "Guardar",
            descripcion: msj,
            btnOkOnPress: () {
              controller.updateMesaCoordinates();
            },
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

        cargando: controller.peticionServerState.value,
      ),
    );
  }
}
