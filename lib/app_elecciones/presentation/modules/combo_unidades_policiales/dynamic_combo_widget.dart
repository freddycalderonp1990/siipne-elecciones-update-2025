part of '../pages.dart';

class DynamicComboWidget extends StatelessWidget {
  final DynamicComboController controller;
  final ResponsiveUtil responsive;

  const DynamicComboWidget({
    Key? key,
    required this.controller,
    required this.responsive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0.0, 0.1),
            end: Offset.zero,
          ).animate(animation);
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(position: offsetAnimation, child: child),
          );
        },
        child: Column(
          key: ValueKey(controller.niveles.length),
          children: List.generate(controller.niveles.length, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: responsive.altoP(0.4)),
              child: ComboBusqueda(
                selectValue: controller.seleccionados[index],
                showClearButton: true,
                datos: controller.niveles[index],
                displayField: (item) => item.descripcion,
                searchHint: "Seleccione",
                textSeleccioneUndato: "Seleccione una opción",
                complete: (value) async {
                  if (value != null) {
                    controller.seleccionados[index] = value;
                    await controller.cargarSiguienteNivel(value, index);
                  } else {
                    controller.reiniciarDesdeNivel(index);
                  }
                },
              ),
            );
          }),
        ),
      );
    });
  }
}
