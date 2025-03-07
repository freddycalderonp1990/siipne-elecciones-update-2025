part of '../../controllers.dart';

class AddNovedadesController extends GetxController {
  final idNovedadBoletaCaptura =
      15; //id de la base de datos que tiene registrado como Boleta de captura

  final loginController = Get.find<LoginController>();

  final EleccionesNovedadesApiImpl _eleccionesNovedadesApiImpl =
      Get.find<EleccionesNovedadesApiImpl>();

  RecintosElectoralesAbiertos recintosElectoralesAbiertos =
      RecintosElectoralesAbiertos.empty();

  RxBool cargaInicial = false.obs;

  RxBool mostrarBtnGuardar = false.obs;

  late DataUser user;

  RxBool peticionServerState = false.obs;

  RxList<NovedadesElectorale> listTipoNovedades = <NovedadesElectorale>[].obs;
  Rx<NovedadesElectorale> selectTipoNovedad = NovedadesElectorale.empty().obs;

  RxList<NovedadesElectorale> listNovedades = <NovedadesElectorale>[].obs;
  Rx<NovedadesElectorale> selectNovedad = NovedadesElectorale.empty().obs;

  RxList<NovedadesElectorale> listDelito = <NovedadesElectorale>[].obs;
  Rx<NovedadesElectorale> selectDelito = NovedadesElectorale.empty().obs;

  RxBool mostrarFoto = false.obs;
  bool validarForm = false;
  bool registrarDatosPersona = true;

  Rx<GaleryCameraModel?> mGaleryCameraModel = Rx<GaleryCameraModel?>(null);

  final formKey = GlobalKey<FormState>();

  var controllerCedula = new TextEditingController();
  var controllerTelefono = new TextEditingController();
  var controllerNumBoleta = new TextEditingController();
  var controllerNumCitacion = new TextEditingController();
  var controllerObs = new TextEditingController();

  var controllerOrganizacion = new TextEditingController();
  var controllerDirigente = new TextEditingController();
  var controllerCantidad = new TextEditingController();

  var controllerNombre = new TextEditingController();
  var controllerCargo = new TextEditingController();
  var controllerGrado = new TextEditingController();
  var controllerMedioComunicacion = new TextEditingController();

  var controllerFuncion = new TextEditingController();
  var controllerDescripcion = new TextEditingController();
  var controllerInstalacion = new TextEditingController();
  var controllerDireccion = new TextEditingController();
  var controllerUnidad = new TextEditingController();

  var controllerMotivo = new TextEditingController();
  var controllerNumericoPersonal = new TextEditingController();

  var controllerNumerico = new TextEditingController();

  late double sizeIcons;
  RxString selectedOptionNAcionalExtranjero = "Nacional".obs;

  List<String> datosHora = [];
  List<String> datosMinuto = [];
  DateTime selectedDate = DateTime.now();

  String? selectHora, selectMinuto;

  final PersonaApiImpl _personaApiImpl = Get.find<PersonaApiImpl>();

  Rx<DatosPer> datosPerson = DatosPer.empty().obs;

  String? nombreDetenido;
  int? idGenPersonaD;

  @override
  void onInit() async {
    user = loginController.user.value;
    cargaInicial.value = true;
    getDataToPage();

    await getNovedadesPadres();
    setDatosHora();
    setDatosMinuto();

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: Donde la vista ya se presento
    var responsive = ResponsiveUtil();
    sizeIcons =
        responsive.isVertical() ? responsive.altoP(3) : responsive.anchoP(5);
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }

  getDataToPage() async {
    // Recibe los argumentos
    final arguments = Get.arguments as Map<String, dynamic>?;

    // Verifica que los argumentos no sean nulos y que contengan la clave 'data'
    if (arguments != null &&
        arguments.containsKey('recintosElectoralesAbiertos')) {
      try {
        recintosElectoralesAbiertos = arguments['recintosElectoralesAbiertos']
            as RecintosElectoralesAbiertos;
      } catch (e) {
        DialogosAwesome.getError(descripcion: "No existe data valida");
      }
    } else {
      DialogosAwesome.getError(descripcion: "No existe data valida");
    }
  }

  Future<void> getNovedadesPadres() async {
    peticionServerState(true);
    await ExceptionHelper.manejarErroresShowDialogo(() async {
      listTipoNovedades.value =
          await _eleccionesNovedadesApiImpl.getNovedadesPadres(
            idDgoProcElec:recintosElectoralesAbiertos.idDgoProcElec ,
              idDgoReciElect:recintosElectoralesAbiertos.idDgoReciElect ,
              idDgoTipoEje: recintosElectoralesAbiertos.idDgoTipoEje);

      if (listTipoNovedades.length == 0) {
        DialogosAwesome.getInformation(descripcion: "No existen Novedades");
        return;
      }
    });
    peticionServerState(false);
  }

  Future<void> getNovedadesHijas(int idNovedadesPadre) async {
    peticionServerState(true);
    await ExceptionHelper.manejarErroresShowDialogo(() async {
      listNovedades.value = await _eleccionesNovedadesApiImpl.getNovedadesHijas(
          idDgoProcElec:recintosElectoralesAbiertos.idDgoProcElec ,
          idDgoReciElect:recintosElectoralesAbiertos.idDgoReciElect ,
          idNovedadesPadre: idNovedadesPadre,
          idDgoTipoEje: recintosElectoralesAbiertos.idDgoTipoEje);

      if (listNovedades.length == 0) {
        DialogosAwesome.getInformation(descripcion: "No existen Novedades");
        return;
      }
    });
    peticionServerState(false);
  }

  Future<void> getNovedadesDelito(int idNovedadesPadre) async {
    peticionServerState(true);
    await ExceptionHelper.manejarErroresShowDialogo(() async {
      listDelito.value = await _eleccionesNovedadesApiImpl.getNovedadesHijas(
          idNovedadesPadre: idNovedadesPadre,
          idDgoProcElec:recintosElectoralesAbiertos.idDgoProcElec ,
          idDgoReciElect:recintosElectoralesAbiertos.idDgoReciElect ,
          idDgoTipoEje: recintosElectoralesAbiertos.idDgoTipoEje);

      if (listDelito.length == 0) {
        DialogosAwesome.getInformation(descripcion: "No existen Novedades");
        return;
      }
    });
    peticionServerState(false);
  }

  cleardatos() {
    selectNovedad.value = NovedadesElectorale.empty();
    selectTipoNovedad.value = NovedadesElectorale.empty();
  }

  cerrarSession() {
    Get.toNamed(AppRoutes.SPLASH_APP);
  }

  goToPageReporteNovedades() {
    Get.toNamed(SiipneRoutes.REPORT_PERSONAL, arguments: {
      "recintosElectoralesAbiertos": recintosElectoralesAbiertos
    });
  }

  setDatosHora() {
    List<String> datos = [];

    for (int i = 0; i < 24; i++) {
      if (i < 10) {
        datos.add("0" + i.toString());
      } else {
        datos.add(i.toString());
      }
    }

    datosHora = datos;

    selectHora = DateFormat(SiipneConfig.formatoSoloHora).format(selectedDate);
    ;
  }

  setDatosMinuto() {
    List<String> datos = [];
    for (int i = 0; i < 60; i++) {
      if (i < 10) {
        datos.add("0" + i.toString());
      } else {
        datos.add(i.toString());
      }
    }

    datosMinuto = datos;
    selectMinuto =
        DateFormat(SiipneConfig.formatoSoloMinuto).format(selectedDate);
  }

  Future<void> getDatosPersona({bool permitirAll = false}) async {
    bool isValid = true;
    if (validarForm) {
      isValid = formKey.currentState!.validate();
    }
    print("unoooo ${isValid}");

    if (!isValid && validarForm == true) {
      return;
    }

    peticionServerState(true);
    await ExceptionHelper.manejarErroresShowDialogo(() async {
      datosPerson.value = await _personaApiImpl.getDatosPersona(
          usuario: user.idGenUsuario, cedula: controllerCedula.text);
      if (datosPerson.value.idGenPersona == 0) {
        DialogosAwesome.getInformation(
            btnOkOnPress: () {},
            descripcion:
                "No existe datos para el documento ${controllerCedula.text}");
        return;
      }

      if (!datosPerson.value.poliRegistrado && permitirAll == false) {
        datosPerson.value = DatosPer.empty();
        DialogosAwesome.getInformation(
          btnOkOnPress: () {},
          descripcion: 'Persona no es Servidor Policial',
        );
        return;
      }
    });
    peticionServerState(false);
  }

  eventoRegistrarNovedadesElectorales() async {
    bool isValid = true;

    if (validarForm) {
      isValid = formKey.currentState!.validate();
    }

    if (!isValid && validarForm == true) {
      return;
    }

    if (registrarDatosPersona) {
      if (datosPerson.value.idGenPersona == 0) {
        DialogosAwesome.getInformation(
            btnOkOnPress: () {},
            descripcion:
                "No ha ingresado una cédula valida...Seleccione el icono buscar para continuar.",
            title: 'Persona');

        return;
      }

      nombreDetenido = datosPerson.value.apenom;
      idGenPersonaD = datosPerson.value.idGenPersona;
    }

    print("isValid");
    print(isValid);

    if (isValid) {
      int idDgoNovedadesElect = selectNovedad.value.idDgoNovedadesElect;
      if (selectDelito.value.idDgoNovedadesElect > 0) {
        idDgoNovedadesElect = selectDelito.value.idDgoNovedadesElect;
      }

      if (mostrarFoto.value) {
        if (mGaleryCameraModel.value == null) {
          DialogosAwesome.getWarning(
              descripcion: "Selecione una Imagen",
              title: "Imagen",
              btnOkOnPress: () {});
        } else {
          /*
          TODO: Comentado
          bool insertImg = await guardarImgRecElectNovedades(
              galeryCameraModel: mGaleryCameraModel);
          print('Ingreso con imagen');

           */
          bool insertImg = true;

          if (insertImg) {
            await _RegistrarNovedades(
                idGenPersonaD: idGenPersonaD,
                nombreDetenido: nombreDetenido,
                usuario: user.idGenUsuario,
                observacion: getObservacion(),
                idDgoPerAsigOpe: recintosElectoralesAbiertos.idDgoPerAsigOpe,
                idDgoNovedadesElect: idDgoNovedadesElect,
                imagen: mGaleryCameraModel.value!.nombreImg);
          }
        }
      } else {
        print('no foto');

        await _RegistrarNovedades(
            idGenPersonaD: idGenPersonaD,
            nombreDetenido: nombreDetenido,
            usuario: user.idGenUsuario,
            observacion: getObservacion(),
            idDgoPerAsigOpe: recintosElectoralesAbiertos.idDgoPerAsigOpe,
            idDgoNovedadesElect: idDgoNovedadesElect);
      }
    }
  }

  _RegistrarNovedades(
      {required int idDgoNovedadesElect,
      required int idDgoPerAsigOpe,
      required String observacion,
      required int usuario,
      String? nombreDetenido,
      int? idGenPersonaD,
      String imagen = "No Imagen"}) async {
    if (idDgoPerAsigOpe == 0) return;
    log("observacion= ${observacion}");

    String resultInsert = "";
    peticionServerState(true);
    await ExceptionHelper.manejarErroresShowDialogo(() async {
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng position = await locationBloc.getCurrentPosition();
      String ip = await DeviceInfo.getIp;


      AddNovedadesRequest request=AddNovedadesRequest(
        idDgoPerAsigOpe: idDgoPerAsigOpe,
        usuario: usuario,
        idDgoNovedadesElect: idDgoNovedadesElect,
        observacion: observacion,
        idGenPersonaD: idGenPersonaD,
        nombreDetenido: nombreDetenido,
        imagen: imagen,
        latitud: position.latitude,
        longitud: position.longitude,
        cedula: controllerCedula.text,
        idDgoProcElec: recintosElectoralesAbiertos.idDgoProcElec,
        ip: ip, idDgoReciElect: recintosElectoralesAbiertos.idDgoReciElect,
      );

      resultInsert =
          await _eleccionesNovedadesApiImpl.registrarNovedadesElectorales(
        request: request
      );
    });
    peticionServerState(false);

    if (resultInsert.toLowerCase().trim() == "true") {
      clearData();
      DialogosAwesome.getSucess(
          descripcion: "Registro de Novedad con éxito", btnOkOnPress: () {});
    } else if (resultInsert.toLowerCase().trim() == "existe") {
      DialogosAwesome.getWarning(
          descripcion:
              "Ya existe una novedad registrada con este documento ${controllerCedula.text}",
          btnOkOnPress: () {});
    } else {
      DialogosAwesome.getError(
          descripcion:
              "No se pudo Registrar la Novedad. Vuelva a intentar o contacte con el administrador del sistema.",
          btnOkOnPress: () {});
    }
  }

  void clearData(){
    mostrarBtnGuardar.value=false;
    selectTipoNovedad.value = NovedadesElectorale.empty();
    selectNovedad.value = NovedadesElectorale.empty();
    selectDelito.value = NovedadesElectorale.empty();

    controllerCedula.clear();
    controllerTelefono.clear();
    controllerNumBoleta.clear();
    controllerNumCitacion.clear();
    controllerObs.clear();

    controllerOrganizacion.clear();
    controllerDirigente.clear();
    controllerCantidad.clear();

    controllerNombre.clear();
    controllerCargo.clear();
    controllerGrado.clear();
    controllerMedioComunicacion.clear();

    controllerFuncion.clear();
    controllerDescripcion.clear();
    controllerInstalacion.clear();
    controllerDireccion.clear();
    controllerUnidad.clear();

    controllerMotivo.clear();
    controllerNumericoPersonal.clear();

    controllerNumerico.clear();
    datosPerson = DatosPer.empty().obs;
  }

  ObservacionModel getObservacionNovedades(ObservacionModel observacionModel) {
    print("getObservacionNovedades");
    print(observacionModel.idDgoNovedadesElect);

    String? cedula = null;
    if (registrarDatosPersona) {
      cedula = datosPerson.value.documento;
    }
    switch (observacionModel.idDgoNovedadesElect) {
      case 17:
        break;
      case 18:
        break;
      case 19:

        //3. RECINTO ELECTORAL INSTALADO CON RETARDO POR DIFERENTES CAUSAS
        observacionModel =
            observacionModel.copyWith(hora: "${selectHora}:${selectMinuto}");

        break;
      case 20:
        //4. RECINTOS ELECTORALES SUSPENDIDO POR DIFERENTES CAUSAS

        observacionModel =
            observacionModel.copyWith(motivo: controllerMotivo.text);

        break;
      case 21:
        //5. AGRESIONES A SERVIDORES POLICIALES
        registrarDatosPersona = true;
        observacionModel = observacionModel.copyWith(cedula: cedula);

        break;
      case 22:
        //6. PRESENCIA DE MANIFESTANTES / CONCENTRACIONES / MARCHAS

        observacionModel = observacionModel.copyWith(
            organizacion: controllerOrganizacion.text,
            dirigente: controllerDirigente.text,
            cantidad: controllerCantidad.text);
        break;
      case 23:
        //7. QUEMA DE URNAS / PAPELETAS

        observacionModel = observacionModel.copyWith(
            organizacion: controllerOrganizacion.text,
            dirigente: controllerDirigente.text,
            cantidad: controllerCantidad.text);

        break;
      case 28:
        //8. TOMA DE RECINTOS / DELEGACIONES / BODEGAS / INSTALACIONES DEL CNE

        observacionModel = observacionModel.copyWith(
            organizacion: controllerOrganizacion.text,
            dirigente: controllerDirigente.text,
            cantidad: controllerCantidad.text);

        break;
      case 29:
        //9. PRESENCIA DE VENTAS AMBULANTES

        break;
      case 30:
        //10. ATENCIÓN MÉDICA POR DIFERENTES CAUSAS

        observacionModel = observacionModel.copyWith(
          cedula: cedula,
          telefono: controllerTelefono.text,
        );
        break;
      case 31:
        //11. SERVIDORES POLICIALES INFECTADOS (SOSPECHA/POSITIVO)

        observacionModel = observacionModel.copyWith(
          cedula: cedula,
        );

        break;

      case 32:
        observacionModel = observacionModel.copyWith(
          numerico: controllerNumerico.text,
        );

        break;

      /******************************** UMO ******************************************/
      case 33:
        //1. NUMERICO DE PERSONAL

        observacionModel = observacionModel.copyWith(
          cantidad: controllerNumericoPersonal.text,
        );

        break;
      case 34:
        //2. PLANTONES

        observacionModel = observacionModel.copyWith(
            organizacion: controllerOrganizacion.text,
            dirigente: controllerDirigente.text,
            cantidad: controllerCantidad.text);

        break;
      case 35:
        //3. MARCHAS
        observacionModel = observacionModel.copyWith(
            organizacion: controllerOrganizacion.text,
            dirigente: controllerDirigente.text,
            cantidad: controllerCantidad.text);

        break;

      case 36:
        //4. CIERRE DE VIAS
        observacionModel = observacionModel.copyWith(
            organizacion: controllerOrganizacion.text,
            dirigente: controllerDirigente.text,
            cantidad: controllerCantidad.text);

        break;

      case 37:
        //5. TOMA DE ENTIDADES
        observacionModel = observacionModel.copyWith(
            organizacion: controllerOrganizacion.text,
            dirigente: controllerDirigente.text,
            cantidad: controllerCantidad.text);

        break;

      /******************************** AEROPOLICIAL ******************************************/
      case 45:
        //1. DESPLAZAMIENTO DE AUTORIDADES

        observacionModel = observacionModel.copyWith(
            nombre: controllerNombre.text,
            cargo: controllerCargo.text,
            grado: controllerGrado.text);

        break;
      case 46:
        //2. DESPLAZAMIENTO DE SERVIDORES PÚBLICOS

        observacionModel = observacionModel.copyWith(
            nombre: controllerNombre.text,
            cargo: controllerCargo.text,
            grado: controllerGrado.text);

        break;
      case 47:
        //3. APOYO AÉREO A MEDIOS DE COMUNICACIÓN

        observacionModel = observacionModel.copyWith(
          nombre: controllerNombre.text,
          medioComunicacion: controllerMedioComunicacion.text,
        );

        break;

      case 48:
        //4. TRASLADO DE RECURSOS LOGÍSTICOS

        break;

      /******************************** GOE - GIR ******************************************/

      case 41:
        //1. SEGURIDAD DE PERSONAS IMPORTANTES

        observacionModel = observacionModel.copyWith(
          funcion: controllerFuncion.text,
          nombre: controllerNombre.text,
        );

        break;
      case 42:
        //2. SEGURIDAD DE INSTALACIONES

        observacionModel = observacionModel.copyWith(
          instalacion: controllerInstalacion.text,
          descripcion: controllerDescripcion.text,
        );

        break;
      case 43:
        //3. REGISTRO DE EXPLOSIVOS

        observacionModel = observacionModel.copyWith(
          direccion: controllerDireccion.text,
          descripcion: controllerDescripcion.text,
        );

        break;

      case 44:
        //4. APOYO A UNIDADES POLICIALES

        observacionModel = observacionModel.copyWith(
          unidad: controllerUnidad.text,
        );
        break;

      /******************************** UMO - CRACK- UER ******************************************/

      case 49:
        observacionModel = observacionModel.copyWith(
          numerico: controllerNumerico.text,
        );
        break;

      case 50:
        observacionModel = observacionModel.copyWith(
          numerico: controllerNumerico.text,
        );
        break;
      case 51:
        observacionModel = observacionModel.copyWith(
          numerico: controllerNumerico.text,
        );
        break;
      case 52:
        observacionModel = observacionModel.copyWith(
          numerico: controllerNumerico.text,
        );
        break;
      case 54:
        observacionModel =
            observacionModel.copyWith(hora: "${selectHora}:${selectMinuto}");

        break;

      case 55:
        observacionModel =
            observacionModel.copyWith(hora: "${selectHora}:${selectMinuto}");

        break;
    }

    return observacionModel;
  }

  String getObservacion() {
    if (selectTipoNovedad.value.idDgoNovedadesElect > 0) {
      String novedadesPadres = selectTipoNovedad.value.descripcion;
      ObservacionModel observacionModel = ObservacionModel(
          descNovedadesElectPadre: selectTipoNovedad.value.descripcion,
          descNovedadesElect: selectNovedad.value.descripcion,
          idDgoNovedadesElect: selectNovedad.value.idDgoNovedadesElect);

      String? cedula = null;
      if (registrarDatosPersona) {
        cedula = datosPerson.value.documento;
      }

      switch (novedadesPadres.trim().toUpperCase()) {
        case "NOVEDADES":
          observacionModel = getObservacionNovedades(observacionModel);
          break;

        case "DELITOS":
          observacionModel = observacionModel.copyWith(cedula: cedula);
          break;

        case "DETENIDOS":
          observacionModel = observacionModel.copyWith(
              cedula: cedula, numBoleta: controllerNumBoleta.text);

          if (selectDelito.value.idDgoNovedadesElect > 0) {
            observacionModel = observacionModel.copyWith(
                descNovedadesElect: selectDelito.value.descripcion,
                idDgoNovedadesElect: selectDelito.value.idDgoNovedadesElect);
          }

          break;

        case "CITACIONES":
          observacionModel = observacionModel.copyWith(
              cedula: cedula, numCitacion: controllerNumCitacion.text);
          break;

        case "VOTO EN CASA":
          observacionModel =
              observacionModel.copyWith(numCitacion: controllerObs.text);
          break;

        case "NOV PPL":
          observacionModel =
              observacionModel.copyWith(numCitacion: controllerObs.text);
          break;
      }
      return observacionModelToJson2(observacionModel);
    }
    return "null";
  }
}
