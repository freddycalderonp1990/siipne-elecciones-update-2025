part of '../pages.dart';

class MenuAppPage extends GetView<MenuAppController> {
  const MenuAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      mostrarAnuncio: true,
      contenido: getContenido(),
      peticionServer: controller.peticionServerState,
    );
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: responsive.altoP(5),
        ),
        Expanded(
            child: Obx(() => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.listCatBeneficio.length,
                itemBuilder: (context, i) {
                  DataCatBeneficio data = controller.listCatBeneficio[i];
                  return BtnMenuWidget(
                    img: data.imgBase64,
                    mostrarLine: false,
                    colorFondo: Colors.white,
                    imgLocal: AppImages.ic_empresa,
                    horizontal: true,
                    title: data.descripcion,
                    onTap: () {
                      controller.gotoToPage(data);
                    },
                  );
                }))),
      ],
    );
  }
}
