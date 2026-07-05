import 'dart:async';

import '../../../../core/network/auth_session_manager.dart';
import 'messaging_socket_models.dart';
import 'messaging_socket_service.dart';

class MessagingSocketCoordinator {
  MessagingSocketCoordinator({
    required MessagingSocketService socketService,
    required AuthSessionManager sessionManager,
    required String Function() apiBaseUrl,
  }) : _socketService = socketService,
       _sessionManager = sessionManager,
       _apiBaseUrl = apiBaseUrl {
    _tokenListener = (token) {
      if (token == null || token.isEmpty) {
        unawaited(disconnect());
        return;
      }
      unawaited(reconnect());
    };
    _sessionManager.addAccessTokenListener(_tokenListener);
  }

  final MessagingSocketService _socketService;
  final AuthSessionManager _sessionManager;
  final String Function() _apiBaseUrl;
  late final AccessTokenListener _tokenListener;

  String? _activeConversationId;
  int _reconnectAttempt = 0;
  Timer? _reconnectTimer;
  bool _disposed = false;

  MessagingSocketService get socketService => _socketService;

  Future<void> connectIfAuthenticated() async {
    final token = _sessionManager.accessToken;
    if (token == null || token.isEmpty) {
      return;
    }
    await _socketService.connect(accessToken: token, apiBaseUrl: _apiBaseUrl());
    _reconnectAttempt = 0;
  }

  Future<void> reconnect() async {
    if (_disposed) {
      return;
    }
    await _socketService.disconnect();
    await connectIfAuthenticated();
    final active = _activeConversationId;
    if (active != null) {
      await _socketService.joinConversation(active);
    }
  }

  Future<void> disconnect() async {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    await _socketService.disconnect();
  }

  Future<void> setActiveConversation(String? conversationId) async {
    final previous = _activeConversationId;
    if (previous != null && previous != conversationId) {
      await _socketService.leaveConversation(previous);
    }
    _activeConversationId = conversationId;
    if (conversationId != null &&
        _socketService.status == MessagingSocketStatus.connected) {
      await _socketService.joinConversation(conversationId);
    }
  }

  void scheduleReconnect() {
    if (_disposed || !_sessionManager.hasAccessToken) {
      return;
    }
    _reconnectTimer?.cancel();
    final delayMs = [
      1000,
      2000,
      4000,
      8000,
      15000,
    ][_reconnectAttempt.clamp(0, 4)];
    _reconnectAttempt += 1;
    _reconnectTimer = Timer(Duration(milliseconds: delayMs), () {
      unawaited(reconnect());
    });
  }

  void dispose() {
    _disposed = true;
    _sessionManager.removeAccessTokenListener(_tokenListener);
    _reconnectTimer?.cancel();
    unawaited(disconnect());
  }
}
