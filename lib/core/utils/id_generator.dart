import 'package:uuid/uuid.dart';
class IdGenerator {
  static final _uuid = Uuid();
  
  /// Generates compact UUID v4 (32 chars without dashes)
  static String generateCompactId({String prefix = ''}) {
    return '$prefix${_uuid.v4().replaceAll('-', '')}';
  }

  /// Generates short ID (first 8 chars of UUID)
  static String generateShortId({String prefix = ''}) {
    return '$prefix${_uuid.v4().substring(0, 8)}';
  }
}