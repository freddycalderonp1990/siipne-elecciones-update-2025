part of '../../pages.dart';

class MenuRecElecJefePage
    extends GetView<MenuRecElecJefeController> {
  const MenuRecElecJefePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      title: "${controller.recintosElectoralesAbiertos.nomRecintoElec}",
      showGps: true,
      contenido:  getContenido(),
      peticionServer: controller.peticionServerState,
    );
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();

    print("foto ${controller.user.foto}");

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imgPerfilRedonda(
            size: 20,
            img: controller.user.foto,
          ),
          TextSombrasWidget(
            colorSombra: Colors.black,
            colorTexto: Colors.white ,
            title: "${controller.recintosElectoralesAbiertos.descProcElecc}",
          ),
          DesingTextNameUser(

              sexo: controller.user.sexo, text: controller.user.nombres),
          _getMenuJefe(responsive),
          SizedBox(
            height: responsive.altoP(1),
          ),
          BtnIconWidget(
            icon: Icons.exit_to_app,
            titulo: "SALIR",
            onPressed: () => controller.cerrarSession(),
          )
        ],
      ),
    );
  }

  _getMenuJefe(ResponsiveUtil responsive) {
    double separacionBtnMenu = 1.5;
    return Column(
      children: [
        _wgCodigoRecinto(responsive),
        Row(
          children: [
            Flexible(
              child: BtnMenuWidget(
                  horizontal: true,
                  img: SiipneImages.icon_agregar_personal,
                  title: SiipneStrings.recElecAgregarpersonal,
                  onTap: () {
                    Get.toNamed(SiipneRoutes.ADD_PERSONAL, arguments: {
                      "recintosElectoralesAbiertos":
                          controller.recintosElectoralesAbiertos
                    });
                  }),
            ),
            SizedBox(
              width: responsive.anchoP(2),
            ),
            Flexible(
              child: BtnMenuWidget(
                  horizontal: true,
                  img: SiipneImages.icon_registrar_novedades_rec_elec,
                  title: SiipneStrings.recElecRegistrarNovedades,
                  onTap: () {
                    Get.toNamed(SiipneRoutes.ADD_NOVEDADES, arguments: {
                      "recintosElectoralesAbiertos":
                          controller.recintosElectoralesAbiertos
                    });
                  }),
            )
          ],
        ),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),
        Row(
          children: [
            Flexible(
              child: BtnMenuWidget(
                  horizontal: true,
                  img: SiipneImages.icon_finalizar_rec_elec,
                  title: "FINALIZAR RECINTO",
                  onTap: () {
                    _dialogoFinalizarRecinto(
                      nameRecinto:
                          "${controller.recintosElectoralesAbiertos.nomRecintoElec}",
                    );
                  }),
            ),
            SizedBox(
              width: responsive.anchoP(2),
            ),
            Flexible(
              child: BtnMenuWidget(
                  horizontal: true,
                  img: SiipneImages.icon_eliminar_rec_elec,
                  title: "ELIMINAR CÓDIGO",
                  onTap: () {
                    String msj =
                        "Si abrió por error el Operativo se recomienda eliminarlo.  "
                        "\n\nRecuerde todo será registrado para verificar el correcto uso del aplicativo."
                        "\n\n¿Esta seguro que desea eliminar el Operativo.?";
                    String title="ELIMINAR CÓDIGO ${controller.recintosElectoralesAbiertos.idDgoCreaOpReci}";

                    DialogosAwesome.getIconPolicia(title: title, descripcion: msj, btnOkOnPress: (){

                      Get.back();
                      DialogosAwesome.getDesingChangePass(
                        onPressed: (){
                          Get.back();
                          controller.eliminarCodigoRecinto();
                        },
                          formKey: controller.formKeyPass,
                          controllerPass:controller. controllerPass,
                          title: title,
                          descripcion: "Para eliminar el código ${controller.recintosElectoralesAbiertos.idDgoCreaOpReci}, ingrese su clave de seguridad"
                      );

                    });

                  }),
            )
          ],
        ),
      ],
    );
  }

  _wgCodigoRecinto(ResponsiveUtil responsive) {
    double separacionBtnMenu = 1.5;
    return Column(
      children: [
        TextSombrasWidget(
          colorSombra: Colors.black,
          colorTexto: Colors.white,
          title: "CÓDIGO:",
          size: responsive.anchoP(4.5),
        ),
        BtnIconWidget(
          sizeIcon: AppConfig.tamIcons + 1,
          sizeTexto: AppConfig.tamTexto + 1,
          icon: Icons.numbers,
          titulo: "${controller.recintosElectoralesAbiertos.idDgoCreaOpReci}",
          onPressed: () {},
        ),
        SizedBox(
          height: responsive.altoP(0.5),
        ),
        TextSombrasWidget(
          colorSombra: Colors.black,
          colorTexto: Colors.white,
          title: "${controller.recintosElectoralesAbiertos.descripcion}",
          size: responsive.diagonalP(AppConfig.tamTextoTitulo),
        ),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),
      ],
    );
  }

  _dialogoFinalizarRecinto({required String nameRecinto}) {
    String title="FINALIZAR RECINTO";
    DialogosAwesome.getIconPolicia(
        title: title,
        descripcion:
            "¿Esta seguro que desea finalizar el Recinto?"
                "\nNOMBRE:${nameRecinto}",
        btnOkOnPress: () {
          Get.back();

          DialogosAwesome.getDesingChangePass(

              onPressed: (){
                Get.back();
                controller.finalizarRecinto();
              },
              formKey: controller.formKeyPass,
              controllerPass:controller. controllerPass,
              title: title,
              descripcion: "Para Finalizar el recinto con el código ${controller.recintosElectoralesAbiertos.idDgoCreaOpReci}, ingrese su clave de seguridad"
          );




        });
  }
}
