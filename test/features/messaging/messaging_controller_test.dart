import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/data/models/message.dart';
import 'package:pokidoki/features/messaging/data/messaging_providers.dart';

void main() {
  group('MessagingController', () {
    test('optimistic send reconciles with same clientMessageId', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(messagingProvider.notifier);
      await controller.sendTextMessage('conv-amira', 'Retry me');

      final messages = container
          .read(messagingProvider)
          .messagesFor('conv-amira');
      final outgoing = messages.lastWhere((m) => m.body == 'Retry me');
      expect(outgoing.clientMessageId, isNotNull);
      expect(outgoing.deliveryStatus, isNot(MessageDeliveryStatus.failed));
    });

    test('retry preserves client message id', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(messagingProvider.notifier);
      await controller.sendTextMessage('conv-amira', 'Once');

      final sent = container
          .read(messagingProvider)
          .messagesFor('conv-amira')
          .lastWhere((m) => m.body == 'Once');
      final clientId = sent.clientMessageId;
      expect(clientId, isNotNull);

      await controller.retrySend(
        'conv-amira',
        sent.copyWith(deliveryStatus: MessageDeliveryStatus.failed),
      );

      final messages = container
          .read(messagingProvider)
          .messagesFor('conv-amira')
          .where((m) => m.body == 'Once')
          .toList();
      expect(messages.length, 1);
      expect(messages.single.clientMessageId, clientId);
    });
  });
}
