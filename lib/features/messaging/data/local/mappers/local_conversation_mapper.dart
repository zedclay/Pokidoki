import 'package:drift/drift.dart';

import '../../../../../data/models/conversation.dart';
import '../../../domain/disappearing_duration_mapper.dart';
import '../database/messaging_database.dart';

extension LocalConversationMapper on LocalConversation {
  Conversation toDomain() {
    final hours = DisappearingDurationMapper.secondsToHours(
      disappearingSeconds,
    );
    return Conversation(
      id: conversationId,
      peerId: otherParticipantId,
      peerDisplayName: displayName,
      peerUsername: username,
      updatedAt: updatedAt,
      lastMessagePreview: lastMessagePreview,
      unreadCount: unreadCount,
      isPeerVerified: isPeerVerified,
      isMuted:
          mutedUntil != null && mutedUntil!.isAfter(DateTime.now().toUtc()),
      isBlocked: !canSend,
      canSend: canSend,
      isOutgoingPreview: isOutgoingPreview,
      disappearingDurationHours: hours,
      disappearingMessagesEnabled: hours != null,
    );
  }
}

LocalConversationsCompanion conversationToCompanion(Conversation conversation) {
  final now = DateTime.now().toUtc();
  final seconds = DisappearingDurationMapper.hoursToSeconds(
    conversation.disappearingDurationHours,
  );
  return LocalConversationsCompanion.insert(
    conversationId: conversation.id,
    otherParticipantId: conversation.peerId,
    displayName: conversation.peerDisplayName,
    username: conversation.peerUsername,
    isPeerVerified: Value(conversation.isPeerVerified),
    lastMessagePreview: Value(conversation.lastMessagePreview),
    lastMessageAt: Value(conversation.updatedAt),
    unreadCount: Value(conversation.unreadCount),
    mutedUntil: const Value(null),
    disappearingSeconds: Value(seconds == 0 ? null : seconds),
    canSend: Value(conversation.canSend),
    isUnavailable: Value(!conversation.canSend),
    isOutgoingPreview: Value(conversation.isOutgoingPreview),
    createdAt: now,
    updatedAt: conversation.updatedAt,
    lastSyncedAt: Value(now),
  );
}

LocalConversationsCompanion conversationToUpsertCompanion(
  Conversation conversation, {
  DateTime? mutedUntil,
  int? disappearingSeconds,
  String? lastMessageId,
  String? lastMessageClientId,
  String? lastMessageType,
}) {
  final now = DateTime.now().toUtc();
  final seconds =
      disappearingSeconds ??
      DisappearingDurationMapper.hoursToSeconds(
        conversation.disappearingDurationHours,
      );
  return LocalConversationsCompanion(
    conversationId: Value(conversation.id),
    otherParticipantId: Value(conversation.peerId),
    displayName: Value(conversation.peerDisplayName),
    username: Value(conversation.peerUsername),
    isPeerVerified: Value(conversation.isPeerVerified),
    lastMessageId: Value(lastMessageId),
    lastMessageClientId: Value(lastMessageClientId),
    lastMessageType: Value(lastMessageType),
    lastMessagePreview: Value(conversation.lastMessagePreview),
    lastMessageAt: Value(conversation.updatedAt),
    unreadCount: Value(conversation.unreadCount),
    mutedUntil: Value(mutedUntil),
    disappearingSeconds: Value(seconds == 0 ? null : seconds),
    canSend: Value(conversation.canSend),
    isUnavailable: Value(!conversation.canSend),
    isOutgoingPreview: Value(conversation.isOutgoingPreview),
    updatedAt: Value(conversation.updatedAt),
    lastSyncedAt: Value(now),
  );
}
