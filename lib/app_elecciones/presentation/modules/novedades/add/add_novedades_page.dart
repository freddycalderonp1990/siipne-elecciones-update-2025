part of '../../pages.dart';

class AddNovedadesPage extends GetView<AddNovedadesController> {
  const AddNovedadesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      mostrarBtnAtras: true,
      title: "REGISTRAR NOVEDADES",
      contenido: Container(child: GpsAccessScreen(contenido: getContenido())),
      peticionServer: controller.peticionServerState,
    );
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();

    String Bienvenido =
        controller.user.sexo == 'HOMBRE' ? "BIENVENIDO: " : "BIENVENIDA: ";

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BtnIconWidget(
            icon: Icons.assignment_sharp,
            titulo: "VER NOVEDADES",
            onPressed: () => controller.goToPageReporteNovedades(),
          ),
          getCombos(),
          SizedBox(
            height: responsive.altoP(0.4),
          ),



          Obx(() => wgCajasTexto(
              controller.selectTipoNovedad.value.descripcion)),

          Obx(() => wgCajasTextoNovedades(
              controller.selectNovedad.value.idDgoNovedadesElect, responsive)),
          Obx(() {
            return controller.mostrarFoto.value
                ? wgFoto(responsive)
                : Container();
          }),
          SizedBox(
            height: responsive.altoP(3.5),
          ),
          getBtnGuardar(),
        ],
      ),
    );
  }

  Widget wgFoto(ResponsiveUtil responsive) {
    Widget wgSolicitarFoto = Column(
      children: [
        controller.mGaleryCameraModel.value == null
            ? TituloTextWidget(
                title: "Registre una Imagen",
              )
            : TituloTextWidget(
                title: "Cambiar la Imagen",
              ),
        SizedBox(
          height: responsive.altoP(1),
        ),
        Material(
            child: InkWell(
          onTap: () async {
            controller.mGaleryCameraModel.value =
                await PhotoHelper.getDesingPictureGaleryOrCamera(
                    titleImg:
                        "ImgRecElectNovedades_id_${controller.selectNovedad.value.idDgoNovedadesElect}");
          },
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(SiipneImages.icon_camara,
                  width: responsive.altoP(6.0)),
            ),
          ),
        )),
        controller.mGaleryCameraModel.value == null
            ? Container()
            : ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.file(
                  controller.mGaleryCameraModel.value!.imageFile,
                  fit: BoxFit.fill,
                  height: responsive.altoP(30.0),
                  width: responsive.altoP(34.0),
                )),
        SizedBox(
          height: responsive.altoP(1),
        ),
      ],
    );

    Widget wg = wgSolicitarFoto;

    return ContenedorDesingWidget(margin: EdgeInsets.only(top: 10), child: wg);
  }

  Widget getCombos() {
    final responsive = ResponsiveUtil();
    return Column(
      children: [
        SizedBox(
          height: responsive.altoP(0.4),
        ),
        getComboTipoNovedad(),
        SizedBox(
          height: responsive.altoP(0.4),
        ),
        getComboNovedades(),
        SizedBox(
          height: responsive.altoP(0.4),
        ),

        getComboDelito(),
      ],
    );
  }

  Widget getComboTipoNovedad() {
    return ContenedorDesingWidget(
        paddin: EdgeInsets.all(5),
        child: ComboBusqueda(
          selectValue: controller.selectTipoNovedad.value,
          icon: Icons.select_all_sharp,
          showClearButton: false,
          datos: controller.listTipoNovedades,
          displayField: (item) =>
              item.descripcion, // Aquí decides mostrar "nombres"
          searchHint: "Tipo Novedad",
          complete: (value) {
            controller.selectTipoNovedad.value = NovedadesElectorale.empty();
            controller.selectNovedad.value = NovedadesElectorale.empty();
            controller.selectDelito.value = NovedadesElectorale.empty();

            if (value != null) {
              controller.selectTipoNovedad.value = value;

              controller.getNovedadesHijas(value.idDgoNovedadesElect);
              return;
            }
          },
          textSeleccioneUndato: "Seleccione un Tipo de Novedad",
        ));
  }

  Widget getComboNovedades() {
    return Obx(() => controller.selectTipoNovedad.value.idDgoNovedadesElect > 0
        ? ContenedorDesingWidget(
            paddin: EdgeInsets.all(5),
            child: ComboBusqueda(
              selectValue: controller.selectNovedad.value,
              icon: Icons.select_all_sharp,
              showClearButton: false,
              datos: controller.listNovedades,
              displayField: (item) =>
                  item.descripcion, // Aquí decides mostrar "nombres"
              searchHint: "Novedad",
              complete: (value) {
                controller.selectNovedad.value = NovedadesElectorale.empty();
                controller.selectDelito.value = NovedadesElectorale.empty();

                controller.mostrarBtnGuardar(false);
                if (value != null) {
                  controller.selectNovedad.value = value;


                  if(controller.idNovedadBoletaCaptura==value.idDgoNovedadesElect){
                    controller.getNovedadesDelito(value.idDgoNovedadesElect);
                  }
                  else if(controller.selectNovedad.value.idDgoNovedadesElect>0){
                    controller.mostrarBtnGuardar(true);
                  }
                  return;
                }
              },
              textSeleccioneUndato: "Seleccione una Novedad",
            ))
        : Container());
  }


  Widget getComboDelito() {

    return Obx(() => controller.selectNovedad.value.idDgoNovedadesElect > 0 && controller.idNovedadBoletaCaptura==controller.selectNovedad.value.idDgoNovedadesElect
        ? ContenedorDesingWidget(
        paddin: EdgeInsets.all(5),
        child: ComboBusqueda(
          selectValue: controller.selectDelito.value,
          icon: Icons.select_all_sharp,
          showClearButton: false,
          datos: controller.listDelito,
          displayField: (item) =>
          item.descripcion, // Aquí decides mostrar "nombres"
          searchHint: "Delito",
          complete: (value) {
            controller.selectDelito.value = NovedadesElectorale.empty();
            controller.mostrarBtnGuardar(false);
            if (value != null) {
              controller.selectDelito.value = value;
              if(controller.selectDelito.value.idDgoNovedadesElect>0){
                controller.mostrarBtnGuardar(true);
              }
              return;
            }
          },
          textSeleccioneUndato: "Seleccione el Delito",
        ))
        : Container());
  }



  Widget wgCajasTexto(String novedadesPadres) {
    Widget wg = Container();
    final responsive = ResponsiveUtil();

    bool registrarDatosPersona=true;
    bool mostrarFoto=false;
    bool validarForm=false;


      switch (novedadesPadres.trim().toUpperCase()) {
        case "NOVEDADES":

          break;

        case "DELITOS":
          validarForm = true;
          if(controller.selectNovedad.value.idDgoNovedadesElect>0) {
            wg = wgTxtCedula(responsive: responsive);
          }
          break;

        case "DETENIDOS":
          validarForm = true;
          if(controller.selectNovedad.value.idDgoNovedadesElect>0) {
            wg = wgTxtCedulaBoleta(responsive);
          }
          break;

        case "CITACIONES":
          validarForm = true;
          wg = wgTxtCedulaCitacion(responsive);
          break;

        case "VOTO EN CASA":
          registrarDatosPersona = false;
          validarForm = true;
          wg = wgTxtObservacion(responsive: responsive);
          break;

        case "NOV PPL":
          registrarDatosPersona = false;
          validarForm = true;
          wg = wgTxtObservacion(responsive: responsive);
          break;
        case "UMO":
          //controller.mostrarFoto = true;
          //wg = wgTxtCedulaCitacion(responsive);
          break;

        default:
          wg = Container();
      }


    WidgetsBinding.instance.addPostFrameCallback((_) {

      controller.registrarDatosPersona = registrarDatosPersona;
      controller.mostrarFoto.value = mostrarFoto;
      controller.validarForm = validarForm;

    });


    if (wg is Container) {
      return wg;
    } else {
      return ContenedorDesingWidget(paddin: EdgeInsets.all(5), child: wg);
    }

  }

  Widget wgCajasTextoNovedades(
      int idDgoNovedadesElect, ResponsiveUtil responsive) {
    Widget wg = Container();
    print("suiii");
    print(idDgoNovedadesElect);
    bool validarForm = false;
    bool mostrarFoto = false;
    bool registrarDatosPersona = false;
    switch (idDgoNovedadesElect) {
      case 17:
        //1. RECINTOS ELECTORALES INSTALADOS
        wg = Container();
        break;

      case 18:
        //2. RECINTOS ELECTORALES NO INSTALADOS
        wg = Container();
        break;

      case 19:
        //3. RECINTO ELECTORAL INSTALADO CON RETARDO POR DIFERENTES CAUSAS

        wg = wgTxtHora(responsive);
        validarForm = true;
        break;

      case 20:
        //4. RECINTOS ELECTORALES SUSPENDIDO POR DIFERENTES CAUSAS
        wg = wgTxtMotivo(responsive);
        validarForm = true;
        mostrarFoto = true;
        break;

      case 21:
        //5. AGRESIONES A SERVIDORES POLICIALES
        wg = wgTxtCedula(responsive: responsive, title: SiipneStrings.cedulaSP);
        validarForm = true;
        mostrarFoto = true;
        registrarDatosPersona=true;
        break;

      case 22:
        //6. PRESENCIA DE MANIFESTANTES / CONCENTRACIONES / MARCHAS
        wg = Column(
          children: [
            wgTxtNumeroManifestantes(responsive),
            SizedBox(
              height: responsive.altoP(1),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.green.withOpacity(0.8),
                      title: "1-50"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.yellow.withOpacity(0.8),
                      title: "51-200"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.orange.withOpacity(0.8),
                      title: "201-500"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.red.withOpacity(0.8),
                      title: "501-Más"),
                ],
              ),
            )
          ],
        );
        validarForm = true;
        mostrarFoto = true;
        break;

      case 23:
        //7. QUEMA DE URNAS / PAPELETAS
        validarForm = true;
        mostrarFoto = true;
        wg = Column(
          children: [
            wgTxtNumeroQuemaUrnas(responsive),
            SizedBox(
              height: responsive.altoP(1),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.green.withOpacity(0.8),
                      title: "1-50"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.yellow.withOpacity(0.8),
                      title: "51-200"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.orange.withOpacity(0.8),
                      title: "201-500"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.red.withOpacity(0.8),
                      title: "501-Más"),
                ],
              ),
            )
          ],
        );
        break;

      case 28:
        //8. TOMA DE RECINTOS / DELEGACIONES / BODEGAS / INSTALACIONES DEL CNE
        validarForm = true;
        mostrarFoto = true;
        wg = Column(
          children: [
            wgTxtNumeroTomaRecintos(responsive),
            SizedBox(
              height: responsive.altoP(1),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.green.withOpacity(0.8),
                      title: "1-50"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.yellow.withOpacity(0.8),
                      title: "51-200"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.orange.withOpacity(0.8),
                      title: "201-500"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.red.withOpacity(0.8),
                      title: "501-Más"),
                ],
              ),
            )
          ],
        );
        break;

      case 29:
        //9. PRESENCIA DE VENTAS AMBULANTES
        wg = Container();
        mostrarFoto = true;
        break;

      case 30:
        //10. ATENCIÓN MÉDICA POR DIFERENTES CAUSAS
        validarForm = true;
        mostrarFoto = true;
        registrarDatosPersona=true;
        wg = wgTxtCedulaTelefono(responsive: responsive);
        break;

      case 31:
        //11. SERVIDORES POLICIALES INFECTADOS (SOSPECHA/POSITIVO)

        validarForm = true;
        wg = wgTxtCedulaTelefono(
            responsive: responsive, title: SiipneStrings.cedulaSP);
        break;

      case 32:
        //NUMÉRICO DE ACÉMILAS
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      /*********************** UMO ***************************************/
      case 33:
        //1. NUMERICO DE PERSONAL
        wg = wgTxtNumericoPersonal(responsive);
        validarForm = true;
        validarForm = true;
        break;

      case 34:
        //2. PLANTONES
        wg = wgorganizacionDirigenteCantidad(responsive);
        validarForm = true;
        validarForm = true;
        break;

      case 35:
        //3. MARCHAS
        wg = wgorganizacionDirigenteCantidad(responsive);
        validarForm = true;
        validarForm = true;
        break;

      case 36:
        //4. CIERRE DE VIAS
        wg = wgorganizacionDirigenteCantidad(responsive);
        validarForm = true;
        validarForm = true;
        break;

      case 37:
        //5. TOMA DE ENTIDADES
        wg = wgorganizacionDirigenteCantidad(responsive);
        validarForm = true;
        validarForm = true;
        break;

      /************************AEREOPOLCIAL*************************************/
      case 45:
        //1. DESPLAZAMIENTO DE AUTORIDADES
        wg = wgTxtDesplazamientosAutoridades(responsive);
        validarForm = true;
        break;

      case 46:
        //2. DESPLAZAMIENTO DE SERVIDORES PÚBLICOS
        wg = wgTxtDesplazamientosAutoridades(responsive);
        validarForm = true;
        break;

      case 47:
        //3. APOYO AÉREO A MEDIOS DE COMUNICACIÓN
        wg = wgTxtApoyoMediosComunicacion(responsive);
        validarForm = true;
        break;
      /************************GOE - GIR*************************************/
      case 41:
        //1. SEGURIDAD DE PERSONAS IMPORTANTES
        wg = wgTxtSeguridadPersonasImportantes(responsive);
        validarForm = true;
        break;

      case 42:
        //2. SEGURIDAD DE INSTALACIONES
        wg = wgTxtSeguridadInstalaciones(responsive);
        validarForm = true;
        mostrarFoto = true;
        break;

      case 43:
        //3. REGISTRO DE EXPLOSIVOS
        wg = wgTxtExplosivos(responsive);
        validarForm = true;
        mostrarFoto = true;
        break;

      case 44:
        //4. APOYO A UNIDADES POLICIALES
        wg = wgTxtApoyoUnidadesPoliciales(responsive);
        validarForm = true;
        break;

      /************************CARCK - UMO - UER*************************************/
      case 49:
        //AGLOMERACIONES
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      case 50:
        //NUMÉRICO DE ACÉMILAS
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      case 51:
        //NUMÉRICO DE CANES
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      case 52:
        //PERSONAL ESTÁTICO
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      case 53:
        //PERSONAL MÓVIL
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      case 54:
        //INICIA SERVICIO
        wg = wgTxtHora(responsive);
        validarForm = true;
        break;

      case 55:
        //FINALIZA SERVICIO
        wg = wgTxtHora(responsive);
        validarForm = true;
        break;

      default:
        print('idDgoNovedadesElect');
        validarForm = false;
        mostrarFoto = false;
        wg = Container();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.mostrarFoto.value = mostrarFoto;
    });
    controller.validarForm = validarForm;
    controller.registrarDatosPersona = registrarDatosPersona;

    if (wg is Container) {
      return wg;
    } else {
      return ContenedorDesingWidget(paddin: EdgeInsets.all(5), child: wg);
    }
  }

  Widget getBtnColores(
      {required ResponsiveUtil responsive,
      required String title,
      required Color color}) {
    return Container(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      ),
      width: responsive.anchoP(20),
      height: responsive.altoP(2),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
          boxShadow: [
            BoxShadow(
                color: SiipneColors.colorBordecajas,
                blurRadius: AppConfig.sobraBordecajas)
          ]),
    );
  }

  Widget wgorganizacionDirigenteCantidad(ResponsiveUtil responsive) {
    return Column(
      children: [
        wgTxtNumeroManifestantes(responsive),
        SizedBox(
          height: responsive.altoP(1),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getBtnColores(
                  responsive: responsive,
                  color: Colors.green.withOpacity(0.8),
                  title: "1-50"),
              getBtnColores(
                  responsive: responsive,
                  color: Colors.yellow.withOpacity(0.8),
                  title: "51-200"),
              getBtnColores(
                  responsive: responsive,
                  color: Colors.orange.withOpacity(0.8),
                  title: "201-500"),
              getBtnColores(
                  responsive: responsive,
                  color: Colors.red.withOpacity(0.8),
                  title: "501-Más"),
            ],
          ),
        )
      ],
    );
  }

  Widget getBtnGuardar() {




    return Obx(() => controller.mostrarBtnGuardar.value
        ? BtnIconWidget(
      icon: Icons.save,
      titulo: "GUARDAR",
      onPressed: () {
        String descripcion=controller.selectNovedad.value.descripcion;
        if(controller.selectDelito.value.idDgoNovedadesElect>0){
          descripcion=controller.selectDelito.value.descripcion;
        }

        DialogosAwesome.getWarningSiNo(
            title: '¿Desea continuar con el registro?',
            descripcion: 'Registro de Novedad:\n\n${descripcion}',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              controller.eventoRegistrarNovedadesElectorales();
            });
      },
    )
        : Container());
  }


  //+++++++++++++++++++++++++++ TXT +++++++++++++++++++++++++++++

  Widget getForm({required Widget child}) {
    return Form(
      key: controller.formKey,
      child: child,
    );
  }

  Widget wgTxtCedula(
      {required ResponsiveUtil responsive,
      String title = SiipneStrings.cedula}) {
    return getForm(
      child: Column(
        children: [getWgCedulaWithFind(responsive)],
      ),
    );
  }

  Widget wgTxtCedulaTelefono(
      {required ResponsiveUtil responsive,
      String title = SiipneStrings.cedula}) {
    return getForm(
      child: Column(
        children: [
          getWgCedulaWithFind(responsive),
          ImputTextWidget(
            keyboardType: TextInputType.number,
            controller: controller.controllerTelefono,
            icono: Icon(
              Icons.phone_android,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Teléfono",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateTelefono,
          )
        ],
      ),
    );
  }

  Widget wgTxtObservacion(
      {required ResponsiveUtil responsive,
      String title = SiipneStrings.cedula}) {
    return getForm(
      child: Column(
        children: [
          Container(
            child: Text(
              "Observación",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: responsive.diagonalP(1.5),
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
          Column(
            children: <Widget>[
              Card(
                  color: Colors.white54,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.controllerObs,
                      maxLength: 100,
                      maxLines: 4, //or null
                      decoration: InputDecoration.collapsed(
                          hintText: "Ingrese la Observación"),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }

  //Widget para detenidos

  Widget getSelectNacionalExtranjero() {
    return Obx(() => Row(
      children: [
        Flexible(
          child: ListTile(
            title:TituloTextWidget(title: "Nacional") ,
            leading: Radio<String>(
              value: 'Nacional',
              groupValue: controller.selectedOptionNAcionalExtranjero.value,
              onChanged: (String? value) {
                if (value != null) {
                  controller.selectedOptionNAcionalExtranjero.value = value;
                }
              },
            ),
          ),
        ),
        Flexible(
          child: ListTile(
            title:TituloTextWidget(title: "Extranjero") ,
            leading: Radio<String>(
              value: 'Extranjero',
              groupValue: controller.selectedOptionNAcionalExtranjero.value,
              onChanged: (String? value) {
                if (value != null) {
                  controller.selectedOptionNAcionalExtranjero.value = value;
                }
              },
            ),
          ),
        ),
      ],
    ));
  }


  Widget wgTxtCedulaBoleta(ResponsiveUtil responsive) {
    return getForm(
      child: Column(
        children: [
          getSelectNacionalExtranjero(),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerNumBoleta,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: SiipneStrings.numBoleta,
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateNumBoleta,
          ),
          getWgCedulaWithFind(responsive)
        ],
      ),
    );
  }

  Widget getWgCedulaWithFind(ResponsiveUtil responsive, {bool validar = true}) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: ImputTextWidget(
                keyboardType: TextInputType.number,
                controller: controller.controllerCedula,
                icono: Icon(
                  Icons.assignment_sharp,
                  color: Colors.black38,
                  size: controller.sizeIcons,
                ),
                label: SiipneStrings.cedula,
                fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
                validar:
                    controller.selectedOptionNAcionalExtranjero == "Nacional"
                        ? Validate.validateCedula
                        : null,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                child: BtnIconWidget(
                  onPressed: () {
                    bool validar =
                        controller.selectedOptionNAcionalExtranjero ==
                                "Nacional"
                            ? true
                            : false;

                    if (controller.selectTipoNovedad.value.descripcion !=
                        "DETENIDOS") {
                      validar = false;
                    }
                    controller.validarForm=validar;

                    controller.getDatosPersona(permitirAll: true);
                    /*TODO:comentado
                       _consultarDatosPersonaPorDocumento(
                        validar: validar,
                        cedula: controllerCedula.text,
                        usuario: _UserProvider.getUser.idGenUsuario);*/
                  },
                  icon: Icons.search,
                  colorTxt: Colors.white,
                  colorIcon: Colors.white,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: responsive.altoP(1),
        ),


     wgDatosPersona()
      ],
    );
  }

  Widget wgTxtCedulaCitacion(ResponsiveUtil responsive) {
    return getForm(
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerNumCitacion,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: SiipneStrings.numCitacion,
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateNumCitacion,
          ),
          getWgCedulaWithFind(responsive)
        ],
      ),
    );
  }

  Widget wgTxtMotivo(ResponsiveUtil responsive) {
    return getForm(
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerMotivo,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Motivo",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateNumCitacion,
          ),
        ],
      ),
    );
  }

  Widget wgTxtNumericoPersonal(ResponsiveUtil responsive) {
    return getForm(
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.number,
            controller: controller.controllerNumericoPersonal,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Númerico del Personal",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateNumPersonal,
          ),
        ],
      ),
    );
  }

  Widget wgTxtNumeroManifestantes(responsive) {
    return getForm(
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerOrganizacion,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Organización Social o Política",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateOrganizacion,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerDirigente,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Dirigente",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateDirigente,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.number,
            controller: controller.controllerCantidad,
            onChanged: (valor) {
              if (valor != null) {
                if (int.parse(valor) > 100) {}
              }
            },
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Cantidad",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateCantidad,
          ),
        ],
      ),
    );
  }

  Widget wgTxtNumeroQuemaUrnas(responsive) {
    return getForm(
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerOrganizacion,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Organización Social o Política",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateOrganizacion,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerDirigente,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Dirigente",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateDirigente,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.number,
            controller: controller.controllerCantidad,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Cantidad",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateCantidad,
          ),
        ],
      ),
    );
  }

  Widget wgTxtNumeroTomaRecintos(responsive) {
    return getForm(
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerOrganizacion,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Organización Social o Política",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateOrganizacion,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerDirigente,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Dirigente",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateDirigente,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.number,
            controller: controller.controllerCantidad,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Cantidad",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateCantidad,
          ),
        ],
      ),
    );
  }

  Widget wgTxtDesplazamientosAutoridades(responsive) {
    return getForm(
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerNombre,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Nombre",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateNombre,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerCargo,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Cargo/Función",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateCargo,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerGrado,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Grado (Opcional)",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
          ),
        ],
      ),
    );
  }

  Widget wgTxtApoyoMediosComunicacion(responsive) {
    return getForm(
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerNombre,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Nombre",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateNombre,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerMedioComunicacion,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Medio de Comunicación",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateMedioComunicacion,
          ),
        ],
      ),
    );
  }

  Widget wgTxtSeguridadPersonasImportantes(responsive) {
    return getForm(
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerFuncion,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Función",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateFuncion,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerNombre,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Nombres",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateNombre,
          ),
        ],
      ),
    );
  }

  Widget wgTxtSeguridadInstalaciones(responsive) {
    return getForm(
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerInstalacion,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Nombre Instalación",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateInstalacion,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerDescripcion,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Descripción",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateDescripcion,
          ),
        ],
      ),
    );
  }

  Widget wgTxtExplosivos(responsive) {
    return getForm(
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerDireccion,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Dirección",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateDireccion,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerDescripcion,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Descripción",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateDescripcion,
          ),
        ],
      ),
    );
  }

  Widget wgTxtApoyoUnidadesPoliciales(responsive) {
    return getForm(
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controller.controllerUnidad,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Unidad",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateUnidad,
          ),
        ],
      ),
    );
  }

  Widget wgTxtHora(ResponsiveUtil responsive) {
    return getForm(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: responsive.altoP(1),
          ),
          getComboHora(responsive),
          getComboMinuto(responsive)
        ],
      ),
    );
  }

  Widget getComboHora(ResponsiveUtil responsive) {
    List<String> datos = controller.datosHora;

    return ComboBusqueda(
      selectValue: controller.selectHora,
      icon: Icons.select_all_sharp,
      showClearButton: false,
      datos: datos,
      displayField: (item) => item, // Aquí decides mostrar "nombres"
      searchHint: "Hora",
      complete: (value) {
        if (value != null) {
          controller.selectHora = value;
          return;
        }
      },
      textSeleccioneUndato: "Seleccione la Hora",
    );
  }

  Widget getComboMinuto(ResponsiveUtil responsive) {
    List<String> datos = controller.datosMinuto;

    return ComboBusqueda(
      selectValue: controller.selectMinuto,
      icon: Icons.select_all_sharp,
      showClearButton: false,
      datos: datos,
      displayField: (item) => item, // Aquí decides mostrar "nombres"
      searchHint: "Minuto",
      complete: (value) {
        if (value != null) {
          controller.selectMinuto = value;

          return;
        }
      },
      textSeleccioneUndato: "Seleccione Minuto",
    );
  }

  Widget wgTxtNumerico(responsive) {
    return getForm(
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.number,
            controller: controller.controllerNumerico,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: controller.sizeIcons,
            ),
            label: "Numérico",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: Validate.validateNumerico,
          ),
        ],
      ),
    );
  }

//+++++++++++++++++++++++++++ TXT +++++++++++++++++++++++++++++




  Widget wgDatosPersona() {


    return Obx(()=>controller.datosPerson.value.idGenPersona > 0
        ?  Container(
      padding: EdgeInsets.all(5),
      child: TituloDetalleTextWidget(
        margin: EdgeInsets.all(0),
        padding:  EdgeInsets.all(8),

        title: "Nombres",
        detalle: controller.datosPerson.value.siglas.length > 0
            ? controller.datosPerson.value.siglas + "." + controller.datosPerson.value.apenom
            : controller.datosPerson.value.apenom,

      ),)
        : Container());
  }
}
