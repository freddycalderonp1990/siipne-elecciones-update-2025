import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:io';

import 'dart:math' as Math;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../../app/core/utils/my_date.dart';
import '../../../../../app/core/utils/responsiveUtil.dart';
import '../../../../../app/core/utils/utilidadesUtil.dart';
import '../../../../../app_elecciones/core/values/siipne_images.dart';
import '../../../../../app_elecciones/presentation/widgets/customWidgets.dart';

import '../app_config.dart';
import '../values/app_colors.dart';
import '../values/app_images.dart';

class PhotoHelper {

  static Future<GaleryCameraModel?> getDesingPictureGaleryOrCamera({required String titleImg}) async {
    final Completer<GaleryCameraModel?> completer = Completer();

    AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: Get.context!,
      dialogType: DialogType.info,
      headerAnimationLoop: false,
      customHeader: Container(
        child: Image.asset(SiipneImages.imgIconD),
      ),
      animType: AnimType.scale,
      title: "Registre una Fotografia",
      btnCancel: BtnIconWidget(
        onPressed: () async {
          GaleryCameraModel? data = await getImageGallery(titleImg);
          Get.back();
          completer.complete(data);  // Retorna la data al completar
       // Cierra el diálogo
        },
        titulo: "Galería",
      ),
      btnOk: BtnIconWidget(
        onPressed: () async {
          GaleryCameraModel? data = await getImageCamera(titleImg);
          Get.back(); // Cierra el diálogo
          completer.complete(data); // Retorna la data al completar

        },
        titulo: "Cámara",
      ),
      desc: "Seleccione una Imagen o Tome una Fotografía",
      showCloseIcon: true,
    ).show();

    return completer.future; // Espera la selección del usuario antes de retornar
  }




  static Future<GaleryCameraModel?> getImageGallery(String title) async {
    final ImagePicker _picker = ImagePicker();

    var imageFile = await _picker.pickImage(source: ImageSource.gallery);

    return getImagenResourse(title: title, imageFile: imageFile);
  }

  static Future<GaleryCameraModel?> getImageCamera(String title) async {
    final ImagePicker _picker = ImagePicker();
    var imageFile = await _picker.pickImage(source: ImageSource.camera);

    return getImagenResourse(title: title, imageFile: imageFile);
  }

  static Future<GaleryCameraModel?> getImagenResourse(
      {required String title, XFile? imageFile}) async {
    int tamImg = 900;

    if (imageFile != null) {
      final path = imageFile.path;
      print("path ${path}");
      final bytes = await File(path).readAsBytes();

      print("los bytes ${bytes}");

      Img.Image? image = Img.decodeImage(bytes);

      // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
      //Img Image thumbnail = copyResize(image, 120);

      return getResizeImg(image: image!, title: title, tamImg: tamImg);
    }
  }

  static Future<GaleryCameraModel> getResizeImg(
      {required String title,
      required Img.Image image,
      required int tamImg,
      bool mejorar = false,
      bool mejorarVertical = false}) async {
    print('Alto: ${image.height}, Ancho ${image.width}');

    int altoImg = image.height;
    int anchoImg = image.width;

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = new Math.Random().nextInt(100000);

    bool isHorizontal = false;
    bool isVertical = false;

    if (altoImg > tamImg || anchoImg > tamImg) {
      print("ingreso");

      //Calculamos la relacion aspecto de la imagen
      double relacionAspecto = anchoImg / altoImg;

      if (mejorar) {
        //se la cambia de valor por que la imagen se mejoro de m,anera ver
        if (altoImg > anchoImg) {
          //Img Vertical

          isVertical = false;
          isHorizontal = true;

          //Obtenemos el nuevo alto
          double altoImgNew = tamImg / relacionAspecto;
          altoImgNew = UtilidadesUtil.redondearDouble(altoImgNew, decimales: 0);

          //Asiganmos los nuevos valores
          anchoImg = tamImg;
          altoImg = altoImgNew.toInt();
          print('Img Horizontal: Nuevo alto ${altoImg}, ancho ${anchoImg}');
        } else {
          //Ancho Mayor
          //Img Horizontal
          isVertical = true;
          isHorizontal = false;

          //Obtenemos el nuevo ancho
          double anchoImgNew = tamImg * relacionAspecto;
          anchoImgNew =
              UtilidadesUtil.redondearDouble(anchoImgNew, decimales: 0);

          //Asiganmos los nuevos valores
          altoImg = tamImg;
          anchoImg = anchoImgNew.toInt();

          print('Img Vertical: Nuevo alto ${altoImg}, ancho ${anchoImg}');
        }
      } else {
        if (altoImg > anchoImg) {
          //Img Vertical

          isVertical = true;
          isHorizontal = false;

          //Obtenemos el nuevo ancho
          double anchoImgNew = tamImg * relacionAspecto;
          anchoImgNew =
              UtilidadesUtil.redondearDouble(anchoImgNew, decimales: 0);

          //Asiganmos los nuevos valores
          altoImg = tamImg;
          anchoImg = anchoImgNew.toInt();

          print('Img Vertical: Nuevo alto ${altoImg}, ancho ${anchoImg}');
        } else {
          //Ancho Mayor
          //Img Horizontal

          isVertical = false;
          isHorizontal = true;

          //Obtenemos el nuevo alto
          double altoImgNew = tamImg / relacionAspecto;
          altoImgNew = UtilidadesUtil.redondearDouble(altoImgNew, decimales: 0);

          //Asiganmos los nuevos valores
          anchoImg = tamImg;
          altoImg = altoImgNew.toInt();
          print('Img Horizontal: Nuevo alto ${altoImg}, ancho ${anchoImg}');
        }
      }
    }

    Img.Image smallerImg =
        Img.copyResize(image, height: altoImg, width: anchoImg);

    String nameImg = "image_" +
        title +
        "_" +
        rand.toString() +
        "_" +
        MyDate.getFechaActual.replaceAll(" ", "_") +
        ".jpg";
    File compressImg = new File("$path/$nameImg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 100));

    return GaleryCameraModel(
        tamImg: tamImg,
        title: title,
        nombreImg: nameImg,
        imageFile: compressImg,
        image: image,
        isHorizontal: isHorizontal,
        isVertical: isVertical);
  }

  static Uint8List? convertStringToUint8List(String? fotoString) {
    try {
      Uint8List? imgDecode = null;
      if (fotoString != null && fotoString != '') {
        final decodedBytes =
            base64Decode(fotoString.toString().split(',').last);
        imgDecode = decodedBytes;
      }
      return imgDecode;
    } catch (e) {
      log('Error al convertir imagen en ${e}');
      return null;
    }
  }
}

class GaleryCameraModel {
  final String title;
  final int tamImg;
  final String nombreImg;
  final File imageFile;
  final Img.Image image;
  final bool isHorizontal;
  final bool isVertical;

  GaleryCameraModel(
      {required this.title,
      required this.tamImg,
      required this.nombreImg,
      required this.imageFile,
      required this.image,
      this.isVertical = false,
      this.isHorizontal = false});

}
