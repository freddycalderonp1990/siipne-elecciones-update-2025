

class VerificarUpdateRequest {
  final String nemonico;
  final int versionCodeApp;
  final bool isAndroid;

  VerificarUpdateRequest({
    required this.versionCodeApp,
    required this.isAndroid,
    required this.nemonico,
  });

  Map<String, dynamic> toJson() {
    return {
      "nemonico": nemonico,
      "versionCodeApp": versionCodeApp,
      "isAndroid": isAndroid,
    };
  }
}
