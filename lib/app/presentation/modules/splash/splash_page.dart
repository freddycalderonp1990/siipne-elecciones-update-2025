part of '../pages.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder:
          (_) => Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Image.asset(
                    AppImages.splash,
                    fit:
                        BoxFit
                            .cover, // Esto asegura que la imagen ocupe toda la pantalla
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Obx(
                        () => CargandoWidget(
                      mostrar: controller.peticionServerState.value,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
