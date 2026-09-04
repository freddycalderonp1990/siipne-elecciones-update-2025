part of '../controllers.dart';

class PdfViewController extends GetxController {
  RxString path = "".obs;

  RxInt pages = 0.obs;
  RxInt currentPage = 0.obs;
  RxBool isReady = false.obs;
  RxString errorMessage = ''.obs;
  RxString title = ''.obs;




  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  var peticionServerState = false.obs;

  @override
  void onInit() {
    _loadDatos();
    super.onInit();
  }


  _loadDatos() async {
    var data = Get.arguments;
    if (data != null  && data.containsKey('pathPdf') && data['pathPdf'] != null) {

      peticionServerState(true);


      path.value=data['pathPdf'];

      peticionServerState(false);
    } else {
      errorMessage.value = "No se recibió el parámetro 'pathPdf'. Por favor, verifique e intente nuevamente.";

    }
  }


  onRender(_pages) {
    pages.value = _pages;
    isReady(true);
  }

  onError(error) {

    if(ApiConfig.AmbienteUrl!=Ambiente.PROD){
      errorMessage.value = error.toString();
      print("Error Pdf: ${errorMessage.value}");
    }{
      errorMessage.value =
      "No se pudo cargar el archivo contacte con el administrador. Es posible que el archivo no se encuentre cargado de manera correcta.";

    }

  }

  onPageError(page, error) {
    if(ApiConfig.AmbienteUrl!=Ambiente.PROD){
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
