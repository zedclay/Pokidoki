import '../models/user_profile_preview.dart';
import '../repositories/contact_verification_repository.dart';
import 'mock_sample_data.dart';

class MockContactVerificationRepository
    implements ContactVerificationRepository {
  const MockContactVerificationRepository();

  @override
  String currentUserQrPayload() => MockSampleData.currentUserQrPayload;

  @override
  String? payloadForUser(String userId) {
    if (userId == MockSampleData.amiraUserId) {
      return MockSampleData.amiraQrPayload;
    }
    return null;
  }

  @override
  Future<UserProfilePreview?> resolveQrPayload(String payload) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (payload != MockSampleData.amiraQrPayload) {
      return null;
    }
    return const UserProfilePreview(
      id: MockSampleData.amiraUserId,
      displayName: 'Amira Mansouri',
      username: 'amira',
      pokidokiId: 'PKD-AM84-2LX7',
      relationship: ProfileRelationship.contact,
      bio: 'Designer, traveller, and coffee lover.',
      sharedContext: 'Recognized from Pokidoki QR code',
    );
  }

  @override
  Future<List<String>> getSafetyNumberGroups(String userId) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (userId == MockSampleData.amiraUserId) {
      return MockSampleData.amiraSafetyNumberGroups;
    }
    return const [
      '00000',
      '00000',
      '00000',
      '00000',
      '00000',
      '00000',
      '00000',
      '00000',
    ];
  }
}
