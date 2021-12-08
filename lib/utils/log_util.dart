
import 'package:logger/logger.dart';

class LogUtil{
  static final _logger = Logger();

  /// Log a message at level [Level.verbose].
  static v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.v(message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  static d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  static i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  static w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  static e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }

}