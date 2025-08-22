part of '../pages.dart';

class CensistaPage extends GetView<CensistaController> {
  const CensistaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WorkAreaPageCensoWidget(
        onPressBtnAtras: () {
          if (controller.showBtnValidarFoto.value) {
            controller.showBtnValidarFoto.value = false;
          } else {
            Get.back();
          }
        },
        showGps: true,
        mostrarBtnAtras: true,
        title:
            controller.showBtnValidarFoto.value
                ? "Registrar Fotografia"
                : "Censista",
        contenido: Column(
          children: [
            Expanded(child: getContenido()),

            // 👇 Este Obx detecta cuando ya se cargó la imagen y hace scroll
            Obx(() {
              if (controller.mGaleryCameraModel.value != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (controller.scrollController.hasClients) {
                    controller.scrollController.animateTo(
                      controller.scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                    );
                  }
                });
              }
              return SizedBox.shrink();
            }),
          ],
        ),
        peticionServer: controller.peticionServerState,
      ),
    );
  }

  Widget getContenido() {
    return Obx(
      () =>
          controller.showBtnValidarFoto.value
              ? desingValidar()
              : SingleChildScrollView(
                controller: controller.scrollController, // ✅ Scroll global
                child: getContenidoCensado(),
              ),
    );
  }

  Widget getContenidoCensado() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        wgConsultarRecinto(),
        SizedBox(height: 10),
        wgDatosCenso(),
      ],
    );
  }

  Widget wgDatosCenso() {
    final responsive = ResponsiveUtil();

    Widget wg = Column(
      children: [
        Obx(
          () =>
              controller.dataCensado.value.idDgpPerCenso > 0
                  ? ContenedorDesingWidget(
                    child: ExpansionTile(
                      collapsedIconColor: AppColors.colorAzul,
                      iconColor: AppColors.colorAzul,
                      initiallyExpanded: true,
                      title: Text(
                        'DATOS',
                        style: TextStyle(
                          color: AppColors.colorAzul,
                          fontSize: responsive.diagonalP(AppConfig.tamTexto),
                        ),
                      ),
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Column(
                            children: [
                              TituloDetalleTextWidget(
                                title: "Proceso: ",
                                detalle:
                                    controller.dataCensado.value.descProceso,
                              ),
                              TituloDetalleTextWidget(
                                title: "Recinto: ",
                                detalle:
                                    controller.dataCensado.value.descRecinto,
                              ),
                              TituloDetalleTextWidget(
                                title: "Mesa: ",
                                detalle: controller.dataCensado.value.descMesa,
                              ),
                              TituloDetalleTextWidget(
                                title: "Censado: ",
                                detalle:
                                    "${controller.dataCensado.value.siglas} ${controller.dataCensado.value.apenom}",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  : Container(),
        ),
        wgFoto(),
        SizedBox(height: responsive.altoP(2)),
        btnValidar(),
      ],
    );

    return Obx(
      () => controller.dataCensado.value.idDgpPerCenso > 0 ? wg : Container(),
    );
  }

  Widget wgConsultarRecinto() {
    final responsive = ResponsiveUtil();
    return ContenedorDesingWidget(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          margin: EdgeInsets.only(left: 0.0, right: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: responsive.altoP(1)),
              Expanded(
                child: Form(
                  key: controller.formKey,
                  child: ImputTextWidget(
                    keyboardType: TextInputType.number,
                    controller: controller.controllerCodigoCenso,
                    icono: Icon(
                      Icons.assignment_sharp,
                      color: AppColors.colorIcons,
                      size: responsive.diagonalP(AppConfig.tamIcons),
                    ),
                    label: SiipneStrings.codigo,
                    fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
                    validar: validateCodigoRecinto,
                  ),
                ),
              ),
              SizedBox(width: responsive.altoP(1)),
              BtnIconWidget(
                onPressed: () => controller.consultarDatosSegunCodigo(),
                icon: Icons.search,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validateCodigoRecinto(String? value) {
    String msj = "Código del censo no valido";
    if (value != null && value.length > 0) {
      int? codigoRecinto = int.tryParse(value);
      if (codigoRecinto == null) {
        print("El valor ingresado no es un número entero válido.");
        return msj;
      }
      return null;
    }
    return msj;
  }

  Widget wgFoto() {
    final responsive = ResponsiveUtil();

    return ContenedorDesingWidget(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Obx(
            () => TituloTextWidget(
              title:
                  controller.mGaleryCameraModel.value == null
                      ? "Registre la Fotografía"
                      : "Cambiar la Fotografía",
            ),
          ),
          SizedBox(height: responsive.altoP(1)),
          Material(
            child: InkWell(
              onTap: () async {
                if (controller.dataCensado.value.estadoCenso != "iniciado") {
                  DialogosAwesome.getInformation(
                    descripcion:
                        "Para continuar, asegúrese de que se  haya completado el registro del formulario en el sistema SIIPNE 3W."
                        "\nSolo después podrá registrar la fotografía.",
                  );
                  controller.dataCensado.value = DataCensado.empty();
                  controller.dataCensadoList.clear();
                  return;
                }

                controller
                    .mGaleryCameraModel
                    .value = await PhotoHelper.getDesingPictureGaleryOrCamera(
                  onlyCamera: true,
                  initPeticion: (value) {
                    controller.peticionServerState(value);
                  },
                  titleImg: "",
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  AppImages.icon_camara,
                  width: responsive.altoP(6.0),
                ),
              ),
            ),
          ),
          Obx(
            () =>
                controller.mGaleryCameraModel.value == null
                    ? SizedBox.shrink()
                    : ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image.file(
                        controller.mGaleryCameraModel.value!.imageFile,
                        fit: BoxFit.fill,
                        height: responsive.altoP(27.0),
                        width: responsive.altoP(31.0),
                      ),
                    ),
          ),
          SizedBox(height: responsive.altoP(1)),
        ],
      ),
    );
  }

  Widget btnRegistrar() {
    return Obx(
      () =>
          controller.mGaleryCameraModel.value != null
              ? BtnIconWidget(
                icon: Icons.save,
                titulo: "GUARDAR",
                onPressed: () {
                  DialogosAwesome.getWarningSiNo(
                    title: "¿Está seguro que desea finalizar el proceso de censo?",
                    descripcion:
                        "Al confirmar, se guardará la foto registrada y el censo quedará concluido.",
                    btnOkOnPress: () {
                      controller.SaveCensusPersonPhotoUseCaseServer();
                    },

                  );
                },
              )
              : SizedBox.shrink(),
    );
  }

  Widget btnValidar() {
    return Obx(
      () =>
          controller.mGaleryCameraModel.value != null
              ? BtnIconWidget(
                icon: Icons.save,
                titulo: "SIGUIENTE",
                onPressed: () {
                  controller.validarFoto();
                },
              )
              : SizedBox.shrink(),
    );
  }

  Widget desingValidar() {
    final responsive = ResponsiveUtil();

    final Uint8List? imgMemory = PhotoHelper.convertStringToUint8List(
      controller.dataFotoDgp.value.foto,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextSombrasWidget(
                      title: "FOTO CAMARA",
                      size: responsive.diagonalP(
                        AppConfig.tamTextoTitulo + 0.5,
                      ),

                    ),
                    Expanded(
                      child: ClipRRect(
                        child: Image.file(
                          controller.mGaleryCameraModel.value!.imageFile,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Column(
                  children: [
                    TextSombrasWidget(
                      title: "FOTO DEL SIIPNE",
                      size: responsive.diagonalP(
                        AppConfig.tamTextoTitulo + 0.5,
                      ),



                    ),
                    Expanded(
                      child:
                          imgMemory != null
                              ? ClipRRect(
                                child: Image.memory(
                                  imgMemory,
                                  fit: BoxFit.fill,
                                ),
                              )
                              : Container(
                                color: AppColors.colorAzul,
                                child: Image.asset(AppImages.iconNoImg),
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: responsive.altoP(2)),
        btnRegistrar(),
      ],
    );
  }
}
