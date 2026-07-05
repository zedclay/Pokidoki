import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../../core/network/socket_url.dart';
import 'messaging_socket_events.dart';
import 'messaging_socket_models.dart';

abstract class MessagingSocketService {
  Stream<MessagingSocketStatus> get statusStream;
  Stream<SocketMessageCreatedEvent> get messageCreatedStream;
  Stream<SocketMessageReceiptEvent> get messageDeliveredStream;
  Stream<SocketMessageReceiptEvent> get messageReadStream;
  Stream<SocketConversationUpdatedEvent> get conversationUpdatedStream;
  Stream<SocketConversationSettingsUpdatedEvent>
  get conversationSettingsUpdatedStream;
  Stream<SocketMessageDeletedEvent> get messageDeletedStream;
  Stream<SocketTypingEvent> get typingStartedStream;
  Stream<SocketTypingEvent> get typingStoppedStream;

  MessagingSocketStatus get status;

  Future<void> connect({
    required String accessToken,
    required String apiBaseUrl,
  });

  Future<void> disconnect();

  Future<void> joinConversation(String conversationId);

  Future<void> leaveConversation(String conversationId);

  Future<SocketSendAck> sendMessage({
    required String conversationId,
    required String clientMessageId,
    required String text,
  });

  Future<void> markDelivered(String messageId);

  Future<void> markConversationRead({
    required String conversationId,
    required String throughMessageId,
  });

  Future<void> emitTypingStart(String conversationId);

  Future<void> emitTypingStop(String conversationId);
}

class SocketIoMessagingSocketService implements MessagingSocketService {
  io.Socket? _socket;
  MessagingSocketStatus _status = MessagingSocketStatus.disconnected;

  final _statusController = StreamController<MessagingSocketStatus>.broadcast();
  final _messageCreatedController =
      StreamController<SocketMessageCreatedEvent>.broadcast();
  final _messageDeliveredController =
      StreamController<SocketMessageReceiptEvent>.broadcast();
  final _messageReadController =
      StreamController<SocketMessageReceiptEvent>.broadcast();
  final _conversationUpdatedController =
      StreamController<SocketConversationUpdatedEvent>.broadcast();
  final _conversationSettingsUpdatedController =
      StreamController<SocketConversationSettingsUpdatedEvent>.broadcast();
  final _messageDeletedController =
      StreamController<SocketMessageDeletedEvent>.broadcast();
  final _typingStartedController =
      StreamController<SocketTypingEvent>.broadcast();
  final _typingStoppedController =
      StreamController<SocketTypingEvent>.broadcast();

  String? _joinedConversationId;

  @override
  Stream<MessagingSocketStatus> get statusStream => _statusController.stream;

  @override
  Stream<SocketMessageCreatedEvent> get messageCreatedStream =>
      _messageCreatedController.stream;

  @override
  Stream<SocketMessageReceiptEvent> get messageDeliveredStream =>
      _messageDeliveredController.stream;

  @override
  Stream<SocketMessageReceiptEvent> get messageReadStream =>
      _messageReadController.stream;

  @override
  Stream<SocketConversationUpdatedEvent> get conversationUpdatedStream =>
      _conversationUpdatedController.stream;

  @override
  Stream<SocketConversationSettingsUpdatedEvent>
  get conversationSettingsUpdatedStream =>
      _conversationSettingsUpdatedController.stream;

  @override
  Stream<SocketMessageDeletedEvent> get messageDeletedStream =>
      _messageDeletedController.stream;

  @override
  Stream<SocketTypingEvent> get typingStartedStream =>
      _typingStartedController.stream;

  @override
  Stream<SocketTypingEvent> get typingStoppedStream =>
      _typingStoppedController.stream;

  @override
  MessagingSocketStatus get status => _status;

  void _setStatus(MessagingSocketStatus value) {
    _status = value;
    _statusController.add(value);
  }

  @override
  Future<void> connect({
    required String accessToken,
    required String apiBaseUrl,
  }) async {
    await disconnect();

    if (accessToken.isEmpty) {
      return;
    }

    _setStatus(MessagingSocketStatus.connecting);
    final origin = socketOriginFromApiBaseUrl(apiBaseUrl);

    final socket = io.io(
      '$origin${MessagingSocketEvents.namespace}',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .enableForceNew()
          .setAuth({'token': accessToken})
          .setPath('/socket.io')
          .build(),
    );

    _socket = socket;
    _registerHandlers(socket);

    final completer = Completer<void>();
    void onConnect(_) {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }

    void onError(_) {
      if (!completer.isCompleted) {
        completer.completeError(StateError('Socket connect failed'));
      }
    }

    socket.onConnect(onConnect);
    socket.onConnectError(onError);
    socket.connect();

    try {
      await completer.future.timeout(const Duration(seconds: 10));
      _setStatus(MessagingSocketStatus.connected);
      if (_joinedConversationId != null) {
        await joinConversation(_joinedConversationId!);
      }
    } on Object {
      _setStatus(MessagingSocketStatus.failed);
      await disconnect();
      rethrow;
    } finally {
      socket.off('connect', onConnect);
      socket.off('connect_error', onError);
    }
  }

  void _registerHandlers(io.Socket socket) {
    socket.on(MessagingSocketEvents.messageCreated, (data) {
      if (data is Map) {
        final map = Map<String, dynamic>.from(data);
        final message = map['message'];
        if (message is Map) {
          _messageCreatedController.add(
            SocketMessageCreatedEvent(
              rawMessage: Map<String, dynamic>.from(message),
            ),
          );
        }
      }
    });

    socket.on(MessagingSocketEvents.messageDeliveredEvent, (data) {
      if (data is Map) {
        final map = Map<String, dynamic>.from(data);
        final messageId = map['messageId']?.toString();
        final conversationId = map['conversationId']?.toString();
        final deliveredAt = map['deliveredAt']?.toString();
        if (messageId != null &&
            conversationId != null &&
            deliveredAt != null) {
          _messageDeliveredController.add(
            SocketMessageReceiptEvent(
              messageId: messageId,
              conversationId: conversationId,
              at: DateTime.parse(deliveredAt),
            ),
          );
        }
      }
    });

    socket.on(MessagingSocketEvents.messageRead, (data) {
      if (data is Map) {
        final map = Map<String, dynamic>.from(data);
        final messageId = map['messageId']?.toString();
        final conversationId = map['conversationId']?.toString();
        final readAt = map['readAt']?.toString();
        if (messageId != null && conversationId != null && readAt != null) {
          _messageReadController.add(
            SocketMessageReceiptEvent(
              messageId: messageId,
              conversationId: conversationId,
              at: DateTime.parse(readAt),
            ),
          );
        }
      }
    });

    socket.on(MessagingSocketEvents.conversationUpdated, (data) {
      if (data is Map) {
        final map = Map<String, dynamic>.from(data);
        final conversation = map['conversation'];
        if (conversation is Map) {
          _conversationUpdatedController.add(
            SocketConversationUpdatedEvent(
              rawConversation: Map<String, dynamic>.from(conversation),
            ),
          );
        }
      }
    });

    socket.on(MessagingSocketEvents.conversationSettingsUpdated, (data) {
      if (data is Map) {
        final map = Map<String, dynamic>.from(data);
        final conversationId = map['conversationId']?.toString();
        if (conversationId == null) {
          return;
        }
        final disappearingSeconds = map['disappearingSeconds'];
        final systemMessage = map['systemMessage'];
        _conversationSettingsUpdatedController.add(
          SocketConversationSettingsUpdatedEvent(
            conversationId: conversationId,
            disappearingSeconds: disappearingSeconds is int
                ? disappearingSeconds
                : int.tryParse(disappearingSeconds?.toString() ?? ''),
            rawSystemMessage: systemMessage is Map
                ? Map<String, dynamic>.from(systemMessage)
                : null,
          ),
        );
      }
    });

    socket.on(MessagingSocketEvents.messageDeleted, (data) {
      if (data is Map) {
        final map = Map<String, dynamic>.from(data);
        final messageId = map['messageId']?.toString();
        final conversationId = map['conversationId']?.toString();
        if (messageId != null && conversationId != null) {
          _messageDeletedController.add(
            SocketMessageDeletedEvent(
              messageId: messageId,
              conversationId: conversationId,
            ),
          );
        }
      }
    });

    socket.on(MessagingSocketEvents.typingStarted, (data) {
      if (data is Map) {
        final map = Map<String, dynamic>.from(data);
        final conversationId = map['conversationId']?.toString();
        final userId = map['userId']?.toString();
        if (conversationId != null && userId != null) {
          _typingStartedController.add(
            SocketTypingEvent(conversationId: conversationId, userId: userId),
          );
        }
      }
    });

    socket.on(MessagingSocketEvents.typingStopped, (data) {
      if (data is Map) {
        final map = Map<String, dynamic>.from(data);
        final conversationId = map['conversationId']?.toString();
        final userId = map['userId']?.toString();
        if (conversationId != null && userId != null) {
          _typingStoppedController.add(
            SocketTypingEvent(conversationId: conversationId, userId: userId),
          );
        }
      }
    });

    socket.onDisconnect((_) {
      if (_status != MessagingSocketStatus.disconnected) {
        _setStatus(MessagingSocketStatus.reconnecting);
      }
    });
  }

  Future<Map<String, dynamic>> _emitAck(
    String event,
    Map<String, dynamic> payload,
  ) async {
    final socket = _socket;
    if (socket == null || !socket.connected) {
      return {'ok': false, 'code': 'WEBSOCKET_UNAUTHORIZED'};
    }

    final completer = Completer<Map<String, dynamic>>();
    socket.emitWithAck(
      event,
      payload,
      ack: (response) {
        if (response is Map) {
          completer.complete(Map<String, dynamic>.from(response));
        } else {
          completer.complete({'ok': false, 'code': 'MESSAGE_INVALID'});
        }
      },
    );

    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () => {'ok': false, 'code': 'WEBSOCKET_UNAUTHORIZED'},
    );
  }

  @override
  Future<void> disconnect() async {
    _setStatus(MessagingSocketStatus.disconnected);
    _socket?.dispose();
    _socket = null;
  }

  @override
  Future<void> joinConversation(String conversationId) async {
    _joinedConversationId = conversationId;
    await _emitAck(MessagingSocketEvents.conversationJoin, {
      'conversationId': conversationId,
    });
  }

  @override
  Future<void> leaveConversation(String conversationId) async {
    if (_joinedConversationId == conversationId) {
      _joinedConversationId = null;
    }
    await _emitAck(MessagingSocketEvents.conversationLeave, {
      'conversationId': conversationId,
    });
  }

  @override
  Future<SocketSendAck> sendMessage({
    required String conversationId,
    required String clientMessageId,
    required String text,
  }) async {
    final response = await _emitAck(MessagingSocketEvents.messageSend, {
      'conversationId': conversationId,
      'clientMessageId': clientMessageId,
      'text': text,
    });
    return SocketSendAck.fromJson(response);
  }

  @override
  Future<void> markDelivered(String messageId) async {
    await _emitAck(MessagingSocketEvents.messageDelivered, {
      'messageId': messageId,
    });
  }

  @override
  Future<void> markConversationRead({
    required String conversationId,
    required String throughMessageId,
  }) async {
    await _emitAck(MessagingSocketEvents.conversationRead, {
      'conversationId': conversationId,
      'throughMessageId': throughMessageId,
    });
  }

  @override
  Future<void> emitTypingStart(String conversationId) async {
    await _emitAck(MessagingSocketEvents.typingStart, {
      'conversationId': conversationId,
    });
  }

  @override
  Future<void> emitTypingStop(String conversationId) async {
    await _emitAck(MessagingSocketEvents.typingStop, {
      'conversationId': conversationId,
    });
  }
}

class FakeMessagingSocketService implements MessagingSocketService {
  FakeMessagingSocketService();

  bool failNextSend = false;
  final Set<String> _seenEventIds = {};

  MessagingSocketStatus _status = MessagingSocketStatus.disconnected;

  final _statusController = StreamController<MessagingSocketStatus>.broadcast();
  final _messageCreatedController =
      StreamController<SocketMessageCreatedEvent>.broadcast();
  final _messageDeliveredController =
      StreamController<SocketMessageReceiptEvent>.broadcast();
  final _messageReadController =
      StreamController<SocketMessageReceiptEvent>.broadcast();
  final _conversationUpdatedController =
      StreamController<SocketConversationUpdatedEvent>.broadcast();
  final _conversationSettingsUpdatedController =
      StreamController<SocketConversationSettingsUpdatedEvent>.broadcast();
  final _messageDeletedController =
      StreamController<SocketMessageDeletedEvent>.broadcast();
  final _typingStartedController =
      StreamController<SocketTypingEvent>.broadcast();
  final _typingStoppedController =
      StreamController<SocketTypingEvent>.broadcast();

  @override
  MessagingSocketStatus get status => _status;

  @override
  Stream<MessagingSocketStatus> get statusStream => _statusController.stream;

  @override
  Stream<SocketMessageCreatedEvent> get messageCreatedStream =>
      _messageCreatedController.stream;

  @override
  Stream<SocketMessageReceiptEvent> get messageDeliveredStream =>
      _messageDeliveredController.stream;

  @override
  Stream<SocketMessageReceiptEvent> get messageReadStream =>
      _messageReadController.stream;

  @override
  Stream<SocketConversationUpdatedEvent> get conversationUpdatedStream =>
      _conversationUpdatedController.stream;

  @override
  Stream<SocketConversationSettingsUpdatedEvent>
  get conversationSettingsUpdatedStream =>
      _conversationSettingsUpdatedController.stream;

  @override
  Stream<SocketMessageDeletedEvent> get messageDeletedStream =>
      _messageDeletedController.stream;

  @override
  Stream<SocketTypingEvent> get typingStartedStream =>
      _typingStartedController.stream;

  @override
  Stream<SocketTypingEvent> get typingStoppedStream =>
      _typingStoppedController.stream;

  @override
  Future<void> connect({
    required String accessToken,
    required String apiBaseUrl,
  }) async {
    if (accessToken.isEmpty) {
      _status = MessagingSocketStatus.disconnected;
      _statusController.add(_status);
      return;
    }
    _status = MessagingSocketStatus.connected;
    _statusController.add(_status);
  }

  @override
  Future<void> disconnect() async {
    _status = MessagingSocketStatus.disconnected;
    _statusController.add(_status);
  }

  @override
  Future<void> joinConversation(String conversationId) async {}

  @override
  Future<void> leaveConversation(String conversationId) async {}

  @override
  Future<SocketSendAck> sendMessage({
    required String conversationId,
    required String clientMessageId,
    required String text,
  }) async {
    if (failNextSend) {
      failNextSend = false;
      return const SocketSendAck(ok: false, code: 'MESSAGE_SEND_NOT_ALLOWED');
    }
    return SocketSendAck(
      ok: true,
      rawMessage: {
        'id': 'mock-$clientMessageId',
        'conversationId': conversationId,
        'clientMessageId': clientMessageId,
        'body': text,
        'type': 'TEXT',
        'createdAt': DateTime.now().toUtc().toIso8601String(),
        'sender': {
          'userId': 'user-self',
          'displayName': 'Self',
          'username': 'self',
          'publicId': 'PKD-TEST-TEST',
          'avatarInitials': 'S',
        },
        'senderStatus': 'sent',
      },
    );
  }

  void emitMessageCreated(Map<String, dynamic> rawMessage) {
    final id = rawMessage['id'] as String;
    if (_seenEventIds.contains(id)) {
      return;
    }
    _seenEventIds.add(id);
    _messageCreatedController.add(
      SocketMessageCreatedEvent(rawMessage: rawMessage),
    );
  }

  @override
  Future<void> markDelivered(String messageId) async {}

  @override
  Future<void> markConversationRead({
    required String conversationId,
    required String throughMessageId,
  }) async {}

  @override
  Future<void> emitTypingStart(String conversationId) async {}

  @override
  Future<void> emitTypingStop(String conversationId) async {}
}
