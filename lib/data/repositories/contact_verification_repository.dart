import '../models/user_profile_preview.dart';

/// Mock-only contact identity resolution for QR and safety-number UI.
///
/// Does not implement production cryptographic verification.
abstract interface class ContactVerificationRepository {
  Future<UserProfilePreview?> resolveQrPayload(String payload);

  Future<List<String>> getSafetyNumberGroups(String userId);

  String currentUserQrPayload();

  String? payloadForUser(String userId);
}
