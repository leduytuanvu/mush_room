import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger();

  static void i(String message, [Object? error, StackTrace? stackTrace]) =>
      _logger.i(message, error, stackTrace);

  static void d(String message, [Object? error, StackTrace? stackTrace]) =>
      _logger.d(message, error, stackTrace);

  static void e(String message, [Object? error, StackTrace? stackTrace]) =>
      _logger.e(message, error, stackTrace);
}