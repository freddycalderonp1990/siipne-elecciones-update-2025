part of '../pages.dart';

class ValidateRecintoPage extends GetView<ValidateRecintoController> {
  const ValidateRecintoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DesingMapaRecinto(

        onPressedSave: () {
          String msj =
              "¿Está seguro/a de registrar estas coordenadas?"
              "\n\nVerifique que se encuentre exactamente en el lugar del recinto electoral, ya que estas coordenadas serán utilizadas para las registro de las elecciones."
              "\nEn caso de presentar inconvenientes, comuníquese con el administrador.";
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

        cargando: controller.peticionServerState.value, listRecintosElectorales: controller.listRecintosElectorales,
      ),
    );
  }


}
