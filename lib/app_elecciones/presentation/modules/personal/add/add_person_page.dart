part of '../../pages.dart';

class AddPersonPage extends GetView<AddPersonController> {
  const AddPersonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      mostrarBtnAtras: true,
      title: "AGREGAR PERSONAL",
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

              icon: Icons.person,
              titulo: "VER PERSONAL",
              onPressed: () => controller.cerrarSession(),
            ),


          wgConsultaIdGenPersonaPorDocumento(),
          SizedBox(
            height: 5,
          ),
          wgDatosPersona(),
          getCombos(),

        getBtnAgregar(),

          SizedBox(
            height: responsive.altoP(3.5),
          ),
        ],
      ),
    );
  }

  Widget getBtnAgregar(){
    return  Obx(()=>controller.datosPerson.value.idGenPersona > 0 &&  controller.selectUnidadPolicial.value.idDgoTipoEje>0
        ?   BtnIconWidget(
      icon: Icons.save,
      titulo: "AGREGAR",
      onPressed: () => controller.addPersona(),
    ):Container());
  }

  Widget wgConsultaIdGenPersonaPorDocumento() {
    final responsive = ResponsiveUtil();
    final sizeTxt = responsive.anchoP(AppConfig.tamTexto + 2.0);

    return ContenedorDesingWidget(
      anchoPorce: AppConfig.anchoContenedor,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),

        // handle your onTap here
        child: Container(
          margin: EdgeInsets.only(left: 0.0, right: 20.0),
          width: responsive.anchoP(55),
          height: responsive.anchoP(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: responsive.altoP(1),
              ),
              Expanded(
                  child: Form(
                    key: controller. formKeyDocumento,
                    child: ImputTextWidget(
                      keyboardType: TextInputType.number,
                      controller:controller. controllerDocumento,
                      icono: Icon(
                        Icons.assignment_sharp,
                        color: AppColors.colorIcons,
                        size:responsive.diagonalP(AppConfig. tamIcons),
                      ),
                      label: SiipneStrings.cedula,
                      fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
                      validar: validateDocumento,
                    ),
                  )),
              SizedBox(
                width: responsive.altoP(1),
              ),
              BtnIconWidget(

                icon: Icons.search,
                onPressed: () =>controller.getDatosPersona(),

              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validateDocumento(String? value) {
    if (value==null || value.length < 10) {
      return SiipneStrings.errorCedulaNoValida;
    } else if (controller.user.documento == controller. controllerDocumento.text) {
      return SiipneStrings.ingreseCedulaDistinta;
    }

    return null;
  }

  Widget getCombos(){
    final responsive = ResponsiveUtil();
    return Column(children: [
      SizedBox(
        height: responsive.altoP(0.4),
      ),
      getComboSubsistema(),
      SizedBox(
        height: responsive.altoP(0.4),
      ),
      getComboDireccionesPoliciales(),
      SizedBox(
        height: responsive.altoP(0.4),
      ),
      getComboEjesUnidadesPoliciales(),
    ],);
  }



  Widget getComboSubsistema() {

    return   Obx(()=>controller.datosPerson.value.idGenPersona > 0
        ? ContenedorDesingWidget(
        paddin: EdgeInsets.all(5),
        child: ComboBusqueda(
          selectValue: controller.selectSubsistema.value,
          icon: Icons.select_all_sharp,
          showClearButton: false,
          datos: controller.listSubsistema,
          displayField: (item) =>
          item.descripcion, // Aquí decides mostrar "nombres"
          searchHint: "Subsistema",
          complete: (value) {
            controller.selectSubsistema.value = UnidadesPoliciale.empty();
            controller.selectDireccionPoliciales.value =
                UnidadesPoliciale.empty();
            controller.selectUnidadPolicial.value =
                UnidadesPoliciale.empty();

            if (value != null) {
              controller.selectSubsistema.value = value;

              controller.getEjesDireccionesPoliciales(value.idDgoTipoEje);
              return;
            }
          },
          textSeleccioneUndato: "Seleccione un Subsistema",
        )):Container());
  }

  Widget getComboDireccionesPoliciales() {
    return Obx(() => controller.selectSubsistema.value.idDgoTipoEje > 0
        ? ContenedorDesingWidget(
        paddin: EdgeInsets.all(5),
        child: ComboBusqueda(
          selectValue: controller.selectDireccionPoliciales.value,
          icon: Icons.select_all_sharp,
          showClearButton: false,
          datos: controller.listDireccionesPoliciales,
          displayField: (item) =>
          item.descripcion, // Aquí decides mostrar "nombres"
          searchHint: "Dirección",
          complete: (value) {
            controller.selectDireccionPoliciales.value =
                UnidadesPoliciale.empty();
            controller.selectUnidadPolicial.value =
                UnidadesPoliciale.empty();
            if (value != null) {
              controller.getEjesUnidadesPoliciales(value.idDgoTipoEje);
              controller.selectDireccionPoliciales.value = value;
              return;
            }
          },
          textSeleccioneUndato: "Seleccione una Dirección",
        ))
        : Container());
  }

  Widget getComboEjesUnidadesPoliciales() {
    return Obx(() => controller.selectDireccionPoliciales.value.idDgoTipoEje > 0
        ? ContenedorDesingWidget(
        paddin: EdgeInsets.all(5),
        child: ComboBusqueda(
          selectValue: controller.selectUnidadPolicial.value,
          icon: Icons.select_all_sharp,
          showClearButton: false,
          datos: controller.listUnidadesPoliciales,
          displayField: (item) =>
          item.descripcion, // Aquí decides mostrar "nombres"
          searchHint: "Unidad Policial",
          complete: (value) {
            controller.selectUnidadPolicial.value =
                UnidadesPoliciale.empty();

            if (value != null) {
              controller.selectUnidadPolicial.value = value;
              return;
            }
          },
          textSeleccioneUndato: "Seleccione una Unidad",
        ))
        : Container());
  }


  Widget wgDatosPersona() {
    final responsive = ResponsiveUtil();

    return Obx(()=>controller.datosPerson.value.idGenPersona > 0
        ?  ContenedorDesingWidget(
      anchoPorce: AppConfig.anchoContenedor,
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          'DATOS',
          style: TextStyle(
            fontSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
          ),
        ),
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: TituloDetalleTextWidget(
              title: "Nombres",
              detalle: controller.datosPerson.value.siglas.length > 0
                  ? controller.datosPerson.value.siglas + "." + controller.datosPerson.value.apenom
                  : controller.datosPerson.value.apenom,

            ),)
        ],
      ),
    )
        : Container());
  }
}


