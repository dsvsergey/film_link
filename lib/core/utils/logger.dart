import 'dart:developer' as dev;
import 'package:logging/logging.dart';

/// Application logger utility
class AppLogger {
  static final Map<String, Logger> _loggers = {};
  
  static void init() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      dev.log(
        record.message,
        time: record.time,
        level: record.level.value,
        name: record.loggerName,
        error: record.error,
        stackTrace: record.stackTrace,
      );
    });
  }
  
  static Logger getLogger(String name) {
    return _loggers.putIfAbsent(name, () => Logger(name));
  }
}
