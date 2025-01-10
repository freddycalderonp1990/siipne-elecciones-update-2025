part of 'request.dart';
class UpdateAppRequest {
  final int versionCodeApp;

  final bool isAndroid;

  UpdateAppRequest({ required this.isAndroid, required this.versionCodeApp,
   });
}
