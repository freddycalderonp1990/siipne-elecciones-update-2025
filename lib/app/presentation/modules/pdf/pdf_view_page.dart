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
              Expanded(
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(AppConfig.radioBotones),
                    child: InkWell(
                        onTap: () {
                          UtilidadesUtil.compartirPdf(controller.path.value);
                        },
                        borderRadius: BorderRadius.circular(
                            AppConfig.radioBotones),
                        child: Row(

                            children: [
                              Flexible(child: Text("Compartir",style: TextStyle(color: Colors.white),),),
                              SizedBox(width: 2,),
                              Icon(Icons.share,color: Colors.white,)

                            ])),
                  ))
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
                child: getDesingError(),
              )
            ],
          ),
        ));
  }

  getDesingError(){
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color:DialogosAwesome.colorError, width: 3),
        ),
        child: Center(
          child: Image.asset(
            DialogosAwesome.imgDefault,
            width: 60, // Ajusta el tamaño para que no se recorte
            height: 60,
            fit: BoxFit.contain, // Mantiene proporciones
          ),
        ),
      ),
     
   SizedBox(height: 10,),

     Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            child: Text(
              controller.errorMessage.value,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: DialogosAwesome.colorError),
            )),


    ],);
  }
}
