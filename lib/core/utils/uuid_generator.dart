import 'package:uuid/uuid.dart';

/// Generate a unique UUID
String generateUuid() {
  const uuid = Uuid();
  return uuid.v4();
}
