part of '../../pages.dart';

class MenuRecElecIntegrantePage
    extends GetView<MenuRecElecIntegranteController> {
  const MenuRecElecIntegrantePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      title: "${controller.recintosElectoralesAbiertos.nomRecintoElec}",
      showGps: true,
      contenido: getContenido(),
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
            colorTexto: Colors.white,
            title: "${controller.recintosElectoralesAbiertos.descProcElecc}",
          ),
          DesingTextNameUser(
              sexo: controller.user.sexo, text: controller.user.nombres),
          _getMenu(responsive),
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

  _getMenu(ResponsiveUtil responsive) {
    double separacionBtnMenu = 1.5;
    return Column(
      children: [
        _wgCodigoRecinto(responsive),
        Row(
          children: [
            Flexible(
              child: BtnMenuWidget(
                  horizontal: true,

                  img: SiipneImages.icon_registrar_novedades_rec_elec,
                  title: SiipneStrings.recElecRegistrarNovedades,
                  onTap: () {
                    Get.toNamed(SiipneRoutes.ADD_NOVEDADES, arguments: {
                      "recintosElectoralesAbiertos":
                          controller.recintosElectoralesAbiertos,
                      "shorReporte": false
                    });
                  }),
            ),
            SizedBox(
              width: responsive.anchoP(2),
            ),
            Flexible(
              child: BtnMenuWidget(
                  horizontal: true,
                  img: SiipneImages.icon_abandonar_rec_elec,
                  title: "ABANDONAR CÓDIGO",
                  onTap: () {
                    DialogosAwesome.getIconPolicia(
                        title: "ABANDONAR CÓDIGO",
                        descripcion:
                            "¿Esta seguro que desea abandonar el Operativo.?\n\n"
                                "Si abandona, no será considerado para el justificativo ante el CNE."
                                "\nDeberá anexarse a un nuevo código y no abandonar, ya que esta acción es automática al finalizar el proceso electoral"
                                "\n\n¿ESTÁ SEGURO?",

                        btnOkOnPress: () {
                          Get.back();



                          Get.back();
                          DialogosAwesome.getDesingChangePass(
                              onPressed: (){
                                Get.back();
                                controller.removePersonalOperativo();
                              },
                              formKey: controller.formKeyPass,
                              controllerPass:controller. controllerPass,
                              title: "ABANDONAR CÓDIGO",
                              descripcion: "Para abandonar el código ${controller.recintosElectoralesAbiertos.idDgoCreaOpReci}, ingrese su clave de seguridad"
                          );



                        });
                  }),
            ),
          ],
        ),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
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


}
