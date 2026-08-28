class SecurityResult {
  final bool isSecure;
  final bool isRooted;
  final bool isHooked;
  final bool isDebuggerAttached;
  final bool isEmulator;
  final String message;

  const SecurityResult({
    required this.isSecure,
    required this.isRooted,
    required this.isHooked,
    required this.isDebuggerAttached,
    required this.isEmulator,
    required this.message,
  });

  factory SecurityResult.fromMap(Map<dynamic, dynamic> json) {
    return SecurityResult(
      isSecure: json["isSecure"] ?? true,
      isRooted: json["isRooted"] ?? false,
      isHooked: json["isHooked"] ?? false,
      isDebuggerAttached: json["isDebuggerAttached"] ?? false,
      isEmulator: json["isEmulator"] ?? false,
      message: json["message"] ?? "",
    );
  }
}