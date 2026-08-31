class SecurityException implements Exception {
  final String message;
  final dynamic cause;

  SecurityException(this.message, {this.cause});

  @override
  String toString() => 'SecurityException: $message';
}