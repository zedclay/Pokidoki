import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/app_config.dart';
import '../../../data/mock/mock_conversations_repository.dart';
import '../../../data/repositories/conversations_repository.dart';
import '../../authentication/data/auth_providers.dart';
import 'api/api_conversations_repository.dart';
import 'api/messaging_api.dart';
import 'realtime/messaging_socket_coordinator.dart';
import 'realtime/messaging_socket_service.dart';
import '../presentation/controllers/conversations_controller.dart';
import '../presentation/controllers/messaging_controller.dart';

final messagingApiProvider = Provider<MessagingApi>((ref) {
  return MessagingApi(ref.watch(apiClientProvider).dio);
});

final conversationsRepositoryProvider = Provider<ConversationsRepository>((
  ref,
) {
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return const MockConversationsRepository();
  }

  return ApiConversationsRepository(
    messagingApi: ref.watch(messagingApiProvider),
    errorMapper: ref.watch(apiErrorMapperProvider),
    sessionManager: ref.watch(authSessionManagerProvider),
  );
});

final messagingSocketServiceProvider = Provider<MessagingSocketService>((ref) {
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return FakeMessagingSocketService();
  }
  return SocketIoMessagingSocketService();
});

final messagingSocketCoordinatorProvider = Provider<MessagingSocketCoordinator>(
  (ref) {
    final coordinator = MessagingSocketCoordinator(
      socketService: ref.watch(messagingSocketServiceProvider),
      sessionManager: ref.watch(authSessionManagerProvider),
      apiBaseUrl: () => AppConfig.fromEnvironment().apiBaseUrl,
    );
    ref.onDispose(coordinator.dispose);
    return coordinator;
  },
);

final conversationsProvider =
    StateNotifierProvider<ConversationsController, ConversationsState>((ref) {
      return ConversationsController(
        ref.watch(conversationsRepositoryProvider),
      );
    });

final messagingProvider =
    StateNotifierProvider<MessagingController, MessagingState>((ref) {
      return MessagingController(
        ref: ref,
        repository: ref.watch(conversationsRepositoryProvider),
        socketService: ref.watch(messagingSocketServiceProvider),
        socketCoordinator: ref.watch(messagingSocketCoordinatorProvider),
        sessionManager: ref.watch(authSessionManagerProvider),
      );
    });
