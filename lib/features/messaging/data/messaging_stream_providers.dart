import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/conversation.dart';
import '../../../data/models/message.dart';
import 'messaging_providers.dart';

final conversationsWatchProvider = StreamProvider<List<Conversation>>((ref) {
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return Stream.value(const []);
  }
  final asyncRepo = ref.watch(offlineConversationsRepositoryProvider);
  return asyncRepo.maybeWhen(
    data: (repository) => repository.watchConversations(),
    orElse: () => const Stream.empty(),
  );
});

final messagesWatchProvider = StreamProvider.family<List<ChatMessage>, String>((
  ref,
  conversationId,
) {
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return Stream.value(const []);
  }
  final asyncRepo = ref.watch(offlineConversationsRepositoryProvider);
  return asyncRepo.maybeWhen(
    data: (repository) => repository.watchMessages(conversationId),
    orElse: () => const Stream.empty(),
  );
});
