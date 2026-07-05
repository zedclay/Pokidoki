import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

/// Generates a 256-bit database encryption key.
class MessagingDatabaseKeyGenerator {
  const MessagingDatabaseKeyGenerator._();

  static String generateHexKey() {
    final random = Random.secure();
    final bytes = Uint8List(32);
    for (var i = 0; i < bytes.length; i++) {
      bytes[i] = random.nextInt(256);
    }
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  static String escapeForPragma(String hexKey) {
    if (!RegExp(r'^[0-9a-fA-F]{64}$').hasMatch(hexKey)) {
      throw ArgumentError('Invalid database key format');
    }
    return "'$hexKey'";
  }
}

String? decodeMetadataValue(String? raw) => raw;

String encodeMetadataValue(String value) =>
    base64Url.encode(utf8.encode(value));

String? decodeMetadataString(String? encoded) {
  if (encoded == null || encoded.isEmpty) {
    return null;
  }
  return utf8.decode(base64Url.decode(encoded));
}
