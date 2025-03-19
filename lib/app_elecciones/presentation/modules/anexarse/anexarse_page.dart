part of '../pages.dart';

class AnexarsePage extends GetView<AnexarseController> {
  const AnexarsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      showGps: true,
      mostrarBtnAtras: true,
      title: "ANEXARSE",
      contenido: getContenido(),
      peticionServer: controller.peticionServerState,
    );
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();
    String Bienvenido =
        controller.user.sexo == 'HOMBRE' ? "BIENVENIDO: " : "BIENVENIDA: ";

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 10,
        ),
        wgConsultarRecinto(),
        SizedBox(
          height: 10,
        ),
        wgDatosRecinto(),
      ],
    );
  }

  Widget wgDatosRecinto() {
    final responsive = ResponsiveUtil();

    return ContenedorDesingWidget(
      child: ExpansionTile(
        collapsedIconColor: AppColors.colorAzul,
        iconColor: AppColors.colorAzul,
        initiallyExpanded: true,
        title: Text(
          'DATOS DEL OPERATIVO',
          style: TextStyle(
            color: AppColors.colorAzul,
            fontSize: responsive.diagonalP(AppConfig.tamTexto),
          ),
        ),
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: responsive.altoP(1),
                ),
                TituloDetalleTextWidget(
                  title: "Instalación",
                  detalle: "_datosRecintoElectoralClass.nomRecintoElec",
                ),
                TituloDetalleTextWidget(
                  title: "Encargado",
                  detalle: "_datosRecintoElectoralClass.encargado",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget wgConsultarRecinto() {
    final responsive = ResponsiveUtil();
    return ContenedorDesingWidget(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        // handle your onTap here
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          margin: EdgeInsets.only(left: 0.0, right: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: responsive.altoP(1),
              ),
              Expanded(
                  child: Form(
                key: controller.formKey,
                child: ImputTextWidget(
                  keyboardType: TextInputType.number,
                  controller: controller.controllerCodigoRecinto,
                  icono: Icon(
                    Icons.assignment_sharp,
                    color: SiipneColors.colorIcons,
                    size: responsive.diagonalP(AppConfig.tamIcons),
                  ),
                  label: SiipneStrings.codigo,
                  fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
                  validar: validateCodigoRecinto,
                ),
              )),
              SizedBox(
                width: responsive.altoP(1),
              ),
              BtnIconWidget(
                onPressed: () {},
                icon: Icons.search,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validateCodigoRecinto(String? value) {
    if (value != null && value.length > 0) {
      return null;
    }
    return SiipneStrings.codigoOperativoNoValido;
  }
}
