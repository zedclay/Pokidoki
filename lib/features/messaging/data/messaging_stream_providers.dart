import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/conversation.dart';
import '../../../data/models/message.dart';
import 'messaging_providers.dart';

Stream<List<Conversation>> _watchConversations(Ref ref) async* {
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    yield const [];
    return;
  }
  try {
    final repo = await ref.watch(offlineConversationsRepositoryProvider.future);
    yield* repo.watchConversations();
  } on Object {
    yield const [];
  }
}

Stream<List<ChatMessage>> _watchMessages(
  Ref ref,
  String conversationId,
) async* {
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    yield const [];
    return;
  }
  try {
    final repo = await ref.watch(offlineConversationsRepositoryProvider.future);
    yield* repo.watchMessages(conversationId);
  } on Object {
    yield const [];
  }
}

final conversationsWatchProvider = StreamProvider<List<Conversation>>(
  (ref) => _watchConversations(ref),
);

final messagesWatchProvider = StreamProvider.family<List<ChatMessage>, String>(
  (ref, conversationId) => _watchMessages(ref, conversationId),
);
