import 'package:flutter/material.dart';

import '../../../../../feactures/pushNotification/data/models/models_push_notification.dart';
import '../../../../core/values/app_colors.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationLocalModel notification;

  /// Abrir detalle
  final VoidCallback onTapVer;

  /// Marcar como leída
  final VoidCallback? onMarcarLeida;

  /// Eliminar
  final VoidCallback? onEliminar;

  const NotificationItemWidget({
    Key? key,
    required this.notification,
    required this.onTapVer,
    this.onMarcarLeida,
    this.onEliminar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),

      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.92),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.colorAzul,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ICONO
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffDDF8FA),
                  ),
                  child: Icon(
                    notification.leida
                        ? Icons.notifications_none_rounded
                        : Icons.notifications_active_rounded,
                    color: notification.leida
                        ? Colors.grey
                        : AppColors.colorIcons,
                    size: 30,
                  ),
                ),

                Positioned(
                  right: 0,
                  top: 0,
                  child: notification.leida
                      ? Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 13,
                      color: Colors.white,
                    ),
                  )
                      : Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 15),

            /// INFORMACIÓN
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: notification.leida
                          ? Colors.black87
                          : const Color(0xff003C71),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    notification.body,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.35,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(
                        notification.leida
                            ? Icons.check_circle
                            : Icons.fiber_manual_record,
                        size: 14,
                        color: notification.leida
                            ? Colors.green
                            : Colors.blue,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        notification.leida ? "Leída" : "Nueva",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: notification.leida
                              ? Colors.green
                              : Colors.blue,
                        ),
                      ),

                      const Spacer(),

                      Icon(
                        Icons.apps_rounded,
                        size: 15,
                        color: Colors.grey.shade600,
                      ),

                      const SizedBox(width: 4),

                      Flexible(
                        child: Text(
                          notification.appName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// MENU
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.grey,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onSelected: (value) {
                switch (value) {
                  case "ver":
                    onTapVer?.call();
                    break;

                  case "leida":
                    onMarcarLeida?.call();
                    break;

                  case "eliminar":
                    onEliminar?.call();
                    break;
                }
              },
              itemBuilder: (context) {
                final items = <PopupMenuEntry<String>>[];





                items.add(
                  const PopupMenuItem<String>(
                    value: "ver",
                    child: Row(
                      children: [
                        Icon(Icons.visibility_outlined),
                        SizedBox(width: 10),
                        Text("Ver notificación"),
                      ],
                    ),
                  ),
                );

                if (!notification.leida) {
                  items.add(
                    const PopupMenuItem<String>(
                      value: "leida",
                      child: Row(
                        children: [
                          Icon(
                            Icons.done_all,
                            color: Colors.green,
                          ),
                          SizedBox(width: 10),
                          Text("Marcar como leída"),
                        ],
                      ),
                    ),
                  );
                }

                items.add(
                  const PopupMenuItem<String>(
                    value: "eliminar",
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Text("Eliminar"),
                      ],
                    ),
                  ),
                );

                return items;
              },
            ),
          ],
        ),
      ),
    );
  }
}