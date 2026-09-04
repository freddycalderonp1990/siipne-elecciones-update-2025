part of '../pages.dart';

class DynamicComboWidget extends StatelessWidget {
  final DynamicComboController controller;
  final ResponsiveUtil responsive;

  const DynamicComboWidget({
    Key? key,
    required this.controller,
    required this.responsive,
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return AnimatedSwitcher(
        duration:const Duration(milliseconds:250),
        transitionBuilder:(child,animation){
          final offsetAnimation=Tween<Offset>(
            begin:const Offset(0.0,0.06),
            end:Offset.zero,
          ).animate(
            CurvedAnimation(
              parent:animation,
              curve:Curves.easeOut,
            ),
          );

          return FadeTransition(
            opacity:animation,
            child:SlideTransition(
              position:offsetAnimation,
              child:child,
            ),
          );
        },
        child:controller.niveles.isEmpty
            ?_sinNiveles()
            :Column(
          key:ValueKey(controller.niveles.length),
          crossAxisAlignment:CrossAxisAlignment.stretch,
          children:List.generate(
            controller.niveles.length,
                (index){
              final bool ultimoNivel=index==controller.niveles.length-1;

              return Padding(
                padding:EdgeInsets.only(
                  bottom:ultimoNivel?0:responsive.altoP(.8),
                ),
                child:_comboNivel(index),
              );
            },
          ),
        ),
      );
    });
  }

  Widget _comboNivel(int index) {
    return ComboBusqueda(
      selectValue:controller.seleccionados[index],
      showClearButton:true,
      datos:controller.niveles[index],
      displayField:(item)=>item.descripcion,
      searchHint:"Seleccione",
      textSeleccioneUndato:"Seleccione una opción",
      complete:(value) async {
        if(value!=null){
          controller.seleccionados[index]=value;
          await controller.cargarSiguienteNivel(value,index);
        }else{
          controller.reiniciarDesdeNivel(index);
        }
      },
    );
  }

  Widget _sinNiveles() {
    return const SizedBox.shrink();
  }
}