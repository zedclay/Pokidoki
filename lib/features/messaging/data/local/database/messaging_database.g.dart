// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messaging_database.dart';

// ignore_for_file: type=lint
class $LocalConversationsTable extends LocalConversations
    with TableInfo<$LocalConversationsTable, LocalConversation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalConversationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _otherParticipantIdMeta =
      const VerificationMeta('otherParticipantId');
  @override
  late final GeneratedColumn<String> otherParticipantId =
      GeneratedColumn<String>(
        'other_participant_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarInitialsMeta = const VerificationMeta(
    'avatarInitials',
  );
  @override
  late final GeneratedColumn<String> avatarInitials = GeneratedColumn<String>(
    'avatar_initials',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPeerVerifiedMeta = const VerificationMeta(
    'isPeerVerified',
  );
  @override
  late final GeneratedColumn<bool> isPeerVerified = GeneratedColumn<bool>(
    'is_peer_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_peer_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastMessageIdMeta = const VerificationMeta(
    'lastMessageId',
  );
  @override
  late final GeneratedColumn<String> lastMessageId = GeneratedColumn<String>(
    'last_message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMessageClientIdMeta =
      const VerificationMeta('lastMessageClientId');
  @override
  late final GeneratedColumn<String> lastMessageClientId =
      GeneratedColumn<String>(
        'last_message_client_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastMessageTypeMeta = const VerificationMeta(
    'lastMessageType',
  );
  @override
  late final GeneratedColumn<String> lastMessageType = GeneratedColumn<String>(
    'last_message_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMessagePreviewMeta =
      const VerificationMeta('lastMessagePreview');
  @override
  late final GeneratedColumn<String> lastMessagePreview =
      GeneratedColumn<String>(
        'last_message_preview',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastMessageAtMeta = const VerificationMeta(
    'lastMessageAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastMessageAt =
      GeneratedColumn<DateTime>(
        'last_message_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _unreadCountMeta = const VerificationMeta(
    'unreadCount',
  );
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
    'unread_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _mutedUntilMeta = const VerificationMeta(
    'mutedUntil',
  );
  @override
  late final GeneratedColumn<DateTime> mutedUntil = GeneratedColumn<DateTime>(
    'muted_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _disappearingSecondsMeta =
      const VerificationMeta('disappearingSeconds');
  @override
  late final GeneratedColumn<int> disappearingSeconds = GeneratedColumn<int>(
    'disappearing_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _canSendMeta = const VerificationMeta(
    'canSend',
  );
  @override
  late final GeneratedColumn<bool> canSend = GeneratedColumn<bool>(
    'can_send',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_send" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isUnavailableMeta = const VerificationMeta(
    'isUnavailable',
  );
  @override
  late final GeneratedColumn<bool> isUnavailable = GeneratedColumn<bool>(
    'is_unavailable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_unavailable" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isOutgoingPreviewMeta = const VerificationMeta(
    'isOutgoingPreview',
  );
  @override
  late final GeneratedColumn<bool> isOutgoingPreview = GeneratedColumn<bool>(
    'is_outgoing_preview',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_outgoing_preview" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    conversationId,
    otherParticipantId,
    displayName,
    username,
    avatarInitials,
    avatarUrl,
    isPeerVerified,
    lastMessageId,
    lastMessageClientId,
    lastMessageType,
    lastMessagePreview,
    lastMessageAt,
    unreadCount,
    mutedUntil,
    disappearingSeconds,
    canSend,
    isUnavailable,
    isOutgoingPreview,
    createdAt,
    updatedAt,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_conversations';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalConversation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('other_participant_id')) {
      context.handle(
        _otherParticipantIdMeta,
        otherParticipantId.isAcceptableOrUnknown(
          data['other_participant_id']!,
          _otherParticipantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_otherParticipantIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('avatar_initials')) {
      context.handle(
        _avatarInitialsMeta,
        avatarInitials.isAcceptableOrUnknown(
          data['avatar_initials']!,
          _avatarInitialsMeta,
        ),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('is_peer_verified')) {
      context.handle(
        _isPeerVerifiedMeta,
        isPeerVerified.isAcceptableOrUnknown(
          data['is_peer_verified']!,
          _isPeerVerifiedMeta,
        ),
      );
    }
    if (data.containsKey('last_message_id')) {
      context.handle(
        _lastMessageIdMeta,
        lastMessageId.isAcceptableOrUnknown(
          data['last_message_id']!,
          _lastMessageIdMeta,
        ),
      );
    }
    if (data.containsKey('last_message_client_id')) {
      context.handle(
        _lastMessageClientIdMeta,
        lastMessageClientId.isAcceptableOrUnknown(
          data['last_message_client_id']!,
          _lastMessageClientIdMeta,
        ),
      );
    }
    if (data.containsKey('last_message_type')) {
      context.handle(
        _lastMessageTypeMeta,
        lastMessageType.isAcceptableOrUnknown(
          data['last_message_type']!,
          _lastMessageTypeMeta,
        ),
      );
    }
    if (data.containsKey('last_message_preview')) {
      context.handle(
        _lastMessagePreviewMeta,
        lastMessagePreview.isAcceptableOrUnknown(
          data['last_message_preview']!,
          _lastMessagePreviewMeta,
        ),
      );
    }
    if (data.containsKey('last_message_at')) {
      context.handle(
        _lastMessageAtMeta,
        lastMessageAt.isAcceptableOrUnknown(
          data['last_message_at']!,
          _lastMessageAtMeta,
        ),
      );
    }
    if (data.containsKey('unread_count')) {
      context.handle(
        _unreadCountMeta,
        unreadCount.isAcceptableOrUnknown(
          data['unread_count']!,
          _unreadCountMeta,
        ),
      );
    }
    if (data.containsKey('muted_until')) {
      context.handle(
        _mutedUntilMeta,
        mutedUntil.isAcceptableOrUnknown(data['muted_until']!, _mutedUntilMeta),
      );
    }
    if (data.containsKey('disappearing_seconds')) {
      context.handle(
        _disappearingSecondsMeta,
        disappearingSeconds.isAcceptableOrUnknown(
          data['disappearing_seconds']!,
          _disappearingSecondsMeta,
        ),
      );
    }
    if (data.containsKey('can_send')) {
      context.handle(
        _canSendMeta,
        canSend.isAcceptableOrUnknown(data['can_send']!, _canSendMeta),
      );
    }
    if (data.containsKey('is_unavailable')) {
      context.handle(
        _isUnavailableMeta,
        isUnavailable.isAcceptableOrUnknown(
          data['is_unavailable']!,
          _isUnavailableMeta,
        ),
      );
    }
    if (data.containsKey('is_outgoing_preview')) {
      context.handle(
        _isOutgoingPreviewMeta,
        isOutgoingPreview.isAcceptableOrUnknown(
          data['is_outgoing_preview']!,
          _isOutgoingPreviewMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {conversationId};
  @override
  LocalConversation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalConversation(
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversation_id'],
      )!,
      otherParticipantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}other_participant_id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      avatarInitials: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_initials'],
      )!,
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      isPeerVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_peer_verified'],
      )!,
      lastMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_id'],
      ),
      lastMessageClientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_client_id'],
      ),
      lastMessageType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_type'],
      ),
      lastMessagePreview: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_preview'],
      ),
      lastMessageAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_message_at'],
      ),
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
      mutedUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}muted_until'],
      ),
      disappearingSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}disappearing_seconds'],
      ),
      canSend: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_send'],
      )!,
      isUnavailable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_unavailable'],
      )!,
      isOutgoingPreview: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_outgoing_preview'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $LocalConversationsTable createAlias(String alias) {
    return $LocalConversationsTable(attachedDatabase, alias);
  }
}

class LocalConversation extends DataClass
    implements Insertable<LocalConversation> {
  final String conversationId;
  final String otherParticipantId;
  final String displayName;
  final String username;
  final String avatarInitials;
  final String? avatarUrl;
  final bool isPeerVerified;
  final String? lastMessageId;
  final String? lastMessageClientId;
  final String? lastMessageType;
  final String? lastMessagePreview;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final DateTime? mutedUntil;
  final int? disappearingSeconds;
  final bool canSend;
  final bool isUnavailable;
  final bool isOutgoingPreview;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastSyncedAt;
  const LocalConversation({
    required this.conversationId,
    required this.otherParticipantId,
    required this.displayName,
    required this.username,
    required this.avatarInitials,
    this.avatarUrl,
    required this.isPeerVerified,
    this.lastMessageId,
    this.lastMessageClientId,
    this.lastMessageType,
    this.lastMessagePreview,
    this.lastMessageAt,
    required this.unreadCount,
    this.mutedUntil,
    this.disappearingSeconds,
    required this.canSend,
    required this.isUnavailable,
    required this.isOutgoingPreview,
    required this.createdAt,
    required this.updatedAt,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['conversation_id'] = Variable<String>(conversationId);
    map['other_participant_id'] = Variable<String>(otherParticipantId);
    map['display_name'] = Variable<String>(displayName);
    map['username'] = Variable<String>(username);
    map['avatar_initials'] = Variable<String>(avatarInitials);
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['is_peer_verified'] = Variable<bool>(isPeerVerified);
    if (!nullToAbsent || lastMessageId != null) {
      map['last_message_id'] = Variable<String>(lastMessageId);
    }
    if (!nullToAbsent || lastMessageClientId != null) {
      map['last_message_client_id'] = Variable<String>(lastMessageClientId);
    }
    if (!nullToAbsent || lastMessageType != null) {
      map['last_message_type'] = Variable<String>(lastMessageType);
    }
    if (!nullToAbsent || lastMessagePreview != null) {
      map['last_message_preview'] = Variable<String>(lastMessagePreview);
    }
    if (!nullToAbsent || lastMessageAt != null) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt);
    }
    map['unread_count'] = Variable<int>(unreadCount);
    if (!nullToAbsent || mutedUntil != null) {
      map['muted_until'] = Variable<DateTime>(mutedUntil);
    }
    if (!nullToAbsent || disappearingSeconds != null) {
      map['disappearing_seconds'] = Variable<int>(disappearingSeconds);
    }
    map['can_send'] = Variable<bool>(canSend);
    map['is_unavailable'] = Variable<bool>(isUnavailable);
    map['is_outgoing_preview'] = Variable<bool>(isOutgoingPreview);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  LocalConversationsCompanion toCompanion(bool nullToAbsent) {
    return LocalConversationsCompanion(
      conversationId: Value(conversationId),
      otherParticipantId: Value(otherParticipantId),
      displayName: Value(displayName),
      username: Value(username),
      avatarInitials: Value(avatarInitials),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      isPeerVerified: Value(isPeerVerified),
      lastMessageId: lastMessageId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageId),
      lastMessageClientId: lastMessageClientId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageClientId),
      lastMessageType: lastMessageType == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageType),
      lastMessagePreview: lastMessagePreview == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessagePreview),
      lastMessageAt: lastMessageAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageAt),
      unreadCount: Value(unreadCount),
      mutedUntil: mutedUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(mutedUntil),
      disappearingSeconds: disappearingSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(disappearingSeconds),
      canSend: Value(canSend),
      isUnavailable: Value(isUnavailable),
      isOutgoingPreview: Value(isOutgoingPreview),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory LocalConversation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalConversation(
      conversationId: serializer.fromJson<String>(json['conversationId']),
      otherParticipantId: serializer.fromJson<String>(
        json['otherParticipantId'],
      ),
      displayName: serializer.fromJson<String>(json['displayName']),
      username: serializer.fromJson<String>(json['username']),
      avatarInitials: serializer.fromJson<String>(json['avatarInitials']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      isPeerVerified: serializer.fromJson<bool>(json['isPeerVerified']),
      lastMessageId: serializer.fromJson<String?>(json['lastMessageId']),
      lastMessageClientId: serializer.fromJson<String?>(
        json['lastMessageClientId'],
      ),
      lastMessageType: serializer.fromJson<String?>(json['lastMessageType']),
      lastMessagePreview: serializer.fromJson<String?>(
        json['lastMessagePreview'],
      ),
      lastMessageAt: serializer.fromJson<DateTime?>(json['lastMessageAt']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      mutedUntil: serializer.fromJson<DateTime?>(json['mutedUntil']),
      disappearingSeconds: serializer.fromJson<int?>(
        json['disappearingSeconds'],
      ),
      canSend: serializer.fromJson<bool>(json['canSend']),
      isUnavailable: serializer.fromJson<bool>(json['isUnavailable']),
      isOutgoingPreview: serializer.fromJson<bool>(json['isOutgoingPreview']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'conversationId': serializer.toJson<String>(conversationId),
      'otherParticipantId': serializer.toJson<String>(otherParticipantId),
      'displayName': serializer.toJson<String>(displayName),
      'username': serializer.toJson<String>(username),
      'avatarInitials': serializer.toJson<String>(avatarInitials),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'isPeerVerified': serializer.toJson<bool>(isPeerVerified),
      'lastMessageId': serializer.toJson<String?>(lastMessageId),
      'lastMessageClientId': serializer.toJson<String?>(lastMessageClientId),
      'lastMessageType': serializer.toJson<String?>(lastMessageType),
      'lastMessagePreview': serializer.toJson<String?>(lastMessagePreview),
      'lastMessageAt': serializer.toJson<DateTime?>(lastMessageAt),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'mutedUntil': serializer.toJson<DateTime?>(mutedUntil),
      'disappearingSeconds': serializer.toJson<int?>(disappearingSeconds),
      'canSend': serializer.toJson<bool>(canSend),
      'isUnavailable': serializer.toJson<bool>(isUnavailable),
      'isOutgoingPreview': serializer.toJson<bool>(isOutgoingPreview),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  LocalConversation copyWith({
    String? conversationId,
    String? otherParticipantId,
    String? displayName,
    String? username,
    String? avatarInitials,
    Value<String?> avatarUrl = const Value.absent(),
    bool? isPeerVerified,
    Value<String?> lastMessageId = const Value.absent(),
    Value<String?> lastMessageClientId = const Value.absent(),
    Value<String?> lastMessageType = const Value.absent(),
    Value<String?> lastMessagePreview = const Value.absent(),
    Value<DateTime?> lastMessageAt = const Value.absent(),
    int? unreadCount,
    Value<DateTime?> mutedUntil = const Value.absent(),
    Value<int?> disappearingSeconds = const Value.absent(),
    bool? canSend,
    bool? isUnavailable,
    bool? isOutgoingPreview,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => LocalConversation(
    conversationId: conversationId ?? this.conversationId,
    otherParticipantId: otherParticipantId ?? this.otherParticipantId,
    displayName: displayName ?? this.displayName,
    username: username ?? this.username,
    avatarInitials: avatarInitials ?? this.avatarInitials,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    isPeerVerified: isPeerVerified ?? this.isPeerVerified,
    lastMessageId: lastMessageId.present
        ? lastMessageId.value
        : this.lastMessageId,
    lastMessageClientId: lastMessageClientId.present
        ? lastMessageClientId.value
        : this.lastMessageClientId,
    lastMessageType: lastMessageType.present
        ? lastMessageType.value
        : this.lastMessageType,
    lastMessagePreview: lastMessagePreview.present
        ? lastMessagePreview.value
        : this.lastMessagePreview,
    lastMessageAt: lastMessageAt.present
        ? lastMessageAt.value
        : this.lastMessageAt,
    unreadCount: unreadCount ?? this.unreadCount,
    mutedUntil: mutedUntil.present ? mutedUntil.value : this.mutedUntil,
    disappearingSeconds: disappearingSeconds.present
        ? disappearingSeconds.value
        : this.disappearingSeconds,
    canSend: canSend ?? this.canSend,
    isUnavailable: isUnavailable ?? this.isUnavailable,
    isOutgoingPreview: isOutgoingPreview ?? this.isOutgoingPreview,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  LocalConversation copyWithCompanion(LocalConversationsCompanion data) {
    return LocalConversation(
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      otherParticipantId: data.otherParticipantId.present
          ? data.otherParticipantId.value
          : this.otherParticipantId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      username: data.username.present ? data.username.value : this.username,
      avatarInitials: data.avatarInitials.present
          ? data.avatarInitials.value
          : this.avatarInitials,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      isPeerVerified: data.isPeerVerified.present
          ? data.isPeerVerified.value
          : this.isPeerVerified,
      lastMessageId: data.lastMessageId.present
          ? data.lastMessageId.value
          : this.lastMessageId,
      lastMessageClientId: data.lastMessageClientId.present
          ? data.lastMessageClientId.value
          : this.lastMessageClientId,
      lastMessageType: data.lastMessageType.present
          ? data.lastMessageType.value
          : this.lastMessageType,
      lastMessagePreview: data.lastMessagePreview.present
          ? data.lastMessagePreview.value
          : this.lastMessagePreview,
      lastMessageAt: data.lastMessageAt.present
          ? data.lastMessageAt.value
          : this.lastMessageAt,
      unreadCount: data.unreadCount.present
          ? data.unreadCount.value
          : this.unreadCount,
      mutedUntil: data.mutedUntil.present
          ? data.mutedUntil.value
          : this.mutedUntil,
      disappearingSeconds: data.disappearingSeconds.present
          ? data.disappearingSeconds.value
          : this.disappearingSeconds,
      canSend: data.canSend.present ? data.canSend.value : this.canSend,
      isUnavailable: data.isUnavailable.present
          ? data.isUnavailable.value
          : this.isUnavailable,
      isOutgoingPreview: data.isOutgoingPreview.present
          ? data.isOutgoingPreview.value
          : this.isOutgoingPreview,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalConversation(')
          ..write('conversationId: $conversationId, ')
          ..write('otherParticipantId: $otherParticipantId, ')
          ..write('displayName: $displayName, ')
          ..write('username: $username, ')
          ..write('avatarInitials: $avatarInitials, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('isPeerVerified: $isPeerVerified, ')
          ..write('lastMessageId: $lastMessageId, ')
          ..write('lastMessageClientId: $lastMessageClientId, ')
          ..write('lastMessageType: $lastMessageType, ')
          ..write('lastMessagePreview: $lastMessagePreview, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('mutedUntil: $mutedUntil, ')
          ..write('disappearingSeconds: $disappearingSeconds, ')
          ..write('canSend: $canSend, ')
          ..write('isUnavailable: $isUnavailable, ')
          ..write('isOutgoingPreview: $isOutgoingPreview, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    conversationId,
    otherParticipantId,
    displayName,
    username,
    avatarInitials,
    avatarUrl,
    isPeerVerified,
    lastMessageId,
    lastMessageClientId,
    lastMessageType,
    lastMessagePreview,
    lastMessageAt,
    unreadCount,
    mutedUntil,
    disappearingSeconds,
    canSend,
    isUnavailable,
    isOutgoingPreview,
    createdAt,
    updatedAt,
    lastSyncedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalConversation &&
          other.conversationId == this.conversationId &&
          other.otherParticipantId == this.otherParticipantId &&
          other.displayName == this.displayName &&
          other.username == this.username &&
          other.avatarInitials == this.avatarInitials &&
          other.avatarUrl == this.avatarUrl &&
          other.isPeerVerified == this.isPeerVerified &&
          other.lastMessageId == this.lastMessageId &&
          other.lastMessageClientId == this.lastMessageClientId &&
          other.lastMessageType == this.lastMessageType &&
          other.lastMessagePreview == this.lastMessagePreview &&
          other.lastMessageAt == this.lastMessageAt &&
          other.unreadCount == this.unreadCount &&
          other.mutedUntil == this.mutedUntil &&
          other.disappearingSeconds == this.disappearingSeconds &&
          other.canSend == this.canSend &&
          other.isUnavailable == this.isUnavailable &&
          other.isOutgoingPreview == this.isOutgoingPreview &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class LocalConversationsCompanion extends UpdateCompanion<LocalConversation> {
  final Value<String> conversationId;
  final Value<String> otherParticipantId;
  final Value<String> displayName;
  final Value<String> username;
  final Value<String> avatarInitials;
  final Value<String?> avatarUrl;
  final Value<bool> isPeerVerified;
  final Value<String?> lastMessageId;
  final Value<String?> lastMessageClientId;
  final Value<String?> lastMessageType;
  final Value<String?> lastMessagePreview;
  final Value<DateTime?> lastMessageAt;
  final Value<int> unreadCount;
  final Value<DateTime?> mutedUntil;
  final Value<int?> disappearingSeconds;
  final Value<bool> canSend;
  final Value<bool> isUnavailable;
  final Value<bool> isOutgoingPreview;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const LocalConversationsCompanion({
    this.conversationId = const Value.absent(),
    this.otherParticipantId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.username = const Value.absent(),
    this.avatarInitials = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.isPeerVerified = const Value.absent(),
    this.lastMessageId = const Value.absent(),
    this.lastMessageClientId = const Value.absent(),
    this.lastMessageType = const Value.absent(),
    this.lastMessagePreview = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.mutedUntil = const Value.absent(),
    this.disappearingSeconds = const Value.absent(),
    this.canSend = const Value.absent(),
    this.isUnavailable = const Value.absent(),
    this.isOutgoingPreview = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalConversationsCompanion.insert({
    required String conversationId,
    required String otherParticipantId,
    required String displayName,
    required String username,
    this.avatarInitials = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.isPeerVerified = const Value.absent(),
    this.lastMessageId = const Value.absent(),
    this.lastMessageClientId = const Value.absent(),
    this.lastMessageType = const Value.absent(),
    this.lastMessagePreview = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.mutedUntil = const Value.absent(),
    this.disappearingSeconds = const Value.absent(),
    this.canSend = const Value.absent(),
    this.isUnavailable = const Value.absent(),
    this.isOutgoingPreview = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : conversationId = Value(conversationId),
       otherParticipantId = Value(otherParticipantId),
       displayName = Value(displayName),
       username = Value(username),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalConversation> custom({
    Expression<String>? conversationId,
    Expression<String>? otherParticipantId,
    Expression<String>? displayName,
    Expression<String>? username,
    Expression<String>? avatarInitials,
    Expression<String>? avatarUrl,
    Expression<bool>? isPeerVerified,
    Expression<String>? lastMessageId,
    Expression<String>? lastMessageClientId,
    Expression<String>? lastMessageType,
    Expression<String>? lastMessagePreview,
    Expression<DateTime>? lastMessageAt,
    Expression<int>? unreadCount,
    Expression<DateTime>? mutedUntil,
    Expression<int>? disappearingSeconds,
    Expression<bool>? canSend,
    Expression<bool>? isUnavailable,
    Expression<bool>? isOutgoingPreview,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (conversationId != null) 'conversation_id': conversationId,
      if (otherParticipantId != null)
        'other_participant_id': otherParticipantId,
      if (displayName != null) 'display_name': displayName,
      if (username != null) 'username': username,
      if (avatarInitials != null) 'avatar_initials': avatarInitials,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (isPeerVerified != null) 'is_peer_verified': isPeerVerified,
      if (lastMessageId != null) 'last_message_id': lastMessageId,
      if (lastMessageClientId != null)
        'last_message_client_id': lastMessageClientId,
      if (lastMessageType != null) 'last_message_type': lastMessageType,
      if (lastMessagePreview != null)
        'last_message_preview': lastMessagePreview,
      if (lastMessageAt != null) 'last_message_at': lastMessageAt,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (mutedUntil != null) 'muted_until': mutedUntil,
      if (disappearingSeconds != null)
        'disappearing_seconds': disappearingSeconds,
      if (canSend != null) 'can_send': canSend,
      if (isUnavailable != null) 'is_unavailable': isUnavailable,
      if (isOutgoingPreview != null) 'is_outgoing_preview': isOutgoingPreview,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalConversationsCompanion copyWith({
    Value<String>? conversationId,
    Value<String>? otherParticipantId,
    Value<String>? displayName,
    Value<String>? username,
    Value<String>? avatarInitials,
    Value<String?>? avatarUrl,
    Value<bool>? isPeerVerified,
    Value<String?>? lastMessageId,
    Value<String?>? lastMessageClientId,
    Value<String?>? lastMessageType,
    Value<String?>? lastMessagePreview,
    Value<DateTime?>? lastMessageAt,
    Value<int>? unreadCount,
    Value<DateTime?>? mutedUntil,
    Value<int?>? disappearingSeconds,
    Value<bool>? canSend,
    Value<bool>? isUnavailable,
    Value<bool>? isOutgoingPreview,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return LocalConversationsCompanion(
      conversationId: conversationId ?? this.conversationId,
      otherParticipantId: otherParticipantId ?? this.otherParticipantId,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      avatarInitials: avatarInitials ?? this.avatarInitials,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isPeerVerified: isPeerVerified ?? this.isPeerVerified,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      lastMessageClientId: lastMessageClientId ?? this.lastMessageClientId,
      lastMessageType: lastMessageType ?? this.lastMessageType,
      lastMessagePreview: lastMessagePreview ?? this.lastMessagePreview,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCount: unreadCount ?? this.unreadCount,
      mutedUntil: mutedUntil ?? this.mutedUntil,
      disappearingSeconds: disappearingSeconds ?? this.disappearingSeconds,
      canSend: canSend ?? this.canSend,
      isUnavailable: isUnavailable ?? this.isUnavailable,
      isOutgoingPreview: isOutgoingPreview ?? this.isOutgoingPreview,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (otherParticipantId.present) {
      map['other_participant_id'] = Variable<String>(otherParticipantId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (avatarInitials.present) {
      map['avatar_initials'] = Variable<String>(avatarInitials.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (isPeerVerified.present) {
      map['is_peer_verified'] = Variable<bool>(isPeerVerified.value);
    }
    if (lastMessageId.present) {
      map['last_message_id'] = Variable<String>(lastMessageId.value);
    }
    if (lastMessageClientId.present) {
      map['last_message_client_id'] = Variable<String>(
        lastMessageClientId.value,
      );
    }
    if (lastMessageType.present) {
      map['last_message_type'] = Variable<String>(lastMessageType.value);
    }
    if (lastMessagePreview.present) {
      map['last_message_preview'] = Variable<String>(lastMessagePreview.value);
    }
    if (lastMessageAt.present) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (mutedUntil.present) {
      map['muted_until'] = Variable<DateTime>(mutedUntil.value);
    }
    if (disappearingSeconds.present) {
      map['disappearing_seconds'] = Variable<int>(disappearingSeconds.value);
    }
    if (canSend.present) {
      map['can_send'] = Variable<bool>(canSend.value);
    }
    if (isUnavailable.present) {
      map['is_unavailable'] = Variable<bool>(isUnavailable.value);
    }
    if (isOutgoingPreview.present) {
      map['is_outgoing_preview'] = Variable<bool>(isOutgoingPreview.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalConversationsCompanion(')
          ..write('conversationId: $conversationId, ')
          ..write('otherParticipantId: $otherParticipantId, ')
          ..write('displayName: $displayName, ')
          ..write('username: $username, ')
          ..write('avatarInitials: $avatarInitials, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('isPeerVerified: $isPeerVerified, ')
          ..write('lastMessageId: $lastMessageId, ')
          ..write('lastMessageClientId: $lastMessageClientId, ')
          ..write('lastMessageType: $lastMessageType, ')
          ..write('lastMessagePreview: $lastMessagePreview, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('mutedUntil: $mutedUntil, ')
          ..write('disappearingSeconds: $disappearingSeconds, ')
          ..write('canSend: $canSend, ')
          ..write('isUnavailable: $isUnavailable, ')
          ..write('isOutgoingPreview: $isOutgoingPreview, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalMessagesTable extends LocalMessages
    with TableInfo<$LocalMessagesTable, LocalMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverMessageIdMeta = const VerificationMeta(
    'serverMessageId',
  );
  @override
  late final GeneratedColumn<String> serverMessageId = GeneratedColumn<String>(
    'server_message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientMessageIdMeta = const VerificationMeta(
    'clientMessageId',
  );
  @override
  late final GeneratedColumn<String> clientMessageId = GeneratedColumn<String>(
    'client_message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderIdMeta = const VerificationMeta(
    'senderId',
  );
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
    'sender_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageTypeMeta = const VerificationMeta(
    'messageType',
  );
  @override
  late final GeneratedColumn<String> messageType = GeneratedColumn<String>(
    'message_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('TEXT'),
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localCreatedAtMeta = const VerificationMeta(
    'localCreatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> localCreatedAt =
      GeneratedColumn<DateTime>(
        'local_created_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _serverCreatedAtMeta = const VerificationMeta(
    'serverCreatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> serverCreatedAt =
      GeneratedColumn<DateTime>(
        'server_created_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deliveryStatusMeta = const VerificationMeta(
    'deliveryStatus',
  );
  @override
  late final GeneratedColumn<String> deliveryStatus = GeneratedColumn<String>(
    'delivery_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStateMeta = const VerificationMeta(
    'syncState',
  );
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
    'sync_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorCodeMeta = const VerificationMeta(
    'errorCode',
  );
  @override
  late final GeneratedColumn<String> errorCode = GeneratedColumn<String>(
    'error_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _replyToMessageIdMeta = const VerificationMeta(
    'replyToMessageId',
  );
  @override
  late final GeneratedColumn<String> replyToMessageId = GeneratedColumn<String>(
    'reply_to_message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _replyPreviewMeta = const VerificationMeta(
    'replyPreview',
  );
  @override
  late final GeneratedColumn<String> replyPreview = GeneratedColumn<String>(
    'reply_preview',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastUpdatedAtMeta = const VerificationMeta(
    'lastUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedAt =
      GeneratedColumn<DateTime>(
        'last_updated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverMessageId,
    clientMessageId,
    conversationId,
    senderId,
    messageType,
    body,
    localCreatedAt,
    serverCreatedAt,
    expiresAt,
    deliveryStatus,
    syncState,
    errorCode,
    replyToMessageId,
    replyPreview,
    lastUpdatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_message_id')) {
      context.handle(
        _serverMessageIdMeta,
        serverMessageId.isAcceptableOrUnknown(
          data['server_message_id']!,
          _serverMessageIdMeta,
        ),
      );
    }
    if (data.containsKey('client_message_id')) {
      context.handle(
        _clientMessageIdMeta,
        clientMessageId.isAcceptableOrUnknown(
          data['client_message_id']!,
          _clientMessageIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientMessageIdMeta);
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('message_type')) {
      context.handle(
        _messageTypeMeta,
        messageType.isAcceptableOrUnknown(
          data['message_type']!,
          _messageTypeMeta,
        ),
      );
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('local_created_at')) {
      context.handle(
        _localCreatedAtMeta,
        localCreatedAt.isAcceptableOrUnknown(
          data['local_created_at']!,
          _localCreatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localCreatedAtMeta);
    }
    if (data.containsKey('server_created_at')) {
      context.handle(
        _serverCreatedAtMeta,
        serverCreatedAt.isAcceptableOrUnknown(
          data['server_created_at']!,
          _serverCreatedAtMeta,
        ),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    if (data.containsKey('delivery_status')) {
      context.handle(
        _deliveryStatusMeta,
        deliveryStatus.isAcceptableOrUnknown(
          data['delivery_status']!,
          _deliveryStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deliveryStatusMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(
        _syncStateMeta,
        syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta),
      );
    } else if (isInserting) {
      context.missing(_syncStateMeta);
    }
    if (data.containsKey('error_code')) {
      context.handle(
        _errorCodeMeta,
        errorCode.isAcceptableOrUnknown(data['error_code']!, _errorCodeMeta),
      );
    }
    if (data.containsKey('reply_to_message_id')) {
      context.handle(
        _replyToMessageIdMeta,
        replyToMessageId.isAcceptableOrUnknown(
          data['reply_to_message_id']!,
          _replyToMessageIdMeta,
        ),
      );
    }
    if (data.containsKey('reply_preview')) {
      context.handle(
        _replyPreviewMeta,
        replyPreview.isAcceptableOrUnknown(
          data['reply_preview']!,
          _replyPreviewMeta,
        ),
      );
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
        _lastUpdatedAtMeta,
        lastUpdatedAt.isAcceptableOrUnknown(
          data['last_updated_at']!,
          _lastUpdatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalMessage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_message_id'],
      ),
      clientMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_message_id'],
      )!,
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversation_id'],
      )!,
      senderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_id'],
      )!,
      messageType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_type'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      localCreatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}local_created_at'],
      )!,
      serverCreatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}server_created_at'],
      ),
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      ),
      deliveryStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}delivery_status'],
      )!,
      syncState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_state'],
      )!,
      errorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_code'],
      ),
      replyToMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reply_to_message_id'],
      ),
      replyPreview: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reply_preview'],
      ),
      lastUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_at'],
      )!,
    );
  }

  @override
  $LocalMessagesTable createAlias(String alias) {
    return $LocalMessagesTable(attachedDatabase, alias);
  }
}

class LocalMessage extends DataClass implements Insertable<LocalMessage> {
  final int id;
  final String? serverMessageId;
  final String clientMessageId;
  final String conversationId;
  final String senderId;
  final String messageType;
  final String body;
  final DateTime localCreatedAt;
  final DateTime? serverCreatedAt;
  final DateTime? expiresAt;
  final String deliveryStatus;
  final String syncState;
  final String? errorCode;
  final String? replyToMessageId;
  final String? replyPreview;
  final DateTime lastUpdatedAt;
  const LocalMessage({
    required this.id,
    this.serverMessageId,
    required this.clientMessageId,
    required this.conversationId,
    required this.senderId,
    required this.messageType,
    required this.body,
    required this.localCreatedAt,
    this.serverCreatedAt,
    this.expiresAt,
    required this.deliveryStatus,
    required this.syncState,
    this.errorCode,
    this.replyToMessageId,
    this.replyPreview,
    required this.lastUpdatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || serverMessageId != null) {
      map['server_message_id'] = Variable<String>(serverMessageId);
    }
    map['client_message_id'] = Variable<String>(clientMessageId);
    map['conversation_id'] = Variable<String>(conversationId);
    map['sender_id'] = Variable<String>(senderId);
    map['message_type'] = Variable<String>(messageType);
    map['body'] = Variable<String>(body);
    map['local_created_at'] = Variable<DateTime>(localCreatedAt);
    if (!nullToAbsent || serverCreatedAt != null) {
      map['server_created_at'] = Variable<DateTime>(serverCreatedAt);
    }
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<DateTime>(expiresAt);
    }
    map['delivery_status'] = Variable<String>(deliveryStatus);
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || errorCode != null) {
      map['error_code'] = Variable<String>(errorCode);
    }
    if (!nullToAbsent || replyToMessageId != null) {
      map['reply_to_message_id'] = Variable<String>(replyToMessageId);
    }
    if (!nullToAbsent || replyPreview != null) {
      map['reply_preview'] = Variable<String>(replyPreview);
    }
    map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt);
    return map;
  }

  LocalMessagesCompanion toCompanion(bool nullToAbsent) {
    return LocalMessagesCompanion(
      id: Value(id),
      serverMessageId: serverMessageId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverMessageId),
      clientMessageId: Value(clientMessageId),
      conversationId: Value(conversationId),
      senderId: Value(senderId),
      messageType: Value(messageType),
      body: Value(body),
      localCreatedAt: Value(localCreatedAt),
      serverCreatedAt: serverCreatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(serverCreatedAt),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
      deliveryStatus: Value(deliveryStatus),
      syncState: Value(syncState),
      errorCode: errorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(errorCode),
      replyToMessageId: replyToMessageId == null && nullToAbsent
          ? const Value.absent()
          : Value(replyToMessageId),
      replyPreview: replyPreview == null && nullToAbsent
          ? const Value.absent()
          : Value(replyPreview),
      lastUpdatedAt: Value(lastUpdatedAt),
    );
  }

  factory LocalMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalMessage(
      id: serializer.fromJson<int>(json['id']),
      serverMessageId: serializer.fromJson<String?>(json['serverMessageId']),
      clientMessageId: serializer.fromJson<String>(json['clientMessageId']),
      conversationId: serializer.fromJson<String>(json['conversationId']),
      senderId: serializer.fromJson<String>(json['senderId']),
      messageType: serializer.fromJson<String>(json['messageType']),
      body: serializer.fromJson<String>(json['body']),
      localCreatedAt: serializer.fromJson<DateTime>(json['localCreatedAt']),
      serverCreatedAt: serializer.fromJson<DateTime?>(json['serverCreatedAt']),
      expiresAt: serializer.fromJson<DateTime?>(json['expiresAt']),
      deliveryStatus: serializer.fromJson<String>(json['deliveryStatus']),
      syncState: serializer.fromJson<String>(json['syncState']),
      errorCode: serializer.fromJson<String?>(json['errorCode']),
      replyToMessageId: serializer.fromJson<String?>(json['replyToMessageId']),
      replyPreview: serializer.fromJson<String?>(json['replyPreview']),
      lastUpdatedAt: serializer.fromJson<DateTime>(json['lastUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverMessageId': serializer.toJson<String?>(serverMessageId),
      'clientMessageId': serializer.toJson<String>(clientMessageId),
      'conversationId': serializer.toJson<String>(conversationId),
      'senderId': serializer.toJson<String>(senderId),
      'messageType': serializer.toJson<String>(messageType),
      'body': serializer.toJson<String>(body),
      'localCreatedAt': serializer.toJson<DateTime>(localCreatedAt),
      'serverCreatedAt': serializer.toJson<DateTime?>(serverCreatedAt),
      'expiresAt': serializer.toJson<DateTime?>(expiresAt),
      'deliveryStatus': serializer.toJson<String>(deliveryStatus),
      'syncState': serializer.toJson<String>(syncState),
      'errorCode': serializer.toJson<String?>(errorCode),
      'replyToMessageId': serializer.toJson<String?>(replyToMessageId),
      'replyPreview': serializer.toJson<String?>(replyPreview),
      'lastUpdatedAt': serializer.toJson<DateTime>(lastUpdatedAt),
    };
  }

  LocalMessage copyWith({
    int? id,
    Value<String?> serverMessageId = const Value.absent(),
    String? clientMessageId,
    String? conversationId,
    String? senderId,
    String? messageType,
    String? body,
    DateTime? localCreatedAt,
    Value<DateTime?> serverCreatedAt = const Value.absent(),
    Value<DateTime?> expiresAt = const Value.absent(),
    String? deliveryStatus,
    String? syncState,
    Value<String?> errorCode = const Value.absent(),
    Value<String?> replyToMessageId = const Value.absent(),
    Value<String?> replyPreview = const Value.absent(),
    DateTime? lastUpdatedAt,
  }) => LocalMessage(
    id: id ?? this.id,
    serverMessageId: serverMessageId.present
        ? serverMessageId.value
        : this.serverMessageId,
    clientMessageId: clientMessageId ?? this.clientMessageId,
    conversationId: conversationId ?? this.conversationId,
    senderId: senderId ?? this.senderId,
    messageType: messageType ?? this.messageType,
    body: body ?? this.body,
    localCreatedAt: localCreatedAt ?? this.localCreatedAt,
    serverCreatedAt: serverCreatedAt.present
        ? serverCreatedAt.value
        : this.serverCreatedAt,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
    deliveryStatus: deliveryStatus ?? this.deliveryStatus,
    syncState: syncState ?? this.syncState,
    errorCode: errorCode.present ? errorCode.value : this.errorCode,
    replyToMessageId: replyToMessageId.present
        ? replyToMessageId.value
        : this.replyToMessageId,
    replyPreview: replyPreview.present ? replyPreview.value : this.replyPreview,
    lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
  );
  LocalMessage copyWithCompanion(LocalMessagesCompanion data) {
    return LocalMessage(
      id: data.id.present ? data.id.value : this.id,
      serverMessageId: data.serverMessageId.present
          ? data.serverMessageId.value
          : this.serverMessageId,
      clientMessageId: data.clientMessageId.present
          ? data.clientMessageId.value
          : this.clientMessageId,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      messageType: data.messageType.present
          ? data.messageType.value
          : this.messageType,
      body: data.body.present ? data.body.value : this.body,
      localCreatedAt: data.localCreatedAt.present
          ? data.localCreatedAt.value
          : this.localCreatedAt,
      serverCreatedAt: data.serverCreatedAt.present
          ? data.serverCreatedAt.value
          : this.serverCreatedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      deliveryStatus: data.deliveryStatus.present
          ? data.deliveryStatus.value
          : this.deliveryStatus,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      errorCode: data.errorCode.present ? data.errorCode.value : this.errorCode,
      replyToMessageId: data.replyToMessageId.present
          ? data.replyToMessageId.value
          : this.replyToMessageId,
      replyPreview: data.replyPreview.present
          ? data.replyPreview.value
          : this.replyPreview,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalMessage(')
          ..write('id: $id, ')
          ..write('serverMessageId: $serverMessageId, ')
          ..write('clientMessageId: $clientMessageId, ')
          ..write('conversationId: $conversationId, ')
          ..write('senderId: $senderId, ')
          ..write('messageType: $messageType, ')
          ..write('body: $body, ')
          ..write('localCreatedAt: $localCreatedAt, ')
          ..write('serverCreatedAt: $serverCreatedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('deliveryStatus: $deliveryStatus, ')
          ..write('syncState: $syncState, ')
          ..write('errorCode: $errorCode, ')
          ..write('replyToMessageId: $replyToMessageId, ')
          ..write('replyPreview: $replyPreview, ')
          ..write('lastUpdatedAt: $lastUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverMessageId,
    clientMessageId,
    conversationId,
    senderId,
    messageType,
    body,
    localCreatedAt,
    serverCreatedAt,
    expiresAt,
    deliveryStatus,
    syncState,
    errorCode,
    replyToMessageId,
    replyPreview,
    lastUpdatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalMessage &&
          other.id == this.id &&
          other.serverMessageId == this.serverMessageId &&
          other.clientMessageId == this.clientMessageId &&
          other.conversationId == this.conversationId &&
          other.senderId == this.senderId &&
          other.messageType == this.messageType &&
          other.body == this.body &&
          other.localCreatedAt == this.localCreatedAt &&
          other.serverCreatedAt == this.serverCreatedAt &&
          other.expiresAt == this.expiresAt &&
          other.deliveryStatus == this.deliveryStatus &&
          other.syncState == this.syncState &&
          other.errorCode == this.errorCode &&
          other.replyToMessageId == this.replyToMessageId &&
          other.replyPreview == this.replyPreview &&
          other.lastUpdatedAt == this.lastUpdatedAt);
}

class LocalMessagesCompanion extends UpdateCompanion<LocalMessage> {
  final Value<int> id;
  final Value<String?> serverMessageId;
  final Value<String> clientMessageId;
  final Value<String> conversationId;
  final Value<String> senderId;
  final Value<String> messageType;
  final Value<String> body;
  final Value<DateTime> localCreatedAt;
  final Value<DateTime?> serverCreatedAt;
  final Value<DateTime?> expiresAt;
  final Value<String> deliveryStatus;
  final Value<String> syncState;
  final Value<String?> errorCode;
  final Value<String?> replyToMessageId;
  final Value<String?> replyPreview;
  final Value<DateTime> lastUpdatedAt;
  const LocalMessagesCompanion({
    this.id = const Value.absent(),
    this.serverMessageId = const Value.absent(),
    this.clientMessageId = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.messageType = const Value.absent(),
    this.body = const Value.absent(),
    this.localCreatedAt = const Value.absent(),
    this.serverCreatedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.deliveryStatus = const Value.absent(),
    this.syncState = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.replyToMessageId = const Value.absent(),
    this.replyPreview = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
  });
  LocalMessagesCompanion.insert({
    this.id = const Value.absent(),
    this.serverMessageId = const Value.absent(),
    required String clientMessageId,
    required String conversationId,
    required String senderId,
    this.messageType = const Value.absent(),
    required String body,
    required DateTime localCreatedAt,
    this.serverCreatedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    required String deliveryStatus,
    required String syncState,
    this.errorCode = const Value.absent(),
    this.replyToMessageId = const Value.absent(),
    this.replyPreview = const Value.absent(),
    required DateTime lastUpdatedAt,
  }) : clientMessageId = Value(clientMessageId),
       conversationId = Value(conversationId),
       senderId = Value(senderId),
       body = Value(body),
       localCreatedAt = Value(localCreatedAt),
       deliveryStatus = Value(deliveryStatus),
       syncState = Value(syncState),
       lastUpdatedAt = Value(lastUpdatedAt);
  static Insertable<LocalMessage> custom({
    Expression<int>? id,
    Expression<String>? serverMessageId,
    Expression<String>? clientMessageId,
    Expression<String>? conversationId,
    Expression<String>? senderId,
    Expression<String>? messageType,
    Expression<String>? body,
    Expression<DateTime>? localCreatedAt,
    Expression<DateTime>? serverCreatedAt,
    Expression<DateTime>? expiresAt,
    Expression<String>? deliveryStatus,
    Expression<String>? syncState,
    Expression<String>? errorCode,
    Expression<String>? replyToMessageId,
    Expression<String>? replyPreview,
    Expression<DateTime>? lastUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverMessageId != null) 'server_message_id': serverMessageId,
      if (clientMessageId != null) 'client_message_id': clientMessageId,
      if (conversationId != null) 'conversation_id': conversationId,
      if (senderId != null) 'sender_id': senderId,
      if (messageType != null) 'message_type': messageType,
      if (body != null) 'body': body,
      if (localCreatedAt != null) 'local_created_at': localCreatedAt,
      if (serverCreatedAt != null) 'server_created_at': serverCreatedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (deliveryStatus != null) 'delivery_status': deliveryStatus,
      if (syncState != null) 'sync_state': syncState,
      if (errorCode != null) 'error_code': errorCode,
      if (replyToMessageId != null) 'reply_to_message_id': replyToMessageId,
      if (replyPreview != null) 'reply_preview': replyPreview,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
    });
  }

  LocalMessagesCompanion copyWith({
    Value<int>? id,
    Value<String?>? serverMessageId,
    Value<String>? clientMessageId,
    Value<String>? conversationId,
    Value<String>? senderId,
    Value<String>? messageType,
    Value<String>? body,
    Value<DateTime>? localCreatedAt,
    Value<DateTime?>? serverCreatedAt,
    Value<DateTime?>? expiresAt,
    Value<String>? deliveryStatus,
    Value<String>? syncState,
    Value<String?>? errorCode,
    Value<String?>? replyToMessageId,
    Value<String?>? replyPreview,
    Value<DateTime>? lastUpdatedAt,
  }) {
    return LocalMessagesCompanion(
      id: id ?? this.id,
      serverMessageId: serverMessageId ?? this.serverMessageId,
      clientMessageId: clientMessageId ?? this.clientMessageId,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      messageType: messageType ?? this.messageType,
      body: body ?? this.body,
      localCreatedAt: localCreatedAt ?? this.localCreatedAt,
      serverCreatedAt: serverCreatedAt ?? this.serverCreatedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      syncState: syncState ?? this.syncState,
      errorCode: errorCode ?? this.errorCode,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      replyPreview: replyPreview ?? this.replyPreview,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverMessageId.present) {
      map['server_message_id'] = Variable<String>(serverMessageId.value);
    }
    if (clientMessageId.present) {
      map['client_message_id'] = Variable<String>(clientMessageId.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (messageType.present) {
      map['message_type'] = Variable<String>(messageType.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (localCreatedAt.present) {
      map['local_created_at'] = Variable<DateTime>(localCreatedAt.value);
    }
    if (serverCreatedAt.present) {
      map['server_created_at'] = Variable<DateTime>(serverCreatedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (deliveryStatus.present) {
      map['delivery_status'] = Variable<String>(deliveryStatus.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (errorCode.present) {
      map['error_code'] = Variable<String>(errorCode.value);
    }
    if (replyToMessageId.present) {
      map['reply_to_message_id'] = Variable<String>(replyToMessageId.value);
    }
    if (replyPreview.present) {
      map['reply_preview'] = Variable<String>(replyPreview.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalMessagesCompanion(')
          ..write('id: $id, ')
          ..write('serverMessageId: $serverMessageId, ')
          ..write('clientMessageId: $clientMessageId, ')
          ..write('conversationId: $conversationId, ')
          ..write('senderId: $senderId, ')
          ..write('messageType: $messageType, ')
          ..write('body: $body, ')
          ..write('localCreatedAt: $localCreatedAt, ')
          ..write('serverCreatedAt: $serverCreatedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('deliveryStatus: $deliveryStatus, ')
          ..write('syncState: $syncState, ')
          ..write('errorCode: $errorCode, ')
          ..write('replyToMessageId: $replyToMessageId, ')
          ..write('replyPreview: $replyPreview, ')
          ..write('lastUpdatedAt: $lastUpdatedAt')
          ..write(')'))
        .toString();
  }
}

class $OutboundMessageQueueTable extends OutboundMessageQueue
    with TableInfo<$OutboundMessageQueueTable, OutboundMessageQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboundMessageQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _operationTypeMeta = const VerificationMeta(
    'operationType',
  );
  @override
  late final GeneratedColumn<String> operationType = GeneratedColumn<String>(
    'operation_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('sendTextMessage'),
  );
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientMessageIdMeta = const VerificationMeta(
    'clientMessageId',
  );
  @override
  late final GeneratedColumn<String> clientMessageId = GeneratedColumn<String>(
    'client_message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textPayloadMeta = const VerificationMeta(
    'textPayload',
  );
  @override
  late final GeneratedColumn<String> textPayload = GeneratedColumn<String>(
    'text_payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _queueStateMeta = const VerificationMeta(
    'queueState',
  );
  @override
  late final GeneratedColumn<String> queueState = GeneratedColumn<String>(
    'queue_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptCountMeta = const VerificationMeta(
    'attemptCount',
  );
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
    'attempt_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextAttemptAtMeta = const VerificationMeta(
    'nextAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextAttemptAt =
      GeneratedColumn<DateTime>(
        'next_attempt_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _inFlightSinceMeta = const VerificationMeta(
    'inFlightSince',
  );
  @override
  late final GeneratedColumn<DateTime> inFlightSince =
      GeneratedColumn<DateTime>(
        'in_flight_since',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _errorCodeMeta = const VerificationMeta(
    'errorCode',
  );
  @override
  late final GeneratedColumn<String> errorCode = GeneratedColumn<String>(
    'error_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    operationType,
    conversationId,
    clientMessageId,
    textPayload,
    queueState,
    attemptCount,
    nextAttemptAt,
    lastAttemptAt,
    inFlightSince,
    errorCode,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbound_message_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<OutboundMessageQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('operation_type')) {
      context.handle(
        _operationTypeMeta,
        operationType.isAcceptableOrUnknown(
          data['operation_type']!,
          _operationTypeMeta,
        ),
      );
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('client_message_id')) {
      context.handle(
        _clientMessageIdMeta,
        clientMessageId.isAcceptableOrUnknown(
          data['client_message_id']!,
          _clientMessageIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientMessageIdMeta);
    }
    if (data.containsKey('text_payload')) {
      context.handle(
        _textPayloadMeta,
        textPayload.isAcceptableOrUnknown(
          data['text_payload']!,
          _textPayloadMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_textPayloadMeta);
    }
    if (data.containsKey('queue_state')) {
      context.handle(
        _queueStateMeta,
        queueState.isAcceptableOrUnknown(data['queue_state']!, _queueStateMeta),
      );
    } else if (isInserting) {
      context.missing(_queueStateMeta);
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
        _attemptCountMeta,
        attemptCount.isAcceptableOrUnknown(
          data['attempt_count']!,
          _attemptCountMeta,
        ),
      );
    }
    if (data.containsKey('next_attempt_at')) {
      context.handle(
        _nextAttemptAtMeta,
        nextAttemptAt.isAcceptableOrUnknown(
          data['next_attempt_at']!,
          _nextAttemptAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextAttemptAtMeta);
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('in_flight_since')) {
      context.handle(
        _inFlightSinceMeta,
        inFlightSince.isAcceptableOrUnknown(
          data['in_flight_since']!,
          _inFlightSinceMeta,
        ),
      );
    }
    if (data.containsKey('error_code')) {
      context.handle(
        _errorCodeMeta,
        errorCode.isAcceptableOrUnknown(data['error_code']!, _errorCodeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OutboundMessageQueueData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboundMessageQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      operationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation_type'],
      )!,
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversation_id'],
      )!,
      clientMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_message_id'],
      )!,
      textPayload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_payload'],
      )!,
      queueState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}queue_state'],
      )!,
      attemptCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempt_count'],
      )!,
      nextAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_attempt_at'],
      )!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
      inFlightSince: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}in_flight_since'],
      ),
      errorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_code'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $OutboundMessageQueueTable createAlias(String alias) {
    return $OutboundMessageQueueTable(attachedDatabase, alias);
  }
}

class OutboundMessageQueueData extends DataClass
    implements Insertable<OutboundMessageQueueData> {
  final int id;
  final String operationType;
  final String conversationId;
  final String clientMessageId;
  final String textPayload;
  final String queueState;
  final int attemptCount;
  final DateTime nextAttemptAt;
  final DateTime? lastAttemptAt;
  final DateTime? inFlightSince;
  final String? errorCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  const OutboundMessageQueueData({
    required this.id,
    required this.operationType,
    required this.conversationId,
    required this.clientMessageId,
    required this.textPayload,
    required this.queueState,
    required this.attemptCount,
    required this.nextAttemptAt,
    this.lastAttemptAt,
    this.inFlightSince,
    this.errorCode,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['operation_type'] = Variable<String>(operationType);
    map['conversation_id'] = Variable<String>(conversationId);
    map['client_message_id'] = Variable<String>(clientMessageId);
    map['text_payload'] = Variable<String>(textPayload);
    map['queue_state'] = Variable<String>(queueState);
    map['attempt_count'] = Variable<int>(attemptCount);
    map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    if (!nullToAbsent || inFlightSince != null) {
      map['in_flight_since'] = Variable<DateTime>(inFlightSince);
    }
    if (!nullToAbsent || errorCode != null) {
      map['error_code'] = Variable<String>(errorCode);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OutboundMessageQueueCompanion toCompanion(bool nullToAbsent) {
    return OutboundMessageQueueCompanion(
      id: Value(id),
      operationType: Value(operationType),
      conversationId: Value(conversationId),
      clientMessageId: Value(clientMessageId),
      textPayload: Value(textPayload),
      queueState: Value(queueState),
      attemptCount: Value(attemptCount),
      nextAttemptAt: Value(nextAttemptAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      inFlightSince: inFlightSince == null && nullToAbsent
          ? const Value.absent()
          : Value(inFlightSince),
      errorCode: errorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(errorCode),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory OutboundMessageQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboundMessageQueueData(
      id: serializer.fromJson<int>(json['id']),
      operationType: serializer.fromJson<String>(json['operationType']),
      conversationId: serializer.fromJson<String>(json['conversationId']),
      clientMessageId: serializer.fromJson<String>(json['clientMessageId']),
      textPayload: serializer.fromJson<String>(json['textPayload']),
      queueState: serializer.fromJson<String>(json['queueState']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      nextAttemptAt: serializer.fromJson<DateTime>(json['nextAttemptAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      inFlightSince: serializer.fromJson<DateTime?>(json['inFlightSince']),
      errorCode: serializer.fromJson<String?>(json['errorCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'operationType': serializer.toJson<String>(operationType),
      'conversationId': serializer.toJson<String>(conversationId),
      'clientMessageId': serializer.toJson<String>(clientMessageId),
      'textPayload': serializer.toJson<String>(textPayload),
      'queueState': serializer.toJson<String>(queueState),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'nextAttemptAt': serializer.toJson<DateTime>(nextAttemptAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'inFlightSince': serializer.toJson<DateTime?>(inFlightSince),
      'errorCode': serializer.toJson<String?>(errorCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  OutboundMessageQueueData copyWith({
    int? id,
    String? operationType,
    String? conversationId,
    String? clientMessageId,
    String? textPayload,
    String? queueState,
    int? attemptCount,
    DateTime? nextAttemptAt,
    Value<DateTime?> lastAttemptAt = const Value.absent(),
    Value<DateTime?> inFlightSince = const Value.absent(),
    Value<String?> errorCode = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => OutboundMessageQueueData(
    id: id ?? this.id,
    operationType: operationType ?? this.operationType,
    conversationId: conversationId ?? this.conversationId,
    clientMessageId: clientMessageId ?? this.clientMessageId,
    textPayload: textPayload ?? this.textPayload,
    queueState: queueState ?? this.queueState,
    attemptCount: attemptCount ?? this.attemptCount,
    nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    inFlightSince: inFlightSince.present
        ? inFlightSince.value
        : this.inFlightSince,
    errorCode: errorCode.present ? errorCode.value : this.errorCode,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  OutboundMessageQueueData copyWithCompanion(
    OutboundMessageQueueCompanion data,
  ) {
    return OutboundMessageQueueData(
      id: data.id.present ? data.id.value : this.id,
      operationType: data.operationType.present
          ? data.operationType.value
          : this.operationType,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      clientMessageId: data.clientMessageId.present
          ? data.clientMessageId.value
          : this.clientMessageId,
      textPayload: data.textPayload.present
          ? data.textPayload.value
          : this.textPayload,
      queueState: data.queueState.present
          ? data.queueState.value
          : this.queueState,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      nextAttemptAt: data.nextAttemptAt.present
          ? data.nextAttemptAt.value
          : this.nextAttemptAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      inFlightSince: data.inFlightSince.present
          ? data.inFlightSince.value
          : this.inFlightSince,
      errorCode: data.errorCode.present ? data.errorCode.value : this.errorCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboundMessageQueueData(')
          ..write('id: $id, ')
          ..write('operationType: $operationType, ')
          ..write('conversationId: $conversationId, ')
          ..write('clientMessageId: $clientMessageId, ')
          ..write('textPayload: $textPayload, ')
          ..write('queueState: $queueState, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('inFlightSince: $inFlightSince, ')
          ..write('errorCode: $errorCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    operationType,
    conversationId,
    clientMessageId,
    textPayload,
    queueState,
    attemptCount,
    nextAttemptAt,
    lastAttemptAt,
    inFlightSince,
    errorCode,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboundMessageQueueData &&
          other.id == this.id &&
          other.operationType == this.operationType &&
          other.conversationId == this.conversationId &&
          other.clientMessageId == this.clientMessageId &&
          other.textPayload == this.textPayload &&
          other.queueState == this.queueState &&
          other.attemptCount == this.attemptCount &&
          other.nextAttemptAt == this.nextAttemptAt &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.inFlightSince == this.inFlightSince &&
          other.errorCode == this.errorCode &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OutboundMessageQueueCompanion
    extends UpdateCompanion<OutboundMessageQueueData> {
  final Value<int> id;
  final Value<String> operationType;
  final Value<String> conversationId;
  final Value<String> clientMessageId;
  final Value<String> textPayload;
  final Value<String> queueState;
  final Value<int> attemptCount;
  final Value<DateTime> nextAttemptAt;
  final Value<DateTime?> lastAttemptAt;
  final Value<DateTime?> inFlightSince;
  final Value<String?> errorCode;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const OutboundMessageQueueCompanion({
    this.id = const Value.absent(),
    this.operationType = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.clientMessageId = const Value.absent(),
    this.textPayload = const Value.absent(),
    this.queueState = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.inFlightSince = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  OutboundMessageQueueCompanion.insert({
    this.id = const Value.absent(),
    this.operationType = const Value.absent(),
    required String conversationId,
    required String clientMessageId,
    required String textPayload,
    required String queueState,
    this.attemptCount = const Value.absent(),
    required DateTime nextAttemptAt,
    this.lastAttemptAt = const Value.absent(),
    this.inFlightSince = const Value.absent(),
    this.errorCode = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : conversationId = Value(conversationId),
       clientMessageId = Value(clientMessageId),
       textPayload = Value(textPayload),
       queueState = Value(queueState),
       nextAttemptAt = Value(nextAttemptAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<OutboundMessageQueueData> custom({
    Expression<int>? id,
    Expression<String>? operationType,
    Expression<String>? conversationId,
    Expression<String>? clientMessageId,
    Expression<String>? textPayload,
    Expression<String>? queueState,
    Expression<int>? attemptCount,
    Expression<DateTime>? nextAttemptAt,
    Expression<DateTime>? lastAttemptAt,
    Expression<DateTime>? inFlightSince,
    Expression<String>? errorCode,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (operationType != null) 'operation_type': operationType,
      if (conversationId != null) 'conversation_id': conversationId,
      if (clientMessageId != null) 'client_message_id': clientMessageId,
      if (textPayload != null) 'text_payload': textPayload,
      if (queueState != null) 'queue_state': queueState,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (nextAttemptAt != null) 'next_attempt_at': nextAttemptAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (inFlightSince != null) 'in_flight_since': inFlightSince,
      if (errorCode != null) 'error_code': errorCode,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  OutboundMessageQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? operationType,
    Value<String>? conversationId,
    Value<String>? clientMessageId,
    Value<String>? textPayload,
    Value<String>? queueState,
    Value<int>? attemptCount,
    Value<DateTime>? nextAttemptAt,
    Value<DateTime?>? lastAttemptAt,
    Value<DateTime?>? inFlightSince,
    Value<String?>? errorCode,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return OutboundMessageQueueCompanion(
      id: id ?? this.id,
      operationType: operationType ?? this.operationType,
      conversationId: conversationId ?? this.conversationId,
      clientMessageId: clientMessageId ?? this.clientMessageId,
      textPayload: textPayload ?? this.textPayload,
      queueState: queueState ?? this.queueState,
      attemptCount: attemptCount ?? this.attemptCount,
      nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      inFlightSince: inFlightSince ?? this.inFlightSince,
      errorCode: errorCode ?? this.errorCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (operationType.present) {
      map['operation_type'] = Variable<String>(operationType.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (clientMessageId.present) {
      map['client_message_id'] = Variable<String>(clientMessageId.value);
    }
    if (textPayload.present) {
      map['text_payload'] = Variable<String>(textPayload.value);
    }
    if (queueState.present) {
      map['queue_state'] = Variable<String>(queueState.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (nextAttemptAt.present) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (inFlightSince.present) {
      map['in_flight_since'] = Variable<DateTime>(inFlightSince.value);
    }
    if (errorCode.present) {
      map['error_code'] = Variable<String>(errorCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboundMessageQueueCompanion(')
          ..write('id: $id, ')
          ..write('operationType: $operationType, ')
          ..write('conversationId: $conversationId, ')
          ..write('clientMessageId: $clientMessageId, ')
          ..write('textPayload: $textPayload, ')
          ..write('queueState: $queueState, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('inFlightSince: $inFlightSince, ')
          ..write('errorCode: $errorCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MessagingSyncMetadataTable extends MessagingSyncMetadata
    with TableInfo<$MessagingSyncMetadataTable, MessagingSyncMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagingSyncMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messaging_sync_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<MessagingSyncMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  MessagingSyncMetadataData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessagingSyncMetadataData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MessagingSyncMetadataTable createAlias(String alias) {
    return $MessagingSyncMetadataTable(attachedDatabase, alias);
  }
}

class MessagingSyncMetadataData extends DataClass
    implements Insertable<MessagingSyncMetadataData> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const MessagingSyncMetadataData({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MessagingSyncMetadataCompanion toCompanion(bool nullToAbsent) {
    return MessagingSyncMetadataCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory MessagingSyncMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessagingSyncMetadataData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MessagingSyncMetadataData copyWith({
    String? key,
    String? value,
    DateTime? updatedAt,
  }) => MessagingSyncMetadataData(
    key: key ?? this.key,
    value: value ?? this.value,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MessagingSyncMetadataData copyWithCompanion(
    MessagingSyncMetadataCompanion data,
  ) {
    return MessagingSyncMetadataData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessagingSyncMetadataData(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessagingSyncMetadataData &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class MessagingSyncMetadataCompanion
    extends UpdateCompanion<MessagingSyncMetadataData> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MessagingSyncMetadataCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagingSyncMetadataCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<MessagingSyncMetadataData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagingSyncMetadataCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MessagingSyncMetadataCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagingSyncMetadataCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$MessagingDatabase extends GeneratedDatabase {
  _$MessagingDatabase(QueryExecutor e) : super(e);
  $MessagingDatabaseManager get managers => $MessagingDatabaseManager(this);
  late final $LocalConversationsTable localConversations =
      $LocalConversationsTable(this);
  late final $LocalMessagesTable localMessages = $LocalMessagesTable(this);
  late final $OutboundMessageQueueTable outboundMessageQueue =
      $OutboundMessageQueueTable(this);
  late final $MessagingSyncMetadataTable messagingSyncMetadata =
      $MessagingSyncMetadataTable(this);
  late final ConversationsDao conversationsDao = ConversationsDao(
    this as MessagingDatabase,
  );
  late final MessagesDao messagesDao = MessagesDao(this as MessagingDatabase);
  late final OutboundQueueDao outboundQueueDao = OutboundQueueDao(
    this as MessagingDatabase,
  );
  late final SyncMetadataDao syncMetadataDao = SyncMetadataDao(
    this as MessagingDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localConversations,
    localMessages,
    outboundMessageQueue,
    messagingSyncMetadata,
  ];
}

typedef $$LocalConversationsTableCreateCompanionBuilder =
    LocalConversationsCompanion Function({
      required String conversationId,
      required String otherParticipantId,
      required String displayName,
      required String username,
      Value<String> avatarInitials,
      Value<String?> avatarUrl,
      Value<bool> isPeerVerified,
      Value<String?> lastMessageId,
      Value<String?> lastMessageClientId,
      Value<String?> lastMessageType,
      Value<String?> lastMessagePreview,
      Value<DateTime?> lastMessageAt,
      Value<int> unreadCount,
      Value<DateTime?> mutedUntil,
      Value<int?> disappearingSeconds,
      Value<bool> canSend,
      Value<bool> isUnavailable,
      Value<bool> isOutgoingPreview,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$LocalConversationsTableUpdateCompanionBuilder =
    LocalConversationsCompanion Function({
      Value<String> conversationId,
      Value<String> otherParticipantId,
      Value<String> displayName,
      Value<String> username,
      Value<String> avatarInitials,
      Value<String?> avatarUrl,
      Value<bool> isPeerVerified,
      Value<String?> lastMessageId,
      Value<String?> lastMessageClientId,
      Value<String?> lastMessageType,
      Value<String?> lastMessagePreview,
      Value<DateTime?> lastMessageAt,
      Value<int> unreadCount,
      Value<DateTime?> mutedUntil,
      Value<int?> disappearingSeconds,
      Value<bool> canSend,
      Value<bool> isUnavailable,
      Value<bool> isOutgoingPreview,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$LocalConversationsTableFilterComposer
    extends Composer<_$MessagingDatabase, $LocalConversationsTable> {
  $$LocalConversationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get otherParticipantId => $composableBuilder(
    column: $table.otherParticipantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarInitials => $composableBuilder(
    column: $table.avatarInitials,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPeerVerified => $composableBuilder(
    column: $table.isPeerVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageId => $composableBuilder(
    column: $table.lastMessageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageClientId => $composableBuilder(
    column: $table.lastMessageClientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageType => $composableBuilder(
    column: $table.lastMessageType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessagePreview => $composableBuilder(
    column: $table.lastMessagePreview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get mutedUntil => $composableBuilder(
    column: $table.mutedUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get disappearingSeconds => $composableBuilder(
    column: $table.disappearingSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canSend => $composableBuilder(
    column: $table.canSend,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUnavailable => $composableBuilder(
    column: $table.isUnavailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOutgoingPreview => $composableBuilder(
    column: $table.isOutgoingPreview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalConversationsTableOrderingComposer
    extends Composer<_$MessagingDatabase, $LocalConversationsTable> {
  $$LocalConversationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get otherParticipantId => $composableBuilder(
    column: $table.otherParticipantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarInitials => $composableBuilder(
    column: $table.avatarInitials,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPeerVerified => $composableBuilder(
    column: $table.isPeerVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageId => $composableBuilder(
    column: $table.lastMessageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageClientId => $composableBuilder(
    column: $table.lastMessageClientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageType => $composableBuilder(
    column: $table.lastMessageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessagePreview => $composableBuilder(
    column: $table.lastMessagePreview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get mutedUntil => $composableBuilder(
    column: $table.mutedUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get disappearingSeconds => $composableBuilder(
    column: $table.disappearingSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canSend => $composableBuilder(
    column: $table.canSend,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUnavailable => $composableBuilder(
    column: $table.isUnavailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOutgoingPreview => $composableBuilder(
    column: $table.isOutgoingPreview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalConversationsTableAnnotationComposer
    extends Composer<_$MessagingDatabase, $LocalConversationsTable> {
  $$LocalConversationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get otherParticipantId => $composableBuilder(
    column: $table.otherParticipantId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get avatarInitials => $composableBuilder(
    column: $table.avatarInitials,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<bool> get isPeerVerified => $composableBuilder(
    column: $table.isPeerVerified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageId => $composableBuilder(
    column: $table.lastMessageId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageClientId => $composableBuilder(
    column: $table.lastMessageClientId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageType => $composableBuilder(
    column: $table.lastMessageType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessagePreview => $composableBuilder(
    column: $table.lastMessagePreview,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get mutedUntil => $composableBuilder(
    column: $table.mutedUntil,
    builder: (column) => column,
  );

  GeneratedColumn<int> get disappearingSeconds => $composableBuilder(
    column: $table.disappearingSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get canSend =>
      $composableBuilder(column: $table.canSend, builder: (column) => column);

  GeneratedColumn<bool> get isUnavailable => $composableBuilder(
    column: $table.isUnavailable,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isOutgoingPreview => $composableBuilder(
    column: $table.isOutgoingPreview,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$LocalConversationsTableTableManager
    extends
        RootTableManager<
          _$MessagingDatabase,
          $LocalConversationsTable,
          LocalConversation,
          $$LocalConversationsTableFilterComposer,
          $$LocalConversationsTableOrderingComposer,
          $$LocalConversationsTableAnnotationComposer,
          $$LocalConversationsTableCreateCompanionBuilder,
          $$LocalConversationsTableUpdateCompanionBuilder,
          (
            LocalConversation,
            BaseReferences<
              _$MessagingDatabase,
              $LocalConversationsTable,
              LocalConversation
            >,
          ),
          LocalConversation,
          PrefetchHooks Function()
        > {
  $$LocalConversationsTableTableManager(
    _$MessagingDatabase db,
    $LocalConversationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalConversationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalConversationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalConversationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> conversationId = const Value.absent(),
                Value<String> otherParticipantId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> avatarInitials = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<bool> isPeerVerified = const Value.absent(),
                Value<String?> lastMessageId = const Value.absent(),
                Value<String?> lastMessageClientId = const Value.absent(),
                Value<String?> lastMessageType = const Value.absent(),
                Value<String?> lastMessagePreview = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<DateTime?> mutedUntil = const Value.absent(),
                Value<int?> disappearingSeconds = const Value.absent(),
                Value<bool> canSend = const Value.absent(),
                Value<bool> isUnavailable = const Value.absent(),
                Value<bool> isOutgoingPreview = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalConversationsCompanion(
                conversationId: conversationId,
                otherParticipantId: otherParticipantId,
                displayName: displayName,
                username: username,
                avatarInitials: avatarInitials,
                avatarUrl: avatarUrl,
                isPeerVerified: isPeerVerified,
                lastMessageId: lastMessageId,
                lastMessageClientId: lastMessageClientId,
                lastMessageType: lastMessageType,
                lastMessagePreview: lastMessagePreview,
                lastMessageAt: lastMessageAt,
                unreadCount: unreadCount,
                mutedUntil: mutedUntil,
                disappearingSeconds: disappearingSeconds,
                canSend: canSend,
                isUnavailable: isUnavailable,
                isOutgoingPreview: isOutgoingPreview,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String conversationId,
                required String otherParticipantId,
                required String displayName,
                required String username,
                Value<String> avatarInitials = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<bool> isPeerVerified = const Value.absent(),
                Value<String?> lastMessageId = const Value.absent(),
                Value<String?> lastMessageClientId = const Value.absent(),
                Value<String?> lastMessageType = const Value.absent(),
                Value<String?> lastMessagePreview = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<DateTime?> mutedUntil = const Value.absent(),
                Value<int?> disappearingSeconds = const Value.absent(),
                Value<bool> canSend = const Value.absent(),
                Value<bool> isUnavailable = const Value.absent(),
                Value<bool> isOutgoingPreview = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalConversationsCompanion.insert(
                conversationId: conversationId,
                otherParticipantId: otherParticipantId,
                displayName: displayName,
                username: username,
                avatarInitials: avatarInitials,
                avatarUrl: avatarUrl,
                isPeerVerified: isPeerVerified,
                lastMessageId: lastMessageId,
                lastMessageClientId: lastMessageClientId,
                lastMessageType: lastMessageType,
                lastMessagePreview: lastMessagePreview,
                lastMessageAt: lastMessageAt,
                unreadCount: unreadCount,
                mutedUntil: mutedUntil,
                disappearingSeconds: disappearingSeconds,
                canSend: canSend,
                isUnavailable: isUnavailable,
                isOutgoingPreview: isOutgoingPreview,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalConversationsTableProcessedTableManager =
    ProcessedTableManager<
      _$MessagingDatabase,
      $LocalConversationsTable,
      LocalConversation,
      $$LocalConversationsTableFilterComposer,
      $$LocalConversationsTableOrderingComposer,
      $$LocalConversationsTableAnnotationComposer,
      $$LocalConversationsTableCreateCompanionBuilder,
      $$LocalConversationsTableUpdateCompanionBuilder,
      (
        LocalConversation,
        BaseReferences<
          _$MessagingDatabase,
          $LocalConversationsTable,
          LocalConversation
        >,
      ),
      LocalConversation,
      PrefetchHooks Function()
    >;
typedef $$LocalMessagesTableCreateCompanionBuilder =
    LocalMessagesCompanion Function({
      Value<int> id,
      Value<String?> serverMessageId,
      required String clientMessageId,
      required String conversationId,
      required String senderId,
      Value<String> messageType,
      required String body,
      required DateTime localCreatedAt,
      Value<DateTime?> serverCreatedAt,
      Value<DateTime?> expiresAt,
      required String deliveryStatus,
      required String syncState,
      Value<String?> errorCode,
      Value<String?> replyToMessageId,
      Value<String?> replyPreview,
      required DateTime lastUpdatedAt,
    });
typedef $$LocalMessagesTableUpdateCompanionBuilder =
    LocalMessagesCompanion Function({
      Value<int> id,
      Value<String?> serverMessageId,
      Value<String> clientMessageId,
      Value<String> conversationId,
      Value<String> senderId,
      Value<String> messageType,
      Value<String> body,
      Value<DateTime> localCreatedAt,
      Value<DateTime?> serverCreatedAt,
      Value<DateTime?> expiresAt,
      Value<String> deliveryStatus,
      Value<String> syncState,
      Value<String?> errorCode,
      Value<String?> replyToMessageId,
      Value<String?> replyPreview,
      Value<DateTime> lastUpdatedAt,
    });

class $$LocalMessagesTableFilterComposer
    extends Composer<_$MessagingDatabase, $LocalMessagesTable> {
  $$LocalMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverMessageId => $composableBuilder(
    column: $table.serverMessageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientMessageId => $composableBuilder(
    column: $table.clientMessageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get localCreatedAt => $composableBuilder(
    column: $table.localCreatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get serverCreatedAt => $composableBuilder(
    column: $table.serverCreatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deliveryStatus => $composableBuilder(
    column: $table.deliveryStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get replyToMessageId => $composableBuilder(
    column: $table.replyToMessageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get replyPreview => $composableBuilder(
    column: $table.replyPreview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalMessagesTableOrderingComposer
    extends Composer<_$MessagingDatabase, $LocalMessagesTable> {
  $$LocalMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverMessageId => $composableBuilder(
    column: $table.serverMessageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientMessageId => $composableBuilder(
    column: $table.clientMessageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get localCreatedAt => $composableBuilder(
    column: $table.localCreatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get serverCreatedAt => $composableBuilder(
    column: $table.serverCreatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deliveryStatus => $composableBuilder(
    column: $table.deliveryStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get replyToMessageId => $composableBuilder(
    column: $table.replyToMessageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get replyPreview => $composableBuilder(
    column: $table.replyPreview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalMessagesTableAnnotationComposer
    extends Composer<_$MessagingDatabase, $LocalMessagesTable> {
  $$LocalMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverMessageId => $composableBuilder(
    column: $table.serverMessageId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clientMessageId => $composableBuilder(
    column: $table.clientMessageId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get senderId =>
      $composableBuilder(column: $table.senderId, builder: (column) => column);

  GeneratedColumn<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get localCreatedAt => $composableBuilder(
    column: $table.localCreatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get serverCreatedAt => $composableBuilder(
    column: $table.serverCreatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<String> get deliveryStatus => $composableBuilder(
    column: $table.deliveryStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<String> get errorCode =>
      $composableBuilder(column: $table.errorCode, builder: (column) => column);

  GeneratedColumn<String> get replyToMessageId => $composableBuilder(
    column: $table.replyToMessageId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get replyPreview => $composableBuilder(
    column: $table.replyPreview,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => column,
  );
}

class $$LocalMessagesTableTableManager
    extends
        RootTableManager<
          _$MessagingDatabase,
          $LocalMessagesTable,
          LocalMessage,
          $$LocalMessagesTableFilterComposer,
          $$LocalMessagesTableOrderingComposer,
          $$LocalMessagesTableAnnotationComposer,
          $$LocalMessagesTableCreateCompanionBuilder,
          $$LocalMessagesTableUpdateCompanionBuilder,
          (
            LocalMessage,
            BaseReferences<
              _$MessagingDatabase,
              $LocalMessagesTable,
              LocalMessage
            >,
          ),
          LocalMessage,
          PrefetchHooks Function()
        > {
  $$LocalMessagesTableTableManager(
    _$MessagingDatabase db,
    $LocalMessagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverMessageId = const Value.absent(),
                Value<String> clientMessageId = const Value.absent(),
                Value<String> conversationId = const Value.absent(),
                Value<String> senderId = const Value.absent(),
                Value<String> messageType = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime> localCreatedAt = const Value.absent(),
                Value<DateTime?> serverCreatedAt = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<String> deliveryStatus = const Value.absent(),
                Value<String> syncState = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<String?> replyToMessageId = const Value.absent(),
                Value<String?> replyPreview = const Value.absent(),
                Value<DateTime> lastUpdatedAt = const Value.absent(),
              }) => LocalMessagesCompanion(
                id: id,
                serverMessageId: serverMessageId,
                clientMessageId: clientMessageId,
                conversationId: conversationId,
                senderId: senderId,
                messageType: messageType,
                body: body,
                localCreatedAt: localCreatedAt,
                serverCreatedAt: serverCreatedAt,
                expiresAt: expiresAt,
                deliveryStatus: deliveryStatus,
                syncState: syncState,
                errorCode: errorCode,
                replyToMessageId: replyToMessageId,
                replyPreview: replyPreview,
                lastUpdatedAt: lastUpdatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverMessageId = const Value.absent(),
                required String clientMessageId,
                required String conversationId,
                required String senderId,
                Value<String> messageType = const Value.absent(),
                required String body,
                required DateTime localCreatedAt,
                Value<DateTime?> serverCreatedAt = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                required String deliveryStatus,
                required String syncState,
                Value<String?> errorCode = const Value.absent(),
                Value<String?> replyToMessageId = const Value.absent(),
                Value<String?> replyPreview = const Value.absent(),
                required DateTime lastUpdatedAt,
              }) => LocalMessagesCompanion.insert(
                id: id,
                serverMessageId: serverMessageId,
                clientMessageId: clientMessageId,
                conversationId: conversationId,
                senderId: senderId,
                messageType: messageType,
                body: body,
                localCreatedAt: localCreatedAt,
                serverCreatedAt: serverCreatedAt,
                expiresAt: expiresAt,
                deliveryStatus: deliveryStatus,
                syncState: syncState,
                errorCode: errorCode,
                replyToMessageId: replyToMessageId,
                replyPreview: replyPreview,
                lastUpdatedAt: lastUpdatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$MessagingDatabase,
      $LocalMessagesTable,
      LocalMessage,
      $$LocalMessagesTableFilterComposer,
      $$LocalMessagesTableOrderingComposer,
      $$LocalMessagesTableAnnotationComposer,
      $$LocalMessagesTableCreateCompanionBuilder,
      $$LocalMessagesTableUpdateCompanionBuilder,
      (
        LocalMessage,
        BaseReferences<_$MessagingDatabase, $LocalMessagesTable, LocalMessage>,
      ),
      LocalMessage,
      PrefetchHooks Function()
    >;
typedef $$OutboundMessageQueueTableCreateCompanionBuilder =
    OutboundMessageQueueCompanion Function({
      Value<int> id,
      Value<String> operationType,
      required String conversationId,
      required String clientMessageId,
      required String textPayload,
      required String queueState,
      Value<int> attemptCount,
      required DateTime nextAttemptAt,
      Value<DateTime?> lastAttemptAt,
      Value<DateTime?> inFlightSince,
      Value<String?> errorCode,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$OutboundMessageQueueTableUpdateCompanionBuilder =
    OutboundMessageQueueCompanion Function({
      Value<int> id,
      Value<String> operationType,
      Value<String> conversationId,
      Value<String> clientMessageId,
      Value<String> textPayload,
      Value<String> queueState,
      Value<int> attemptCount,
      Value<DateTime> nextAttemptAt,
      Value<DateTime?> lastAttemptAt,
      Value<DateTime?> inFlightSince,
      Value<String?> errorCode,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$OutboundMessageQueueTableFilterComposer
    extends Composer<_$MessagingDatabase, $OutboundMessageQueueTable> {
  $$OutboundMessageQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientMessageId => $composableBuilder(
    column: $table.clientMessageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textPayload => $composableBuilder(
    column: $table.textPayload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get queueState => $composableBuilder(
    column: $table.queueState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get inFlightSince => $composableBuilder(
    column: $table.inFlightSince,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OutboundMessageQueueTableOrderingComposer
    extends Composer<_$MessagingDatabase, $OutboundMessageQueueTable> {
  $$OutboundMessageQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientMessageId => $composableBuilder(
    column: $table.clientMessageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textPayload => $composableBuilder(
    column: $table.textPayload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get queueState => $composableBuilder(
    column: $table.queueState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get inFlightSince => $composableBuilder(
    column: $table.inFlightSince,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OutboundMessageQueueTableAnnotationComposer
    extends Composer<_$MessagingDatabase, $OutboundMessageQueueTable> {
  $$OutboundMessageQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clientMessageId => $composableBuilder(
    column: $table.clientMessageId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textPayload => $composableBuilder(
    column: $table.textPayload,
    builder: (column) => column,
  );

  GeneratedColumn<String> get queueState => $composableBuilder(
    column: $table.queueState,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get inFlightSince => $composableBuilder(
    column: $table.inFlightSince,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorCode =>
      $composableBuilder(column: $table.errorCode, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$OutboundMessageQueueTableTableManager
    extends
        RootTableManager<
          _$MessagingDatabase,
          $OutboundMessageQueueTable,
          OutboundMessageQueueData,
          $$OutboundMessageQueueTableFilterComposer,
          $$OutboundMessageQueueTableOrderingComposer,
          $$OutboundMessageQueueTableAnnotationComposer,
          $$OutboundMessageQueueTableCreateCompanionBuilder,
          $$OutboundMessageQueueTableUpdateCompanionBuilder,
          (
            OutboundMessageQueueData,
            BaseReferences<
              _$MessagingDatabase,
              $OutboundMessageQueueTable,
              OutboundMessageQueueData
            >,
          ),
          OutboundMessageQueueData,
          PrefetchHooks Function()
        > {
  $$OutboundMessageQueueTableTableManager(
    _$MessagingDatabase db,
    $OutboundMessageQueueTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutboundMessageQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutboundMessageQueueTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$OutboundMessageQueueTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> operationType = const Value.absent(),
                Value<String> conversationId = const Value.absent(),
                Value<String> clientMessageId = const Value.absent(),
                Value<String> textPayload = const Value.absent(),
                Value<String> queueState = const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
                Value<DateTime> nextAttemptAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> inFlightSince = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => OutboundMessageQueueCompanion(
                id: id,
                operationType: operationType,
                conversationId: conversationId,
                clientMessageId: clientMessageId,
                textPayload: textPayload,
                queueState: queueState,
                attemptCount: attemptCount,
                nextAttemptAt: nextAttemptAt,
                lastAttemptAt: lastAttemptAt,
                inFlightSince: inFlightSince,
                errorCode: errorCode,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> operationType = const Value.absent(),
                required String conversationId,
                required String clientMessageId,
                required String textPayload,
                required String queueState,
                Value<int> attemptCount = const Value.absent(),
                required DateTime nextAttemptAt,
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> inFlightSince = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => OutboundMessageQueueCompanion.insert(
                id: id,
                operationType: operationType,
                conversationId: conversationId,
                clientMessageId: clientMessageId,
                textPayload: textPayload,
                queueState: queueState,
                attemptCount: attemptCount,
                nextAttemptAt: nextAttemptAt,
                lastAttemptAt: lastAttemptAt,
                inFlightSince: inFlightSince,
                errorCode: errorCode,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OutboundMessageQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$MessagingDatabase,
      $OutboundMessageQueueTable,
      OutboundMessageQueueData,
      $$OutboundMessageQueueTableFilterComposer,
      $$OutboundMessageQueueTableOrderingComposer,
      $$OutboundMessageQueueTableAnnotationComposer,
      $$OutboundMessageQueueTableCreateCompanionBuilder,
      $$OutboundMessageQueueTableUpdateCompanionBuilder,
      (
        OutboundMessageQueueData,
        BaseReferences<
          _$MessagingDatabase,
          $OutboundMessageQueueTable,
          OutboundMessageQueueData
        >,
      ),
      OutboundMessageQueueData,
      PrefetchHooks Function()
    >;
typedef $$MessagingSyncMetadataTableCreateCompanionBuilder =
    MessagingSyncMetadataCompanion Function({
      required String key,
      required String value,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MessagingSyncMetadataTableUpdateCompanionBuilder =
    MessagingSyncMetadataCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$MessagingSyncMetadataTableFilterComposer
    extends Composer<_$MessagingDatabase, $MessagingSyncMetadataTable> {
  $$MessagingSyncMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessagingSyncMetadataTableOrderingComposer
    extends Composer<_$MessagingDatabase, $MessagingSyncMetadataTable> {
  $$MessagingSyncMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessagingSyncMetadataTableAnnotationComposer
    extends Composer<_$MessagingDatabase, $MessagingSyncMetadataTable> {
  $$MessagingSyncMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MessagingSyncMetadataTableTableManager
    extends
        RootTableManager<
          _$MessagingDatabase,
          $MessagingSyncMetadataTable,
          MessagingSyncMetadataData,
          $$MessagingSyncMetadataTableFilterComposer,
          $$MessagingSyncMetadataTableOrderingComposer,
          $$MessagingSyncMetadataTableAnnotationComposer,
          $$MessagingSyncMetadataTableCreateCompanionBuilder,
          $$MessagingSyncMetadataTableUpdateCompanionBuilder,
          (
            MessagingSyncMetadataData,
            BaseReferences<
              _$MessagingDatabase,
              $MessagingSyncMetadataTable,
              MessagingSyncMetadataData
            >,
          ),
          MessagingSyncMetadataData,
          PrefetchHooks Function()
        > {
  $$MessagingSyncMetadataTableTableManager(
    _$MessagingDatabase db,
    $MessagingSyncMetadataTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagingSyncMetadataTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MessagingSyncMetadataTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MessagingSyncMetadataTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagingSyncMetadataCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MessagingSyncMetadataCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessagingSyncMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$MessagingDatabase,
      $MessagingSyncMetadataTable,
      MessagingSyncMetadataData,
      $$MessagingSyncMetadataTableFilterComposer,
      $$MessagingSyncMetadataTableOrderingComposer,
      $$MessagingSyncMetadataTableAnnotationComposer,
      $$MessagingSyncMetadataTableCreateCompanionBuilder,
      $$MessagingSyncMetadataTableUpdateCompanionBuilder,
      (
        MessagingSyncMetadataData,
        BaseReferences<
          _$MessagingDatabase,
          $MessagingSyncMetadataTable,
          MessagingSyncMetadataData
        >,
      ),
      MessagingSyncMetadataData,
      PrefetchHooks Function()
    >;

class $MessagingDatabaseManager {
  final _$MessagingDatabase _db;
  $MessagingDatabaseManager(this._db);
  $$LocalConversationsTableTableManager get localConversations =>
      $$LocalConversationsTableTableManager(_db, _db.localConversations);
  $$LocalMessagesTableTableManager get localMessages =>
      $$LocalMessagesTableTableManager(_db, _db.localMessages);
  $$OutboundMessageQueueTableTableManager get outboundMessageQueue =>
      $$OutboundMessageQueueTableTableManager(_db, _db.outboundMessageQueue);
  $$MessagingSyncMetadataTableTableManager get messagingSyncMetadata =>
      $$MessagingSyncMetadataTableTableManager(_db, _db.messagingSyncMetadata);
}
