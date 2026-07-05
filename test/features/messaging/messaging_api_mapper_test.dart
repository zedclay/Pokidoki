import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/data/models/message.dart';
import 'package:pokidoki/features/messaging/data/api/messaging_api_mapper.dart';
import 'package:pokidoki/features/messaging/data/api/messaging_api_models.dart';

void main() {
  group('messaging_api_mapper', () {
    test('maps conversation with outgoing preview', () {
      final dto = ConversationDto.fromJson({
        'id': 'conv-1',
        'type': 'DIRECT',
        'otherParticipant': {
          'userId': 'user-b',
          'displayName': 'Amira',
          'username': 'amira',
          'publicId': 'PKD-B',
          'avatarInitials': 'AM',
        },
        'createdAt': '2026-07-05T09:00:00.000Z',
        'updatedAt': '2026-07-05T10:00:00.000Z',
        'lastMessageAt': '2026-07-05T10:00:00.000Z',
        'unreadCount': 2,
        'isMuted': false,
        'canSend': true,
        'isUnavailable': false,
        'disappearingSeconds': 3600,
        'lastMessage': {
          'id': 'm-1',
          'body': 'Hello',
          'type': 'TEXT',
          'senderId': 'user-a',
          'createdAt': '2026-07-05T10:00:00.000Z',
        },
      });

      final conversation = mapConversationDto(dto, currentUserId: 'user-a');
      expect(conversation.id, 'conv-1');
      expect(conversation.peerId, 'user-b');
      expect(conversation.isOutgoingPreview, isTrue);
      expect(conversation.disappearingDurationHours, 1);
      expect(conversation.isBlocked, isFalse);
    });

    test('maps message delivery status for outgoing messages', () {
      final dto = MessageDto.fromJson({
        'id': 'm-2',
        'conversationId': 'conv-1',
        'clientMessageId': 'client-1',
        'body': 'Ping',
        'type': 'TEXT',
        'createdAt': '2026-07-05T10:01:00.000Z',
        'sender': {
          'userId': 'user-a',
          'displayName': 'Self',
          'username': 'self',
          'publicId': 'PKD-A',
          'avatarInitials': 'SE',
        },
        'senderStatus': 'delivered',
      });

      final message = mapMessageDto(dto, currentUserId: 'user-a');
      expect(message.isOutgoing, isTrue);
      expect(message.deliveryStatus, MessageDeliveryStatus.delivered);
      expect(message.clientMessageId, 'client-1');
    });

    test('reverses paginated message order for chat display', () {
      final page = mapMessagePage(
        PaginatedMessagesDto.fromJson({
          'items': [
            {
              'id': 'm-new',
              'conversationId': 'conv-1',
              'clientMessageId': 'c-new',
              'body': 'New',
              'type': 'TEXT',
              'createdAt': '2026-07-05T10:02:00.000Z',
              'sender': {
                'userId': 'user-b',
                'displayName': 'Peer',
                'username': 'peer',
                'publicId': 'PKD-B',
                'avatarInitials': 'PE',
              },
              'senderStatus': 'sent',
            },
            {
              'id': 'm-old',
              'conversationId': 'conv-1',
              'clientMessageId': 'c-old',
              'body': 'Old',
              'type': 'TEXT',
              'createdAt': '2026-07-05T09:00:00.000Z',
              'sender': {
                'userId': 'user-b',
                'displayName': 'Peer',
                'username': 'peer',
                'publicId': 'PKD-B',
                'avatarInitials': 'PE',
              },
              'senderStatus': 'sent',
            },
          ],
          'hasMore': false,
        }),
        currentUserId: 'user-a',
      );

      expect(page.items.first.id, 'm-old');
      expect(page.items.last.id, 'm-new');
    });
  });
}
