part of '../pages.dart';

class PdfViewPage extends GetView<PdfViewController> {
  PdfViewPage({Key? key}) : super(key: key);
  final Completer<PDFViewController> _controllerPdf =
  Completer<PDFViewController>();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();



    return Scaffold(


        appBar: AppBar(
          backgroundColor: AppColors.colorIcons,

          title: Row(
            children: [
              Container(
                width: responsive.anchoP(50),
                child: Column(
                  children: [
                    Text(""),

                  ],
                ),
              ),

            ],
          ),


          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: ContenedorDesingWidget(


            margin: EdgeInsets.all(5),
            child: Container(
              margin: EdgeInsets.all(5),
              child: Stack(
                children: [
                  contenido(),

                  Container(
                      height: responsive.alto,
                      width: responsive.ancho,
                      child: Obx(() =>
                          CargandoWidget(
                            mostrar: controller.peticionServerState.value,))),
                ],
              ),
            )));
  }

  Widget getBtnZoom() {
    Widget wgZoom = Column(
      children: <Widget>[
        getBtnCustomIcon(
            icon: Icons.zoom_in,
            colorIcon: AppColors.colorAzul_10,
            colorRelleno: Colors.white,
            ontap: () {

            },
            size: 40),
        getBtnCustomIcon(
            icon: Icons.zoom_out,
            colorIcon: AppColors.colorAzul_10,
            colorRelleno: Colors.white,
            ontap: () {

            },
            size: 40)
      ],
    );

    return  wgZoom;
  }

  Widget contenido() {
    return Obx(() =>
        Container(
          margin: EdgeInsets.all(5),
          child: Stack(
            children: <Widget>[

              controller.path.value.length > 0
                  ? PDFView(
                filePath: controller.path.value,
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: true,
                pageFling: true,
                pageSnap: true,
                defaultPage: controller.currentPage.value,
                fitPolicy: FitPolicy.BOTH,
                preventLinkNavigation: false,
                // if set to true the link is handled in flutter
                onRender: controller.onRender,
                onError: controller.onError,

                onPageError: controller.onPageError,
                onViewCreated: (PDFViewController pdfViewController) {


                  _controllerPdf.complete(pdfViewController);
                },
                onLinkHandler: (String? uri) {
                  print('goto uri: $uri');
                },
                onPageChanged: controller.onPageChanged,
              )
                  : Container(),
              controller.errorMessage.value.isEmpty
                  ? !controller.isReady.value
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Container()
                  : Center(
                child: ContenedorDesingWidget(
                  child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      child: Text(
                        controller.errorMessage.value,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red.withOpacity(0.7)),
                      )),
                  margin: EdgeInsets.all(10),
                  anchoPorce: 80,
                ),
              )
            ],
          ),
        ));
  }


   Widget getBtnCustomIcon(
      {required GestureTapCallback ontap,
        required double size,
        required Color colorIcon,
        required Color colorRelleno,
        required IconData icon}) {
    return CupertinoButton(
        borderRadius: BorderRadius.circular(20),
        padding: EdgeInsets.all(1),
        onPressed: ontap,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                  border: Border.all(color: colorIcon, width: 0.5),
                  color: colorRelleno,
                  borderRadius: BorderRadius.circular(50)),
              child: Container(
                child: size > 38
                    ? Icon(
                  icon,
                  color: colorRelleno,
                  size: size - 20,
                )
                    : Container(),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: colorIcon, borderRadius: BorderRadius.circular(50)),
              ),
            )));
  }
}
