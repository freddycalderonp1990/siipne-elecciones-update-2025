part of '../pages.dart';

class ShowNotificationPage extends GetView<ShowNotificationController> {
  const ShowNotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return WorkAreaPageWidget(
      mostrarBtnAtras: true,

      title: "NOTIFICACIONES",
      contenido: Obx(() => getLista()),

      peticionServer: controller.peticionServerState,
    );
  }




getLista(){
  final responsive = ResponsiveUtil();



    Widget wg= ListView.builder(
      itemCount:controller. notificationService. lista.length,
      itemBuilder: (_, index) {

        final notification =controller.notificationService. lista[index];

        return NotificationItemWidget(
          notification: notification,
          onMarcarLeida:()=> controller.marcarComoLeida(index) ,
          onEliminar: ()=> controller.eliminarNotificacion(index),
          onTapVer: () {

            controller.marcarComoLeida(index);

            // Abrir pantalla de detalle
          },
        );
      },
    );

    return wg;
}
}
