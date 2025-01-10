part of 'request.dart';

class ConfigAppRequest {
  final int versionAndroid;
  final int versionIos;
  final bool compareTimeServer;
  final bool validatePass;
  final bool validateNewPass;
  final String ambiente;

  ConfigAppRequest(
     {
    required this.versionAndroid,
    required this.versionIos,
       required this.compareTimeServer,
       required this.validatePass,
       required this.validateNewPass,
       required this.ambiente,
  });
}
