import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/core/app_config.dart';
import '../../../../../app/core/utils/photo_helper.dart';
import '../../../../../app/core/utils/responsiveUtil.dart';
import '../../../../../app/core/values/app_colors.dart';
import '../../../../../app/core/values/app_images.dart';
import '../../../../../app/presentation/widgets/custom_app_widgets.dart';


class RegistrarRecintoWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controllerNombreRecinto;

  /// Aquí recibimos el Rx del controlador
  final Rx<GaleryCameraModel?> foto;

  final VoidCallback onGuardar;

  const RegistrarRecintoWidget({
    super.key,
    required this.formKey,
    required this.controllerNombreRecinto,
    required this.foto,
    required this.onGuardar,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _mensajeInformacion(),

          const SizedBox(height: 20),

          _fotoWidget(responsive),

          const SizedBox(height: 20),

          ImputTextWidget(
            maxLength: 200,
            keyboardType: TextInputType.multiline,
            controller: controllerNombreRecinto,
            icono: const Icon(
              Icons.edit,
              color: AppColors.colorIcons,
            ),
            label: "Nombre del recinto",
            fonSize: responsive.diagonalP(
              AppConfig.tamTextoTitulo,
            ),
            validar: (value) {
              if (value == null || value.trim().length < 5) {
                return "Ingrese el nombre del recinto";
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          BtnIconWidget(
            icon: Icons.save,
            titulo: "GUARDAR",
            onPressed: () {
              FocusScope.of(context).unfocus();

              if (formKey.currentState!.validate()) {
                onGuardar();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _mensajeInformacion() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F8FF),
        borderRadius: BorderRadius.circular(15),
        border: const Border(
          left: BorderSide(
            color: AppColors.colorAzul,
            width: 5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.colorAzul,
            child: Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  height: 1.4,
                ),
                children: [
                  TextSpan(
                    text: "Importante\n",
                    style: TextStyle(
                      color: AppColors.colorAzul,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text:
                    "Tome una fotografía del afiche oficial del recinto electoral donde se visualice claramente el nombre del recinto.",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fotoWidget(ResponsiveUtil responsive) {
    return Obx(() {
      return Column(
        children: [
          TituloTextWidget(
            title: foto.value == null
                ? "Registrar una Imagen"
                : "Cambiar la Imagen",
          ),

          SizedBox(height: responsive.altoP(1)),

          InkWell(
            onTap: () async {
              final ahora = DateTime.now();

              String dosDigitos(int n) => n.toString().padLeft(2, '0');

              final nombre =
                  "ImgRecinto_${ahora.year}"
                  "${dosDigitos(ahora.month)}"
                  "${dosDigitos(ahora.day)}_"
                  "${dosDigitos(ahora.hour)}"
                  "${dosDigitos(ahora.minute)}"
                  "${dosDigitos(ahora.second)}.jpg";

              foto.value = await PhotoHelper.getDesingPictureGaleryOrCamera(
                titleImg: nombre,
                initPeticion: (_) {},
              );
            },
            child: Image.asset(
              AppImages.icon_camara,
              width: responsive.altoP(6),
            ),
          ),

          if (foto.value != null) ...[
            SizedBox(height: responsive.altoP(2)),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(
                foto.value!.imageFile,
                fit: BoxFit.cover,
                width: responsive.altoP(34),
                height: responsive.altoP(30),
              ),
            ),
          ],
        ],
      );
    });
  }
}