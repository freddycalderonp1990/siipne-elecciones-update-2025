part of '../pages.dart';

class MenuRecintosElectoralesPage
    extends GetView<MenuRecintosElectoralesController> {
  const MenuRecintosElectoralesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      title: "${controller.recintosElectoralesAbiertos.nomRecintoElec}",
      contenido: GpsAccessScreen(contenido:getContenido()),
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
            title:"${controller.recintosElectoralesAbiertos.descProcElecc}" ,

          ),
          DesingTextNameUser(
              sexo:controller.user.sexo ,
              text:  controller.user.nombres),

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
                    Get.toNamed(SiipneRoutes.ADD_NOVEDADES,arguments:{"recintosElectoralesAbiertos":controller. recintosElectoralesAbiertos});

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
                  title: "FINALIZAR RECINTO",
                  onTap: () {
                    _dialogoFinalizarRecinto(
                      nameRecinto: "${controller.recintosElectoralesAbiertos.nomRecintoElec}",
                      totalPersonal: 10,
                      totalNovedades: 5,

                    );
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
                    String msj="Si abrió por error el Operativo se recomienda eliminarlo.  "
                    "\n\nRecuerde todo será registrado para verificar el correcto uso del aplicativo."
                    "\n\n¿Esta seguro que desea eliminar el Operativo.?";

                    DialogosAwesome.getWarningSiNo(descripcion: msj,
                        btnCancelOnPress: (){},

                        btnOkOnPress: (){
                      controller.eliminarCodigoRecinto();

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
          sizeIcon: AppConfig.tamIcons+1,
          sizeTexto: AppConfig.tamTexto+1,

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


  _dialogoFinalizarRecinto({required int totalPersonal, required int totalNovedades,required String nameRecinto}){


    AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: Get.context!,
      animType: AnimType.scale,
      headerAnimationLoop: false,
      btnCancelText: "No",
      btnCancelIcon: Icons.cancel_rounded,
      btnOkIcon: Icons.check_circle,
      btnOkColor: AppColors.colorAzul,
      btnOkText: "Si",
      body: Column(children: [
      TituloTextWidget(title: "Finalizar Recinto"),
        SizedBox(height: 5,),
        TituloDetalleTextWidget(
          title: "Total Personal:",
          detalle: "${totalPersonal}",
        ),
        TituloDetalleTextWidget(
          title: "Total Novedades:",
          detalle: "${totalNovedades}",
        ),
        SizedBox(height: 5,),
        DetalleTextWidget(
          todoElAncho: true,
            detalle: "¿Esta seguro que desea finalizar el Recinto\n${nameRecinto}?")

      ],),



        btnCancelOnPress:(){},
      //this is ignored
      btnOkOnPress: () {},
    ).show();
  }
}
