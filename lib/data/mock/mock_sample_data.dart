import '../models/account_settings.dart';
import '../models/blocked_user.dart';
import '../models/contact.dart';
import '../models/contact_request.dart';
import '../models/conversation.dart';
import '../models/linked_device.dart';
import '../models/message.dart';
import '../models/security_event.dart';
import '../models/shared_media_item.dart';
import '../models/storage_usage.dart';
import '../models/user_profile.dart';
import '../models/user_profile_preview.dart';
import '../models/user_search_result.dart';

/// Centralized sample data for UI development.
abstract final class MockSampleData {
  static final DateTime _now = DateTime.utc(2026, 7, 4, 12);

  static const currentUser = UserProfile(
    id: 'user-self',
    displayName: 'Zed Clay',
    username: 'zedclay',
    pokidokiId: 'PKD-84A7-19ZX',
    email: 'you@example.invalid',
    isVerified: true,
  );

  /// Development-only public contact payloads (never include secrets).
  static const currentUserQrPayload = 'pokidoki://contact/zed-demo';
  static const amiraQrPayload = 'pokidoki://contact/amira-demo';
  static const amiraUserId = 'c-amira';

  /// Deterministic mock safety-number groups for UI only.
  static const amiraSafetyNumberGroups = <String>[
    '28491',
    '73502',
    '19048',
    '66372',
    '50981',
    '24736',
    '11854',
    '90217',
  ];

  static const accountSettings = AccountSettings(
    appLockEnabled: true,
    biometricsEnabled: false,
    disappearingMessagesDefaultHours: 24,
    readReceiptsEnabled: true,
    themeModeName: 'dark',
    localeCode: 'en',
  );

  static const contacts = <Contact>[
    Contact(
      id: 'c-amira',
      displayName: 'Amira Mansouri',
      username: 'amira',
      pokidokiId: 'PKD-AM84-2LX7',
      status: ContactStatus.connected,
      isVerified: false,
    ),
    Contact(
      id: 'c-karim',
      displayName: 'Karim',
      username: 'karim',
      pokidokiId: 'PK-200002',
      status: ContactStatus.connected,
      isVerified: true,
    ),
    Contact(
      id: 'c-lina',
      displayName: 'Lina',
      username: 'lina',
      pokidokiId: 'PK-200003',
      status: ContactStatus.connected,
      isVerified: true,
    ),
    Contact(
      id: 'c-maya',
      displayName: 'Maya',
      username: 'maya_x',
      pokidokiId: 'PK-200007',
      status: ContactStatus.connected,
    ),
    Contact(
      id: 'c-nour',
      displayName: 'Nour',
      username: 'nour.designs',
      pokidokiId: 'PK-200008',
      status: ContactStatus.connected,
    ),
    Contact(
      id: 'c-samir',
      displayName: 'Samir',
      username: 'samir',
      pokidokiId: 'PK-200009',
      status: ContactStatus.connected,
    ),
  ];

  static final contactRequests = <ContactRequest>[
    ContactRequest(
      id: 'req-yasmine',
      userId: 'u-yasmine',
      displayName: 'Yasmine A.',
      username: 'yasmine.a',
      pokidokiId: 'PKD-7K2M-91QF',
      direction: ContactRequestDirection.incoming,
      createdAt: _now,
      bio: 'Product designer and illustration enthusiast.',
    ),
    ContactRequest(
      id: 'req-sofiane',
      userId: 'u-sofiane',
      displayName: 'Sofiane K.',
      username: 'sofiane.k',
      pokidokiId: 'PKD-42MX-8Q7P',
      direction: ContactRequestDirection.incoming,
      createdAt: _now.subtract(const Duration(days: 1)),
    ),
    ContactRequest(
      id: 'req-nadia',
      userId: 'u-nadia',
      displayName: 'Nadia A.',
      username: 'nadia.a',
      pokidokiId: 'PK-200005',
      direction: ContactRequestDirection.outgoing,
      createdAt: _now.subtract(const Duration(days: 1)),
    ),
  ];

  static final conversations = <Conversation>[
    Conversation(
      id: 'conv-amira',
      peerId: 'c-amira',
      peerDisplayName: 'Amira Mansouri',
      peerUsername: 'amira',
      updatedAt: _now.subtract(const Duration(minutes: 8)),
      lastMessagePreview: "I'll message you at 9 tomorrow.",
      unreadCount: 2,
      isPeerVerified: false,
      isPinned: true,
      disappearingMessagesEnabled: true,
      disappearingDurationHours: 24,
    ),
    Conversation(
      id: 'conv-yacine',
      peerId: 'c-yacine',
      peerDisplayName: 'Yacine',
      peerUsername: 'yacine',
      updatedAt: _now.subtract(const Duration(minutes: 30)),
      lastMessagePreview: 'The file is ready.',
      isPinned: true,
      isMuted: true,
    ),
    Conversation(
      id: 'conv-lina',
      peerId: 'c-lina',
      peerDisplayName: 'Lina',
      peerUsername: 'lina',
      updatedAt: DateTime.utc(2026, 7, 4, 8, 54),
      lastMessagePreview: 'That sounds perfect',
      isPeerVerified: true,
    ),
    Conversation(
      id: 'conv-karim',
      peerId: 'c-karim',
      peerDisplayName: 'Karim',
      peerUsername: 'karim',
      updatedAt: _now.subtract(const Duration(days: 1)),
      lastMessagePreview: 'I sent the document.',
      isPeerVerified: true,
      isOutgoingPreview: true,
    ),
    Conversation(
      id: 'conv-nour',
      peerId: 'c-nour',
      peerDisplayName: 'Nour',
      peerUsername: 'nour.designs',
      updatedAt: _now.subtract(const Duration(days: 2)),
      lastMessagePreview: 'Voice message',
      isMuted: true,
    ),
    Conversation(
      id: 'conv-samir',
      peerId: 'c-samir',
      peerDisplayName: 'Samir',
      peerUsername: 'samir',
      updatedAt: _now.subtract(const Duration(days: 3)),
      lastMessagePreview: 'This message will disappear in 1 day.',
      disappearingMessagesEnabled: true,
    ),
    Conversation(
      id: 'conv-maya',
      peerId: 'c-maya',
      peerDisplayName: 'Maya',
      peerUsername: 'maya_x',
      updatedAt: _now.subtract(const Duration(days: 4)),
      lastMessagePreview: 'Photo',
      isOutgoingPreview: true,
    ),
  ];

  static final directoryUsers = <UserSearchResult>[
    const UserSearchResult(
      id: 'u-amira',
      displayName: 'Amira Mansouri',
      username: 'amira',
      pokidokiId: 'PKD-AM84-2LX7',
      bio: 'Designer, traveller, and coffee lover.',
      isVerified: true,
    ),
    const UserSearchResult(
      id: 'u-amira-r',
      displayName: 'Amira Rahal',
      username: 'amira.r',
      pokidokiId: 'PKD-4N7R-Q81A',
      bio: 'Building meaningful digital products.',
    ),
    const UserSearchResult(
      id: 'u-meriem',
      displayName: 'Meriem Amira',
      username: 'meriem.amira',
      pokidokiId: 'PKD-H5C2-6TZ9',
    ),
    const UserSearchResult(
      id: 'u-yasmine',
      displayName: 'Yasmine A.',
      username: 'yasmine.a',
      pokidokiId: 'PKD-7K2M-91QF',
      bio: 'Product designer and illustration enthusiast.',
    ),
    const UserSearchResult(
      id: 'u-sofiane',
      displayName: 'Sofiane K.',
      username: 'sofiane.k',
      pokidokiId: 'PKD-42MX-8Q7P',
    ),
    const UserSearchResult(
      id: 'u-riad',
      displayName: 'Riad B.',
      username: 'riad.b',
      pokidokiId: 'PKD-R8D4-72LX',
      isVerified: true,
    ),
  ];

  static final profiles = <String, UserProfilePreview>{
    'u-amira-r': const UserProfilePreview(
      id: 'u-amira-r',
      displayName: 'Amira Rahal',
      username: 'amira.r',
      pokidokiId: 'PKD-4N7R-Q81A',
      relationship: ProfileRelationship.none,
      bio: 'Building meaningful digital products.',
      sharedContext: 'Found through username search',
    ),
    'u-yasmine': const UserProfilePreview(
      id: 'u-yasmine',
      displayName: 'Yasmine A.',
      username: 'yasmine.a',
      pokidokiId: 'PKD-7K2M-91QF',
      relationship: ProfileRelationship.none,
      bio: 'Product designer and illustration enthusiast.',
      sharedContext: 'Found through contact request',
    ),
    'u-sofiane': const UserProfilePreview(
      id: 'u-sofiane',
      displayName: 'Sofiane K.',
      username: 'sofiane.k',
      pokidokiId: 'PKD-42MX-8Q7P',
      relationship: ProfileRelationship.none,
      sharedContext: 'Found through contact request',
    ),
    'u-riad': const UserProfilePreview(
      id: 'u-riad',
      displayName: 'Riad B.',
      username: 'riad.b',
      pokidokiId: 'PKD-R8D4-72LX',
      relationship: ProfileRelationship.none,
      isVerified: true,
      sharedContext: 'Found through username search',
    ),
  };

  static final messages = <String, List<ChatMessage>>{
    'conv-amira': [
      ChatMessage(
        id: 'm-doc',
        conversationId: 'conv-amira',
        senderId: 'c-amira',
        body: 'Hi! Did you receive the document?',
        sentAt: _now.subtract(const Duration(minutes: 20)),
        isOutgoing: false,
        deliveryStatus: MessageDeliveryStatus.read,
      ),
      ChatMessage(
        id: 'm-yes',
        conversationId: 'conv-amira',
        senderId: 'user-self',
        body: 'Yes, I received it. Thank you.',
        sentAt: _now.subtract(const Duration(minutes: 18)),
        isOutgoing: true,
        deliveryStatus: MessageDeliveryStatus.read,
      ),
      ChatMessage(
        id: 'm-great',
        conversationId: 'conv-amira',
        senderId: 'c-amira',
        body: 'Great. Let me know if anything needs to be changed.',
        sentAt: _now.subtract(const Duration(minutes: 16)),
        isOutgoing: false,
        deliveryStatus: MessageDeliveryStatus.read,
      ),
      ChatMessage(
        id: 'm-review',
        conversationId: 'conv-amira',
        senderId: 'user-self',
        body: "I'll review it this evening.",
        sentAt: _now.subtract(const Duration(minutes: 14)),
        isOutgoing: true,
        deliveryStatus: MessageDeliveryStatus.read,
      ),
      ChatMessage(
        id: 'm-ok',
        conversationId: 'conv-amira',
        senderId: 'c-amira',
        body: 'Good 😊 I wanted to make sure everything was okay.',
        sentAt: _now.subtract(const Duration(minutes: 12)),
        isOutgoing: false,
        deliveryStatus: MessageDeliveryStatus.read,
      ),
      ChatMessage(
        id: 'm-file',
        conversationId: 'conv-amira',
        senderId: 'c-amira',
        body: 'Project brief.pdf',
        type: MessageContentType.file,
        attachmentName: 'Project brief.pdf',
        attachmentSizeBytes: 2_400_000,
        sentAt: _now.subtract(const Duration(minutes: 11)),
        isOutgoing: false,
      ),
      ChatMessage(
        id: 'm-link',
        conversationId: 'conv-amira',
        senderId: 'user-self',
        body: 'https://example.invalid/notes',
        type: MessageContentType.link,
        sentAt: _now.subtract(const Duration(minutes: 10)),
        isOutgoing: true,
        deliveryStatus: MessageDeliveryStatus.delivered,
      ),
      ChatMessage(
        id: 'm-tomorrow',
        conversationId: 'conv-amira',
        senderId: 'user-self',
        body: "I'll message you at 9 tomorrow.",
        sentAt: _now.subtract(const Duration(minutes: 8)),
        isOutgoing: true,
        deliveryStatus: MessageDeliveryStatus.read,
      ),
      ChatMessage(
        id: 'm-system-disappear',
        conversationId: 'conv-amira',
        senderId: 'system',
        body: 'Disappearing messages are set to 1 day.',
        type: MessageContentType.system,
        sentAt: _now.subtract(const Duration(minutes: 7)),
        isOutgoing: false,
      ),
    ],
  };

  static final linkedDevices = <LinkedDevice>[
    LinkedDevice(
      id: 'dev-phone',
      name: "Hafid's iPhone",
      platform: 'iPhone · iOS',
      lastActiveAt: _now,
      isCurrentDevice: true,
      approximateLocation: 'Algeria',
    ),
    LinkedDevice(
      id: 'dev-macbook',
      name: 'MacBook Pro',
      platform: 'macOS · Desktop',
      lastActiveAt: _now.subtract(const Duration(hours: 2)),
      needsReview: true,
      approximateLocation: 'Algeria',
    ),
  ];

  static final securityEvents = <SecurityEvent>[
    SecurityEvent(
      id: 'sec-device-mac',
      type: SecurityEventType.deviceLinked,
      occurredAt: _now.subtract(const Duration(hours: 2)),
      title: 'New device linked',
      summary: 'MacBook Pro was linked to your Pokidoki account',
      deviceLabel: 'MacBook Pro · macOS · Algeria',
      requiresAttention: true,
    ),
    SecurityEvent(
      id: 'sec-unlock',
      type: SecurityEventType.signIn,
      occurredAt: _now.subtract(const Duration(hours: 3)),
      title: 'Pokidoki unlocked',
      summary:
          'The app was unlocked using biometric authentication on this device',
      deviceLabel: 'This device',
    ),
    SecurityEvent(
      id: 'sec-verify-amira',
      type: SecurityEventType.verificationCompleted,
      occurredAt: _now.subtract(const Duration(hours: 5)),
      title: 'Contact verified',
      summary: "You verified Amira Mansouri's Pokidoki security identity",
    ),
    SecurityEvent(
      id: 'sec-password',
      type: SecurityEventType.passwordChanged,
      occurredAt: DateTime.utc(2026, 4, 3),
      title: 'Account password changed',
      summary: 'Your Pokidoki account password was updated',
    ),
    SecurityEvent(
      id: 'sec-privacy',
      type: SecurityEventType.screenPrivacyEnabled,
      occurredAt: DateTime.utc(2026, 3, 28),
      title: 'Screen privacy enabled',
      summary: 'Pokidoki content is hidden in app-switcher previews',
    ),
    SecurityEvent(
      id: 'sec-removed',
      type: SecurityEventType.deviceRemoved,
      occurredAt: DateTime.utc(2026, 3, 16),
      title: 'Device removed',
      summary: 'Windows PC was signed out from your account',
      deviceLabel: 'Windows PC',
    ),
  ];

  static final blockedUsers = <BlockedUser>[
    BlockedUser(
      id: 'u-riad',
      displayName: 'Riad B.',
      username: 'riad.b',
      pokidokiId: 'PKD-R8D4-72LX',
      blockedAt: _now.subtract(const Duration(days: 4)),
    ),
    BlockedUser(
      id: 'u-nadia',
      displayName: 'Nadia A.',
      username: 'nadia.a',
      pokidokiId: 'PKD-3Q9M-81KV',
      blockedAt: _now.subtract(const Duration(days: 8)),
    ),
  ];

  static const storageUsage = StorageUsage(
    totalBytes: 248 * 1024 * 1024,
    mediaBytes: 136 * 1024 * 1024,
    filesBytes: 54 * 1024 * 1024,
    voiceBytes: 31 * 1024 * 1024,
    cacheBytes: 19 * 1024 * 1024,
    otherBytes: 8 * 1024 * 1024,
  );

  static final sharedMedia = <String, List<SharedMediaItem>>{
    'conv-amira': [
      SharedMediaItem(
        id: 'media-1',
        conversationId: 'conv-amira',
        kind: SharedMediaKind.image,
        fileName: 'evening.jpg',
        sizeBytes: 1_240_000,
        sharedAt: _now.subtract(const Duration(days: 3)),
      ),
      SharedMediaItem(
        id: 'media-2',
        conversationId: 'conv-amira',
        kind: SharedMediaKind.image,
        fileName: 'notes.jpg',
        sizeBytes: 980_000,
        sharedAt: _now.subtract(const Duration(days: 2)),
      ),
      SharedMediaItem(
        id: 'media-3',
        conversationId: 'conv-amira',
        kind: SharedMediaKind.video,
        fileName: 'clip.mp4',
        sizeBytes: 4_200_000,
        sharedAt: _now.subtract(const Duration(days: 1)),
      ),
      SharedMediaItem(
        id: 'file-1',
        conversationId: 'conv-amira',
        kind: SharedMediaKind.file,
        fileName: 'Project brief.pdf',
        sizeBytes: 2_400_000,
        sharedAt: _now.subtract(const Duration(hours: 5)),
      ),
      SharedMediaItem(
        id: 'file-2',
        conversationId: 'conv-amira',
        kind: SharedMediaKind.file,
        fileName: 'Notes.docx',
        sizeBytes: 740_000,
        sharedAt: _now.subtract(const Duration(days: 4)),
      ),
    ],
  };

  static const sharedLinks = <String, List<Map<String, String>>>{
    'conv-amira': [
      {
        'title': 'Project notes',
        'domain': 'example.invalid',
        'description': 'Shared planning notes for the private launch.',
      },
      {
        'title': 'Design references',
        'domain': 'design.example.invalid',
        'description': 'Calm, premium messaging patterns.',
      },
    ],
  };
}
