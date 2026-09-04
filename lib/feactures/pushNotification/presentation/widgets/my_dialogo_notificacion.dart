import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/models_push_notification.dart';


class TuDialogoNotificacion extends StatelessWidget {
  final NotificationModel notification;

  const TuDialogoNotificacion({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.notifications,
              color: Colors.white,
              size: 35,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            notification.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 250,
            ),
            child: SingleChildScrollView(
              child: Text(
                notification.body,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: (){
                Get.back();
              },
              icon: const Icon(Icons.check),
              label: const Text("Aceptar"),
            ),
          )

        ],
      ),
    );
  }
}