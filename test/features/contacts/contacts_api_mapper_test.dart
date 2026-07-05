import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/data/models/user_relationship.dart';
import 'package:pokidoki/features/contacts/data/api/contacts_api_mapper.dart';
import 'package:pokidoki/features/contacts/data/api/contacts_api_models.dart';

void main() {
  test('maps relationship without blocked-by-them field', () {
    const dto = RelationshipDto(
      isContact: false,
      incomingRequestId: null,
      outgoingRequestId: 'req-1',
      blockedByMe: false,
      canSendRequest: false,
    );

    final relationship = mapRelationshipDto(dto);

    expect(relationship.outgoingRequestId, 'req-1');
    expect(relationship.canSendRequest, isFalse);
    expect(relationship, isA<UserRelationship>());
  });

  test('maps contact request direction', () {
    const dto = ContactRequestDto(
      userId: 'user-1',
      username: 'alice',
      displayName: 'Alice',
      publicId: 'PKD-ABCD-EFGH',
      avatarUrl: null,
      avatarInitials: 'A',
      requestId: 'req-1',
      direction: 'incoming',
      createdAt: '2026-07-05T00:00:00.000Z',
    );

    final request = mapContactRequestDto(dto);

    expect(request.id, 'req-1');
    expect(request.direction.name, 'incoming');
  });
}
