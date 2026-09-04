class SecurityResult {
  final bool detected;
  final String type;
  final String message;
  final List<String> details;

  const SecurityResult({
    required this.detected,
    required this.type,
    required this.message,
    this.details = const [],
  });

  factory SecurityResult.fromMap(Map<dynamic, dynamic> map) {
    return SecurityResult(
      detected: map['detected'] == true,
      type: map['type']?.toString() ?? 'UNKNOWN',
      message: map['message']?.toString() ?? '',
      details: map['details'] is List
          ? List<String>.from(map['details'].map((e) => e.toString()))
          : [],
    );
  }

  bool get isSecure => !detected;

  @override
  String toString() {
    return 'SecurityResult(detected: $detected, type: $type, message: $message, details: $details)';
  }
}