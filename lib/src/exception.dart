/// Exception for internal Camus Iconfont usage
class SvgToFlutterUsageException implements Exception {
  /// Constructor of usage exception
  const SvgToFlutterUsageException([this.message = '']);

  /// Message of the exception
  final String message;

  @override
  String toString() => 'SVG to Font usage Exception: $message';
}

/// Exception for internal Camus Iconfont
class SvgToFlutterException implements Exception {
  /// Constructor of  exception
  const SvgToFlutterException([this.message = '']);

  /// Message of the exception
  final String message;

  @override
  String toString() => 'SVG to Font Exception: $message';
}
