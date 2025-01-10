part of '../controllers.dart';

class PdfViewController extends GetxController {
  RxString path = "".obs;

  RxInt pages = 0.obs;
  RxInt currentPage = 0.obs;
  RxBool isReady = false.obs;
  RxString errorMessage = ''.obs;
  RxString title = ''.obs;

  final LocalStoreImpl _LocalStoreImpl = Get.find<LocalStoreImpl>();


  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  var peticionServerState = false.obs;

  @override
  void onInit() {
    _loadDatos();
    super.onInit();
  }


  _loadDatos() async {
    var data = Get.arguments;


      if (data != null && data.containsKey('pdfBase64')&& data.containsKey('nameFile')) {

      peticionServerState(true);


      String pdfBase64=data['pdfBase64'];
      String nameFile=data['nameFile'];
   File file=  await createFileFromBase64(pdfBase64,nameFile);

      path.value=file.path;

      peticionServerState(false);
    } else {
      errorMessage.value = "Error al cargar el PDF";
      /*DialogosAwesome.getError(
          descripcion: "Error al cargar el PDF",
      );*/
    }
  }



  onRender(_pages) {
    pages.value = _pages;
    isReady(true);
  }

  onError(error) {
    if (AppConfig.AmbienteUrl != Ambiente.produccion &&
        AppConfig.AmbienteUrl != Ambiente.prueba) {
      errorMessage.value = error.toString();

      errorMessage.value =
      "No se pudo cargar el archivo contacte con el administrador. Es posible que el archivo no se encuentre cargado de manera correcta.";

      print("Error Pdf: ${errorMessage.value}");
    } else {
      errorMessage.value =
          "No se pudo cargar el archivo contacte con el administrador. Es posible que el archivo no se encuentre cargado de manera correcta.";
    }
  }

  onPageError(page, error) {
    if (AppConfig.AmbienteUrl != Ambiente.produccion &&
        AppConfig.AmbienteUrl != Ambiente.prueba) {
      errorMessage.value = '$page: ${error.toString()}';
      print('$page: ${error.toString()}');
    } else {
      errorMessage.value =
          "No se pudo cargar el archivo contacte con el administrador. Es posible que el archivo no se encuentre cargado de manera correcta.";
    }
  }

  onPageChanged(int? page, int? total) {
    print('page change: $page/$total');

    if (page != null) {
      currentPage.value = page;
    }
  }

  Future<File> getFileFromAsset(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationSupportDirectory();
      File file = File("${dir.path}/mi_archivo.pdf");
      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception("Error al abrir el archivo");
    }
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }


  Future<File> createFileFromBase64(String base64Pdf,String nameFile) async {
    final decodedBytes = base64Decode(base64Pdf);
    final tempDir = await Directory.systemTemp.createTemp();
    final tempFile = File("${tempDir.path}/${nameFile}.pdf");
    return tempFile.writeAsBytes(decodedBytes);
  }


  @override
  void onReady() {
    super.onReady();
  }
}
