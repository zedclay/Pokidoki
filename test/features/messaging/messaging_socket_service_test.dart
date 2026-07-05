import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/features/messaging/data/realtime/messaging_socket_models.dart';
import 'package:pokidoki/features/messaging/data/realtime/messaging_socket_service.dart';

void main() {
  group('FakeMessagingSocketService', () {
    test('connect requires access token', () async {
      final service = FakeMessagingSocketService();
      await service.connect(accessToken: '', apiBaseUrl: 'http://127.0.0.1:3000/api/v1');
      expect(service.status, MessagingSocketStatus.disconnected);
    });

    test('connects with access token and never stores refresh token', () async {
      final service = FakeMessagingSocketService();
      await service.connect(
        accessToken: 'access-only',
        apiBaseUrl: 'http://127.0.0.1:3000/api/v1',
      );
      expect(service.status, MessagingSocketStatus.connected);
    });

    test('disconnect clears joined conversation', () async {
      final service = FakeMessagingSocketService();
      await service.connect(
        accessToken: 'access-only',
        apiBaseUrl: 'http://127.0.0.1:3000/api/v1',
      );
      await service.joinConversation('conv-1');
      await service.disconnect();
      expect(service.status, MessagingSocketStatus.disconnected);
    });

    test('deduplicates emitted server events by id', () async {
      final service = FakeMessagingSocketService();
      final events = <String>[];
      service.messageCreatedStream.listen((event) {
        events.add(event.rawMessage['id'] as String);
      });

      const payload = {
        'id': 'm-1',
        'conversationId': 'conv-1',
        'body': 'Hi',
        'type': 'TEXT',
        'createdAt': '2026-07-05T10:00:00.000Z',
        'sender': {'userId': 'user-b', 'displayName': 'Peer', 'username': 'peer'},
        'senderStatus': 'sent',
      };

      service.emitMessageCreated(payload);
      service.emitMessageCreated(payload);
      await Future<void>.delayed(Duration.zero);

      expect(events, ['m-1']);
    });
  });
}
