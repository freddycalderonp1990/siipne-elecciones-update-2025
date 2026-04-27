import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_images.dart';


class SnackbarService {
  static void show({
    required String titulo,
    required String subtitulo,
    required String imagenDerecha, // puede ser URL o base64
    String iconoIzquierdo = AppImages.imgIconApp,
    Duration duracion = const Duration(seconds: 5),
  }) {
    Widget imagenDerechaWidget;

    // Verificar si es una URL (http o https)
    if (imagenDerecha.startsWith('http')) {
      imagenDerechaWidget = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imagenDerecha,
          height: 60,
          width: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.broken_image, color: Colors.white54),
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const SizedBox(
              height: 60,
              width: 60,
              child: Center(
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              ),
            );
          },
        ),
      );
    } else {
      Uint8List? imagenBytes;
      try {
        imagenBytes = base64Decode(imagenDerecha);
      } catch (_) {
        imagenBytes = null;
      }

      imagenDerechaWidget = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: imagenBytes != null
            ? Image.memory(
          imagenBytes,
          height: 60,
          width: 60,
          fit: BoxFit.cover,
        )
            : const Icon(Icons.broken_image, color: Colors.white54),
      );
    }

    Get.snackbar(
      '',
      '',
      titleText: Center(
        child: Text(
          titulo,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
            shadows: [
              Shadow(
                color: Colors.white,
                offset: Offset(0, 1),
                blurRadius: 1,
              ),
            ],
          ),
        ),
      ),
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              iconoIzquierdo,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              subtitulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(width: 12),
          imagenDerechaWidget,
        ],
      ),
      snackPosition: SnackPosition.TOP,
      backgroundGradient: const LinearGradient(
        colors: [
          Color(0xFF6177A5), // Azul profundo
          Color(0xFFDAD8D8), // Gris institucional
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: 20,
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      padding: const EdgeInsets.all(16),
      boxShadows: [
        BoxShadow(
          color: Colors.white,
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
      overlayBlur: 2.5,
      animationDuration: const Duration(milliseconds: 400),
      forwardAnimationCurve: Curves.easeOutQuart,
      reverseAnimationCurve: Curves.easeInBack,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      duration: duracion,
      shouldIconPulse: false,
    );
  }
}
