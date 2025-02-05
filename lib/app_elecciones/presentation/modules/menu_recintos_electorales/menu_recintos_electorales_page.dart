part of '../pages.dart';

class MenuRecintosElectoralesPage
    extends GetView<MenuRecintosElectoralesController> {
  const MenuRecintosElectoralesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      title: "${controller.recintosElectoralesAbiertos.descProcElecc}",
      contenido: getContenido(),
      peticionServer: controller.peticionServerState,
    );
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();

    String Bienvenido =
        controller.user.sexo == 'HOMBRE' ? "BIENVENIDO: " : "BIENVENIDA: ";

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
            title: "${controller.recintosElectoralesAbiertos.nomRecintoElec}",

          ),
          TextSombrasWidget(
            title: Bienvenido + controller.user.nombres,
          ),
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
                  horizontal: false,
                  img: SiipneImages.icon_agregar_personal,
                  title: SiipneStrings.recElecAgregarpersonal,
                  onTap: () {
                   Get.toNamed(SiipneRoutes.ADD_PERSONAL,arguments:{"recintosElectoralesAbiertos":controller. recintosElectoralesAbiertos});
                  }),
            ),
            SizedBox(
              width: responsive.anchoP(2),
            ),
            Flexible(
              child: BtnMenuWidget(
                  img: SiipneImages.icon_registrar_novedades_rec_elec,
                  title: SiipneStrings.recElecRegistrarNovedades,
                  onTap: () {
                    /* _consultaRecintoAbierto(_UserProvider.getUser.idGenPersona,
                  'novedades', 'registrar Novedades.', responsive);*/
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
                  img: SiipneImages.icon_finalizar_rec_elec,
                  title: "CERRAR RECINTO",
                  onTap: () {
                    //_getReporteFinal(responsive)
                  }),
            ),
            SizedBox(
              width: responsive.anchoP(2),
            ),
            Flexible(
              child: BtnMenuWidget(
                  img: SiipneImages.icon_eliminar_rec_elec,
                  title: "ELIMINAR CÓDIGO",
                  onTap: () {
                    /*_consultaRecintoAbierto(
                  _UserProvider.getUser.idGenPersona,
                  'eliminar',
                  'eliminar el Operativo. El Operativo Finalizará Automaticamente',
                  responsive);*/
                  }),
            )
          ],
        )
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
          size: responsive.anchoP(4),
        ),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),
      ],
    );
  }
}
