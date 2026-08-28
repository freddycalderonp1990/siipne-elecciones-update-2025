class SecurityException implements Exception {

  final String message;

  const SecurityException(this.message);

  @override
  String toString() {
    return message;
  }
}